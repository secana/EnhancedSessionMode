# Enhanced Session Mode

Contains scripts to enable "Hyper-V Enhanced Session Mode" for Linux

## Fedora & CentOS

This tutorial shows how to install and configure **Enhanced Session Mode** on **Fedora**. The script was not tested on older Fedora versions than 29.

Form more information have a look at the corresponding blog post for [Enhanced Session Mode under Fedora 28](https://secanablog.wordpress.com/2018/10/24/enhanced-session-mode-under-fedora-28/).

Supported are currently:

- CentOS 7
- Fedora 29 - 33

### Clone repository

First, clone this repository to your **Fedora** machine and change into the directory.

```bash
git clone https://github.com/secana/EnhancedSessionMode.git
cd EnhancedSessionMode
```

### Install & configure XRDP

Run the script to install and configure **XRDP**. This may take some time and you need **sudo** rights on your machine.

```bash
# CentOS 7 or Fedora 29/30/31/32/33
# For Fedora 32 and up there is just one script as it works on all verions
source /etc/os-release
./install_esm_${ID}${VERSION_ID}.sh
```

After the scripts ran successfully, shutdown your **Fedora** VM.

### Enable XRDP for your VM

On your Windows host system, open a **elevated PowerShell** (with administrator rights) and type enter the command below. Replace the name of the VM with the name of the **Fedora VM** on your hosts.

```powershell
Set-VM -VMName "Fedora VM Name" -EnhancedSessionTransportType HvSocket
```

Now, start your **Fedora** VM and the UI to configure the enhanced session mode should pop up. Make sure you uncheck _Printers_ in the _Show Options --> Local Resources_ and save your setting.

### GDM dependency

Don't disable GDM or RDP login won't work
