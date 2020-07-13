# Packer Oracle Virtual Box Box
This repository describes how to create a Virtual Box box file for use with Vagrant.

This box is fully updated (although this can be changed through the Autounattend.xml file)

## What you will need

    - The latest version of Packer (https://www.packer.io/downloads.html)
    - A Windows Server 2016 ISO
    - A decent text editor (I recommend Visual Studio Code (its free and very powerful))
    - Some knowledge about Packer, JSON and PowerShell (this document will attempt to explain everything)
    - Time, building a box takes hours,  SERIOUSLY, this is not a joke,  it takes Hours.

## Important files

answer_files/2016	This folder contains the Windows Server Autounattend answer file.  This XML file is used by to automate the installation of Windows Server.
iso	Put your Windows Server 2016 ISO file in this folder.
scripts	This folder has a number of scripts that can be provisioned during the creation of the Box file.  You can either add new scripts or edit existing ones.  For example if you wanted a particular application installed this is where you would put the script.
windows_2016.json	This JSON file is used by Packer to generate the box.

## Chocolatey Package Manager

The base code for this solution includes Chocolatey (https://chocolatey.org/), which is a fantastic package manager for Windows server,  if you’re in any way familiar with Linux think apt-get or yum.  Using Chocolatey you can install software quickly without needing to download the program first.  Add any software you want into the script /scripts/chocopacks.bat.  In the below image 7zip, notepad++, Chrome, Firefox and Java Run Time are being installed.  This allows these applications to be present on every Virtual Machine that will use this box. Use https://chocolately.org to find package names, or create a PowerShell script yourself to install any software.

## Windows License
Add your Windows License to the provisioning by editing the file /packer-windows/answer_files/2016/Autounattend.xml.  Search for <Product Key> and uncomment the <!--<Key>XXXX.  Remove <!-- and --> from the line and add your Product key as it is provided by Microsoft.
	
## Basic Steps

Open the file win2k16.json and browse to the variable section.
You need to change the ISO_URL to be the correct path and file name, I store it in the ISO folder above, so you can too!
Change your checksum, you will need to get the checksum from the ISO image. Google is your friend, use MD5sum or something you like to get checksums.

From command prompt (or hopefully PowerShell, bash) browse to the packer folder.

The build has been broken down into multiple stages to speed up rebuilds, run the following commands to execute all build stages.

```sh
# we need to provide -var-file as packer doesn't seem to load it automatically in the current version
./packer.exe build -only=null -var-file="config.auto.pkrvars.json" win2k16.json
# the next stage is usually the slowest as there are many windows updates to apply
./packer.exe build -only=virtualbox-iso win2k16.json
# finally, we apply our customisations
./packer.exe build -only=virtualbox-ovf win2k16.json
```

Now just sit back and wait, or do some other work.. This will take HOURS.
The output of this will be the file Win2k16-virtualbox.box, when updating the image you should increment the version in metadata.json.
Import the box into vagrant using the command `vagrant box add --name qlik/win2k16 Win2k16-virtualbox.box`.
