# XMRig Service Injection in PowerShell - Crypto Hijacking

## XMRig Service Installer

This script sets up the `xmrig` mining software to run as a service on a Windows machine. The primary function is to ease the installation process of the miner and configure it to run in the background as a service, which can be beneficial for system administrators or researchers working with the `xmrig` software.

## **Disclaimer**

This script is developed for educational and research purposes only. It is intended to demonstrate how to run an application (in this case, the `xmrig` mining software) as a service on a Windows machine.

**By using this code, you agree to the following:**

1. You will not use this code, in whole or in part, for malicious intent, including but not limited to unauthorized mining on third-party systems.
2. You will seek explicit permission from any and all system owners before running or deploying this code.
3. You understand the implications of running mining software on hardware, including the potential for increased wear and power consumption.
4. The creator of this script cannot and will not be held responsible for any damages, repercussions, or any negative outcomes that result from using this script.

If you do not agree to these terms, please do not use or distribute this code.

## Prerequisites

- Powershell with Administrator rights
- Internet connection (to download required files)
## Requirements

- xmrig miner - [xmrig/xmrig: RandomX, KawPow, CryptoNight and GhostRider unified CPU/GPU miner and RandomX benchmark (github.com)](https://github.com/xmrig/xmrig)
- NSSM -  [NSSM - the Non-Sucking Service Manager](https://nssm.cc/download)
- Create a FTP Server in a Docker container and add `xmrig.exe`, `config.json`, and `nssm.exe` to the FTP Server
## How the Script Works

1. **Administrator Check**: The script begins by ensuring that it is run with Administrator rights.
2. **Cleanup**: If there are previous installations of `xmrig` or related files in the specified paths, they are removed.
3. **Download**: Files essential for the miner to function, like `xmrig.exe`, `config.json`, and `nssm.exe`, are downloaded from the specified FTP server.
4. **Setup**: The downloaded files are moved to their appropriate directories.
5. **Service Creation**: Using `nssm`, the script sets up `xmrig` as a service that runs in the background and starts automatically on system startup.
6. **Logging**: The script configures the service to write its logs to a specified file.
7. **Cleanup**: Finally, the script file itself is deleted as a cleanup step.

## Usage

1. Modify the FTP server URLs in the script to point to your actual server containing the `xmrig`, `config.json`, and `nssm.exe` files.
2. Run the script with Administrator rights.

## Uploaded Photos

### FTP server:

![Pasted image 20231015212444](https://github.com/yaron4u/XMRig-Service-Injection-in-PowerShell---Crypto-Hijacking/assets/67191566/feccaafb-aa2e-4bf8-a1ff-7cb934ad25e9)

### After running the script:

![Pasted image 20231015212333](https://github.com/yaron4u/XMRig-Service-Injection-in-PowerShell---Crypto-Hijacking/assets/67191566/93c724a1-a2ad-4e4e-af69-1504671cf813)
