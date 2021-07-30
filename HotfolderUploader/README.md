
### Overview
* What is Hotfolder Uploader?
  
 MediaValet is providing IT pros, DAM consultants, admins and power users with a set of PowerShell Cmdlets that will ease their day to day tasks of uploading assets from a hot folder server path to Azure blob storage through the powerful command line scripting tool.
 This task can be scheduled with the help of a task scheduler and forgotten to execute automatically for copying of assets through scheduled trigger
 

### Quickstart	
--- 
#### Prerequisites
*	Install Powershell core v 7.1.3 on allocated machine. Follow the Getting Started section of PowerShell for MediaValet guide [here](https://powershell.mediavalet.com/).
*	Install [Azcopy](https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10) and [Az.Storage](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-6.2.1) powershell modules on allocated machine.
Az.Storage PowerShell modules can be installed from PowerShell using below command:
```
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery –Force
```
*	An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
*	An Azure storage container account with a blob container for uploading of assets from hot folder.[https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal)

#### Storage account
*	If you already have a blob container for assets upload, skip this section and continue to setup your hot folder uploader.
*	If you don't yet have an azure blob container account, create one now: 

[https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal)

#### Azcopy command setup
Once you have downloaded azcopy.exe on your system add the path of azcopy.exe file to path variable under system variables section of environment variables; so that you can execute the command from windows power shell.
Steps to setting up of path are shown in below screenshots:

![](/mediavalet-solution-recipes/assets/images/azcopy1.png)

![](/mediavalet-solution-recipes/assets/images/azcopy4.png)

![](/mediavalet-solution-recipes/assets/images/azcopy2.png)	

After adding path variable execute `Test-MvAzCopyVersion` command and see whether media valet powershell command to validate azcopy.exe returns true as shown below:

![](/mediavalet-solution-recipes/assets/images/azcopy3.png)

#### PowerShell core setup	
Please validate that you have PowerShell v7.1.3 installed on your macine, instructions to validate can be found [here](https://powershell.mediavalet.com/).

![](/mediavalet-solution-recipes/assets/images/powershell1.png)

![](/mediavalet-solution-recipes/assets/images/powershell2.png)		

![](/mediavalet-solution-recipes/assets/images/powershell3.png)

![](/mediavalet-solution-recipes/assets/images/powershell4.png)		

![](/mediavalet-solution-recipes/assets/images/powershell5.png)

Also run the command `$PSVersionTable.PSVersion` on windows powershell and validate whether powershell version 5.1 is currently installed:

![](/mediavalet-solution-recipes/assets/images/powershell6.png)

![](/mediavalet-solution-recipes/assets/images/powershell7.png)

#### Notification Setup
A sysadmin can also create an email notification through PowerAutomate via an HTTP trigger. This could effectively be any type of notification mechanism but an HTTP trigger is the easiest one to setup and test. A sysadmin can pass the notification script as a parameter by path in case he wants to be notified for tasks not completed.

***For example***, powerautomatenotify.ps1 can be written by the admin to use PowerAutomate. The cmdlet will Invoke-Command the script and pass the error info as a default parameter.

### Getting started
Next step would be to setup hotfolder uploader folder on your server and to import the DAM library category path in it. A sysadmin need to connect to MV DAM account before running `Initialize-MvHotfolderUploadJob` cmdlet. Importing of root path from your DAM library is automated and can be executed independently using `Initialize-MvHotfolderUploadJob` cmdlet.

Initialize-MvHotfolderUploadJob cmdlet takes three parameters `HotJobFolder`, `UploadHotJobFolder`, `DestSasUri` and `ParentCategoryPath (optional)`

You can setup the hot folder at any location of your choice on your server and copy the assets for uploading at the hot folder path. On execution of the Power Dam cmdlet your assets will automatically be uploaded on blob container. 

On successful execution of uploads your assets will be archived and moved to Uploaded job folder path on the server along with the logs.


### Manual and Scheduled Uploads
Since all these are Power DAM cmdlets we provide you with a choice either to manually or automatically execute uploading of assets to azure blob storage container. 

***Manual uploads***

You can manually execute `Import-MvDamAssetsFromHotFolder` power cmdlet from your powershell core window whenever needed; 

Import-MvDamAssetsFromHotFolder cmdlet takes parameters `HotJobFolder`, `UploadHotJobFolder`, `DestSasUri`, `ParentCategoryPath (optional)` and  `NotificationScriptPath  (optional)`

OR

***Scheduled uploads***

You can automate the process by scheduling the task to be executed at a later time of day and ease the activity of monitoring a hot job folder for any new assets to be uploaded by creating a task scheduler to monitor the hot folder path.

**NOTE:-** Assets should be present in your hotfolder path before the script `Import-MvDamAssetsFromHotfolder` gets triggered by the task scheduler at the defined triggered time.
