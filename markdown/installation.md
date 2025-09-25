<h1 style="text-align: center;">Jumper Media Analytics</h1>

<p align="center">
  <img src="../assets/others/jumper_media_layout.png" alt="Description" width="300"/>
</p>

# Installation Manual

**Clone the Repository:**

  * Using SSH:  

    ```bash
    git clone git@github.com:abel-blue/jumper-analytics.git
    ```
  * Using HTTPS:  

    ```bash
    git clone https://github.com/abel-blue/jumper-analytics.git
    ```

**Navigate into the `jumper-analytics` Directory:**

  ```bash
  cd jumper-analytics
  ```

### Environment Setup

- In both the `backend/` and `frontend/` directories, rename the file `.env_sample` to `.env`

## For macOS & linux

**Grant Execution Permissions:**

  * Give execution rights to the installation shell script:

    ```bash
    chmod 777 init_jumper_analytics.sh
    ```

**Run the Installation Script:**

  * Start Docker Dameon & Execute the installation script to set up the system:

    ```bash
    ./init_jumper_analytics.sh
    ```
* You can now access the backend at **http://0.0.0.0:8000** and the frontend at **http://0.0.0.0:3000** to open the dashboard.

### Binaries

**Get the Binary Stable Build for Shipment:**

  * Grant execution permissions and run the script to generate the binaries:

    ```bash
    chmod 777 convert_to_binaries.sh
    ./convert_to_binaries.sh
    ```

  * After running the script, you can find the binary build for  macos & linux in `bin/arm64.zip`

## For windows

**Run the Installation Batch Script:**

  * Start Docker Dameon & Execute the installation batch script to set up the system:

    ```bash
    .\init_jumper_analytics.bat
    ```
* You can now access the backend at **http://0.0.0.0:8000** and the frontend at **http://0.0.0.0:3000** to open the dashboard.

### Binaries

**Get the Binary Stable Build for Shipment:**

  * Generate the binaries by running the batch file:

    ```bash
    .\convert_to_binaries.bat
    ```
      
  * After running the script, you can find the binary build for  Windows in `bin/win.zip`
  