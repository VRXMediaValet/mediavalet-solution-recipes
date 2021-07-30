#read your secure password from config file
$configuration = Get-Content $PSScriptRoot/config.json -ErrorAction Stop | ConvertFrom-Json -ErrorAction Stop
$pass = ConvertTo-SecureString -String $configuration.Password -AsPlainText -Force

#Connect to your DAM account {your account user name}
Connect-MvDamAccount -Username "{your DAM library username}" -Region “{your DAM library region}” -Password $pass

#Get current library
Get-MvDamContext

#Runs a simple test pre-requisite step before starting upload.
#Parameters needed UploadHotJobFolder, DestSasUri and ParentCategoryPath(optional)
Test-MvHotfolderUploadCheck -UploadHotJobFolder “{file path to uploaded job folder}” -DestSasUri “{valid sas Uri of blob storage account}” -ParentCategoryPath
“{DAM library category path to map}”

#Execute the Power DAM cmdlet for moving assets to blob storage.
#Parameters needed HotJobFolder, UploadHotJobFolder, DestSasUri, ParentCategoryPath(optional, defaults to \root) and NotificationScriptPath(optional)
Import-MvDamAssetsFromHotfolder -HotJobFolder “{file path to hot job folder}” -UploadHotJobFolder “{file path to uploaded job folder}” -DestSasUri “{valid sas Uri of blob storage account}” -ParentCategoryPath “{DAM library category path to map}” – NotificationScriptPath “{path to power automate notification script}”

#Disconnect from current library
Disconnect-MvDamAccount