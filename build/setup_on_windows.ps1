# Setup the local environment for the project
# Written and tested for Windows 10, it should work in Windows 2019 as well.
# INSTRUCTIONS: copy in the root folder for the source code (e.g. C:\Source) togheter with the 
##				companion config.psvars file. Update the configuration in the latter, and the run
#				this script. It will create a local repo.
#				It aims to install the software required to build and develop the project. 
# CAVEAT: 		The script aims to be idempotent. 

# read the content of the configuration variables from a configuration file
Get-Content .\config.psvars | Where-Object {$_.length -gt 0} | Where-Object {!$_.StartsWith("#")} | ForEach-Object {
    $configuration = $_.Split('=',2)
    New-Variable -Force -Scope Script -Name $configuration[0] -Value $configuration[1]
}

#variables
$github_upstream_repo 	= "https://$github_url/$github_upstream_org/$github_project"
$github_origin_repo		= "https://$github_url/$github_username/$github_project"
$local_repo 			= "$local_source_root\$github_username"

#create the root folder for the local repo
If(!(test-path $local_repo))
{
      New-Item -ItemType Directory -Force -Path $local_repo
}
cd $local_repo
#install or upgrade chocolatey
$testchoco = powershell choco -v
if(-not($testchoco)){
    Write-Output "Seems Chocolatey is not installed, installing now"
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else{
    Write-Output "Chocolatey Version $testchoco is already installed"
	Write-Output "Attempting to upgrade Chocolatey:"
	choco upgrade chocolatey
}
refreshenv
choco feature enable -n allowGlobalConfirmation
refreshenv

# install git, hub, vscode, gitlens, jre, jdk, 
# android-sdk, androidstudio, dart, flutter
choco install git.install
choco install git-credential-manager-for-windows
choco install hub
choco install vscode
choco install vscode-gitlens
choco install jre8
choco install jdk8
choco install android-sdk
$Env:ANDROID_HOME = "C:\Android\android-sdk"
# brute force and non deterministic TODO improve
"y`r`n" * 10 | & $Env:ANDROID_HOME\tools\bin\sdkmanager.bat "platforms;android-29" "platform-tools" "build-tools;29.0.2"
refreshenv
cd $local_repo
choco install androidstudio
choco install dart-sdk --pre 
choco install flutter
refreshenv
try{
	flutter --version
} catch {} finally {
	if (!$?) {$Env:PATH+=";C:\tools\flutter\flutter\bin"}
}
flutter config --android-sdk "C:\Android\android-sdk"
flutter config --android-studio-dir="$Env:ProgramFiles\Android\Android Studio"
flutter upgrade
# brute force and non deterministic TODO improve
"y`r`n" * 10 | & $Env:ANDROID_HOME\tools\bin\sdkmanager --licenses 
$code = "$Env:ProgramFiles\Microsoft VS Code\bin\code.cmd"
& $code --version
& $code --install-extension Dart-Code.dart-code 
& $code --install-extension Dart-Code.flutter

#store github credentials
$credential_helper = git config --get credential.helper
if ($credential_helper -ne "manager") {
	git config --global credential.helper manager
}
"protocol=https`r`nhost=github.com`r`nusername=$github_username`r`npassword=$github_token`r`n`r`n" | git credential-manager approve

# clone the origin repo in the local repo
cd $local_repo
git -C "$local_repo\$github_project" rev-parse
if (!$?) { 
	git clone $github_origin_repo
}
cd "$local_repo\$github_project"
git remote add upstream $github_upstream_repo

