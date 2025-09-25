from typing import AsyncGenerator
from fastapi import HTTPException
from dotenv import load_dotenv
import os
import aiomysql
load_dotenv()
from typing import AsyncGenerator
from fastapi import HTTPException
import os
import asyncpg
from app.core.config import logger_settings, Settings
logger = logger_settings.get_logger(__name__)
from typing import Optional, List, Dict, Tuple
from datetime import datetime
from app.sql.main import SqlQuery
from asyncpg import Connection, Pool


class AuthDatabaseService:
    @staticmethod
    async def connection():
        """
        Establishes a connection to the PostgreSQL database using asyncpg.
        Ensures the database exists, creating it if necessary.
        Returns:
            connection: asyncpg connection object.
        """
        try:
            # Connect to Postgres without specifying a database first
            initial_connection = await asyncpg.connect(
                host=logger_settings.AUTH_DB_HOST,
                user=logger_settings.AUTH_DB_USER,
                password=logger_settings.AUTH_DB_PASSWORD,
                port=int(logger_settings.AUTH_DB_PORT),
                database='postgres'  # default database
            )

            db_name = logger_settings.AUTH_DB
            # Check if database exists
            db_exists = await initial_connection.fetchval(
                "SELECT 1 FROM pg_database WHERE datname=$1", db_name
            )
            if not db_exists:
                await initial_connection.execute(f'CREATE DATABASE "{db_name}"')
                print(f"Database '{db_name}' created successfully.")

            await initial_connection.close()

            # Reconnect to the specified database
            connection = await asyncpg.connect(
                host=logger_settings.AUTH_DB_HOST,
                user=logger_settings.AUTH_DB_USER,
                password=logger_settings.AUTH_DB_PASSWORD,
                database=db_name,
                port=int(logger_settings.AUTH_DB_PORT)
            )
            return connection

        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error connecting to the database: {e}")

    @staticmethod
    async def get_db() -> AsyncGenerator[asyncpg.Connection, None]:
        """
        Provides an async database connection to FastAPI endpoints.
        Yields:
            asyncpg.Connection: Postgres connection instance.
        """
        connection = await AuthDatabaseService.connection()
        try:
            yield connection
        except Exception as e:
            raise RuntimeError(f"Session error: {e}")
        finally:
            await connection.close()

    _pool: Pool = None
    @classmethod
    async def get_pool(cls) -> Pool:
        if cls._pool is None:
            cls._pool = await asyncpg.create_pool(
                host=logger_settings.AUTH_DB_HOST,
                user=logger_settings.AUTH_DB_USER,
                password=logger_settings.AUTH_DB_PASSWORD,
                database=logger_settings.AUTH_DB,
                port=logger_settings.AUTH_DB_PORT,
                min_size=1,
                max_size=10
            )
        return cls._pool

    @staticmethod
    async def ping_database():
        """
        Pings the database to check if the connection is active.
        Returns:
            bool: True if the connection is successful, False otherwise.
        """
        try:
            connection = await AuthDatabaseService.connection()
            result = await connection.fetchval("SELECT 1")
            return result == 1
        except Exception:
            return False
        finally:
            await connection.close()

    @staticmethod
    async def auth_shutdown():
        """
        Close the Postgres connection during shutdown.
        """
        connection = await AuthDatabaseService.connection()
        await connection.close()
    
    @staticmethod
    async def ensure_auth_table_exists():
        """
        Checks if the `auth_users` table exists and creates it if it doesn't exist.
        """
        
        create_schema_query = await SqlQuery.read_sql("com/jumper/auth/create_schema")
        create_table_query = await SqlQuery.read_sql("com/jumper/auth/create_auth_users_table")
        
        try:
            connection = await AuthDatabaseService.connection()
            # Create schema
            await connection.execute(create_schema_query)
            # Create table inside schema
            await connection.execute(create_table_query)
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error ensuring table exists: {e}")
        finally:
            await connection.close()

    @staticmethod
    async def ensure_data_exists():
        """
        Checks if the `records` schema exist and creates them if needed.
        """        
        try:
            connection = await AuthDatabaseService.connection()
            
            # Schema & Table creation
            create_table_files = [
                await SqlQuery.read_sql("com/jumper/data/create_schema"),
                await SqlQuery.read_sql("com/jumper/data/authors"),
                await SqlQuery.read_sql("com/jumper/data/posts"),
                await SqlQuery.read_sql("com/jumper/data/engagements"),
                await SqlQuery.read_sql("com/jumper/data/post_metadata"),
                await SqlQuery.read_sql("com/jumper/data/users")
            ]
            
            for query in create_table_files:
                if query:
                    await connection.execute(query)

            insert_data_files = [
                ("authors", await SqlQuery.read_sql("com/jumper/data/insert/authors_data")),
                ("posts", await SqlQuery.read_sql("com/jumper/data/insert/posts_data")),
                ("users", await SqlQuery.read_sql("com/jumper/data/insert/users_data")),
                ("engagements", await SqlQuery.read_sql("com/jumper/data/insert/engagements_data")),
                ("post_metadata", await SqlQuery.read_sql("com/jumper/data/insert/post_metadata_data"))
            ]
            
            for table_name, query in insert_data_files:
                count = await connection.fetchval(f"SELECT COUNT(*) FROM records.{table_name};")
                if count > 0:
                    # logger.info(f"Table '{table_name}' already has data. Skipping insert.")
                    continue

                if query:
                    await connection.execute(query)
                    logger.info(f"Inserted data from {query} into {table_name}")

            logger.info(f"Ensured all data tables exist in the database.")
            
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"Error ensuring table exists: {e}")
        finally:
            await connection.close()
            
