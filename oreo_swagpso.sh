#!/bin/bash
#---------------------------------------------cli options---------------------------------------------
	usage() {
		echo -e "\ngithub: https://github.com/1337Rin/Swag-PSO (Private)"
		echo -e "github: https://github.com/OreoByte/Swag-PSO (Maintained)\n"
		echo "SwagPSO or Swag Powershell Obfuscator is a simple automated Powershell script obfuscator."
		echo "The '-s' flag is the only required option, other options will use defaults if not provided."
		echo
		echo "	-s <script> 	unobfuscated script"
		echo "	-v <variable>   variable base name"
		echo "	-f <function>   function base name"
		echo "	-h              displays this page"
		echo
		echo "Note that you still need to follow Powershell naming syntax or else your script will break."
		echo
		echo "example: $0 -s revshell.ps1"
		echo "example: $0 -s revshell.ps1 -v cool_variable_name -f cool_function_name"
	}

	while getopts s:v:f:h option
	do
	    case "${option}"
	        in
	        s)script_org=${OPTARG};;
	        v)var_in=${OPTARG};;
	        f)func_in=${OPTARG};;
	        h)usage&exit 0;;
	        ?)echo "Invalid option: -${OPTARG}."; exit 0;;
	    esac
	done

	if [[ ${#} = 0 ]]; then
	   usage
	   exit 0
	fi

echo """  ______  __       __  ______   ______       _______   ______   ______
 /      \|  \  _  |  \/      \ /      \     |       \ /      \ /      \\
|  ▓▓▓▓▓▓\ ▓▓ / \ | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\    | ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\\
| ▓▓___\▓▓ ▓▓/  ▓\| ▓▓ ▓▓__| ▓▓ ▓▓ __\▓▓    | ▓▓__/ ▓▓ ▓▓___\▓▓ ▓▓  | ▓▓
 \▓▓    \| ▓▓  ▓▓▓\ ▓▓ ▓▓    ▓▓ ▓▓|    \    | ▓▓    ▓▓\▓▓    \| ▓▓  | ▓▓
 _\▓▓▓▓▓▓\ ▓▓ ▓▓\▓▓\▓▓ ▓▓▓▓▓▓▓▓ ▓▓ \▓▓▓▓    | ▓▓▓▓▓▓▓ _\▓▓▓▓▓▓\ ▓▓  | ▓▓
|  \__| ▓▓ ▓▓▓▓  \▓▓▓▓ ▓▓  | ▓▓ ▓▓__| ▓▓    | ▓▓     |  \__| ▓▓ ▓▓__/ ▓▓
 \▓▓    ▓▓ ▓▓▓    \▓▓▓ ▓▓  | ▓▓\▓▓    ▓▓    | ▓▓      \▓▓    ▓▓\▓▓    ▓▓
  \▓▓▓▓▓▓ \▓▓      \▓▓\▓▓   \▓▓ \▓▓▓▓▓▓      \▓▓       \▓▓▓▓▓▓  \▓▓▓▓▓▓ 
                                                                        
By: 1337Rin
github: https://github.com/1337Rin/Swag-PSO (Private)

Modified By: OreoByte
github: https://github.com/OreoByte/Swag-PSO
"""

	if [[ -e $script_org ]]
	then
		:
	elif [[ $scipt_org = "" ]]
	then
		echo "[-] no script provided"
		echo "[-] exiting..."
		exit 0
	else
		echo "[-] $script does not exists"
		echo "[-] exiting..."
		exit 0
	fi

	if [[ -z $var_in ]]
	then
		echo "[-] no variable name provided using default"
		var_in="RinWasHere"
		var="\$$var_in"
	else
		var="\$$var_in"
	fi

	if [[ -z $func_in ]]
	then
		echo "[-] no function name provided using default"
		func_in="RinWasHere"
		func="$func_in"
	else
		func="$func_in"
	fi
	tmp=/tmp/254626542o456435
#---------------------------------------------pre obfuscation---------------------------------------------
opre() {
path_check=$(echo -n $script_org | grep '/')
if [[ $path_check == '' ]]; then
	script="$script_org"
	cp $script "original_$script"
else
	script_name=$(echo -n $script_org |sed -e 's/\// /g'|awk '{print $NF}')
	cp "$script_org" .
	script="$script_name"
	cp $script original_$script
fi
if [[ -e "original_$script" ]]; then
	echo "[-] original_$script Already Exists"
	echo
	echo "[+] $script --> original_$script"
	echo
else
	echo "[+] creating copy"
	echo "[+] $script --> original_$script"
	echo
fi
}
#---------------------------------------------function renaming---------------------------------------------
ofunction() {
functions=$(cat $script | grep [Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn] | sed 's/^[ \t]*//' | sed '/^[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]/!d' | sed 's/^[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn] //g')
if [[ -z "$functions" ]]
then
	echo "[-] no functions found"
else
# rename functions in file
echo "[+] renaming functions"
for x in $functions./
do
	string=$(LC_ALL=C tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
	func="$func$string"
	sed -i "s/$x/$func/g" $script
	echo "[+] $x --> $func"
	func="$func_in"
done
fi
echo
}
#---------------------------------------------variable renameing---------------------------------------------
ovariable() {
# gather variables
cat $script | sed -e 's/\s\+/\n/g' | sort | uniq | grep \\$ > $tmp
#i know what a for loop is trust me
cat $tmp | cut -f1 -d"," | cut -f1 -d"(" | cut -f1 -d")" | cut -f1 -d"=" |  cut -f1 -d"." | cut -f1 -d"[" | cut -f1 -d"]" |  cut -f1 -d'"' | cut -f1 -d";" | grep \\$ | sort | uniq > $tmp

# rename variables in file
if [[ -z "$tmp" ]]
then
	echo "[-] no variables found"
else
echo "[+] renaming variables"
LINES=$(cat $tmp)
for LINE in $LINES
do
	string=$(LC_ALL=C tr -dc A-Za-z0-9 </dev/urandom | head -c 20)
	var="$var$string"
	sed -i "s/$LINE/$var/g" $script
	echo "[+] $LINE --> $var"
	var="\$$var_in"
done
fi
echo
}
#---------------------------------------------randomizing capatalization---------------------------------------------
ocasing() {
string=$script
string=$(cat $script)

# randomly select letters to make uppercase
random=$(tr -dc a-z </dev/urandom | head -c 12 | grep -o . | sort | uniq | tr "\n" ",")
echo "[+] replacing $random with uppercase"
echo

# converts all to lowercase
string=$(echo "${string,,}")
#makes selected characters uppercase
echo "${string^^[$random]}" > $script
}
#---------------------------------------------junk comments---------------------------------------------
ojunk() {
random=$(tr -dc a-z </dev/urandom | head -c 10)
sed -i "s/;/;<#$random#>/g" $script
echo "[+] creating junk commets"
echo "[+] ; --> ;<#$random#>"
echo
}
#--------------------------------------------restructure---------------------------------------------
ostructure() {
noline=$(cat $script | tr "\n" ";")
echo $noline > $script
echo "[+] restructuring script"
echo
}

#--------------------------------------------get rid of some spaces---------------------------------------------
oequal() {
sed -i "s/ = /=/g" $script
echo "[+] getting rid of spaces around equal sign"
echo
}
#--------------------------------------------parse for commands--------------------------------------------
ocommand() {
cmdlets=("""Clear-Host
Compress-Archive
Expand-Archive
Find-Command
Find-DSCResource
Find-Module
Find-RoleCapability
Find-Script
Get-CredsFromCredentialProvider
Get-InstalledModule
Get-InstalledScript
Get-PSRepository
Install-Module
Install-Script
New-ScriptFileInfo
Publish-Module
Publish-Script
Register-PSRepository
Save-Module
Save-Script
Set-PSRepository
Test-ScriptFileInfo
Uninstall-Module
Uninstall-Script
Unregister-PSRepository
Update-Module
Update-ModuleManifest
Update-Script
Update-ScriptFileInfo
Add-Content
Add-History
Add-Member
Add-Type
Clear-Content
Clear-History
Clear-Item
Clear-ItemProperty
Clear-Variable
Compare-Object
Convert-Path
ConvertFrom-Csv
ConvertFrom-Json
ConvertFrom-Markdown
ConvertFrom-SecureString
ConvertFrom-StringData
ConvertTo-Csv
ConvertTo-Html
ConvertTo-Json
ConvertTo-SecureString
ConvertTo-Xml
Copy-Item
Copy-ItemProperty
Debug-Job
Debug-Process
Debug-Runspace
Disable-ExperimentalFeature
Disable-PSBreakpoint
Disable-RunspaceDebug
Enable-ExperimentalFeature
Enable-PSBreakpoint
Enable-RunspaceDebug
Enter-PSHostProcess
Enter-PSSession
Exit-PSHostProcess
Exit-PSSession
Export-Alias
Export-Clixml
Export-Csv
Export-FormatData
Export-ModuleMember
Export-PSSession
Find-Package
Find-PackageProvider
ForEach-Object
Format-Custom
Format-Hex
Format-List
Format-Table
Format-Wide
Get-Alias
Get-ChildItem
Get-Clipboard
Get-CmsMessage
Get-Command
Get-Content
Get-Credential
Get-Culture
Get-Date
Get-Error
Get-Event
Get-EventSubscriber
Get-ExecutionPolicy
Get-ExperimentalFeature
Get-FileHash
Get-FormatData
Get-Help
Get-History
Get-Host
Get-Item
Get-ItemProperty
Get-ItemPropertyValue
Get-Job
Get-Location
Get-MarkdownOption
Get-Member
Get-Module
Get-Package
Get-PackageProvider
Get-PackageSource
Get-PfxCertificate
Get-Process
Get-PSBreakpoint
Get-PSCallStack
Get-PSDrive
Get-PSHostProcessInfo
Get-PSProvider
Get-PSReadLineKeyHandler
Get-PSReadLineOption
Get-PSSession
Get-Random
Get-Runspace
Get-RunspaceDebug
Get-TimeZone
Get-TraceSource
Get-TypeData
Get-UICulture
Get-Unique
Get-Uptime
Get-Variable
Get-Verb
Group-Object
Import-Alias
Import-Clixml
Import-Csv
Import-LocalizedData
Import-Module
Import-PackageProvider
Import-PowerShellDataFile
Import-PSSession
Install-Package
Install-PackageProvider
Invoke-Command
Invoke-Expression
Invoke-History
Invoke-Item
Invoke-RestMethod
Invoke-WebRequest
Join-Path
Join-String
Measure-Command
Measure-Object
Move-Item
Move-ItemProperty
New-Alias
New-Event
New-Guid
New-Item
New-ItemProperty
New-Module
New-ModuleManifest
New-Object
New-PSDrive
New-PSRoleCapabilityFile
New-PSSession
New-PSSessionOption
New-PSTransportOption
New-TemporaryFile
New-TimeSpan
New-Variable
Out-Default
Out-File
Out-Host
Out-Null
Out-String
Pop-Location
Protect-CmsMessage
Push-Location
Read-Host
Receive-Job
Register-ArgumentCompleter
Register-EngineEvent
Register-ObjectEvent
Register-PackageSource
Remove-Alias
Remove-Event
Remove-Item
Remove-ItemProperty
Remove-Job
Remove-Module
Remove-PSBreakpoint
Remove-PSDrive
Remove-PSReadLineKeyHandler
Remove-PSSession
Remove-TypeData
Remove-Variable
Rename-Item
Rename-ItemProperty
Resolve-Path
Restart-Computer
Save-Help
Save-Package
Select-Object
Select-String
Select-Xml
Send-MailMessage
Set-Alias
Set-Clipboard
Set-Content
Set-Date
Set-ExecutionPolicy
Set-Item
Set-ItemProperty
Set-Location
Set-MarkdownOption
Set-PackageSource
Set-PSBreakpoint
Set-PSDebug
Set-PSReadLineKeyHandler
Set-PSReadLineOption
Set-StrictMode
Set-TraceSource
Set-Variable
Show-Markdown
Sort-Object
Split-Path
Start-Job
Start-Process
Start-Sleep
Start-ThreadJob
Start-Transcript
Stop-Computer
Stop-Job
Stop-Process
Stop-Transcript
Tee-Object
Test-Connection
Test-Json
Test-ModuleManifest
Test-Path
Trace-Command
Unblock-File
Uninstall-Package
Unprotect-CmsMessage
Unregister-Event
Unregister-PackageSource
Update-FormatData
Update-Help
Update-List
Update-TypeData
Wait-Debugger
Wait-Event
Wait-Job
Wait-Process
Where-Object
Write-Debug
Write-Error
Write-Host
Write-Information
Write-Output
Write-Progress
Write-Verbose
Write-Warning""")
tmp=/tmp/24652645
payload=$(cat $script)
echo "[+] searching for commands"
for cmd in ${cmdlets[@]}
do
    if grep -iq "$cmd" <<< "$payload"; then
        echo "[+] found $cmd"
        random=$(tr -dc a-z </dev/urandom | head -c 15)
        echo "[+] making alias $cmd --> $random"
        cat $script > $tmp
        sed -i "s/$cmd/$random/gI" $tmp
        echo "Set-Alias -Name $random -Value $cmd;" > $script
        cat $tmp >> $script
    fi
done
echo
}
opre
ofunction
ovariable
ojunk
ocommand
ostructure
oequal
#ocasing
exit 0
