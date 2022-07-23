#!/bin/bash


#---------------------------------------------cli options---------------------------------------------

	usage() {
		echo "github: "
		echo
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
		echo

	}

	while getopts s:v:f:h option
	do 
	    case "${option}"
	        in
	        s)script=${OPTARG};;
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
github:
"""

	if [[ -e $script ]]
	then
		:
	elif [[ $scipt = "" ]]
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
		var_in="babys_first_program"
		var="\$$var_in"
	else
		var="\$$var_in"
	fi

	if [[ -z $func_in ]]
	then
		echo "[-] no function name provided using default"
		func_in="babys_first_hello_world"
		func="$func_in"
	else
		func="$func_in"
	fi


	tmp=/tmp/254626542456435
#---------------------------------------------pre obfuscation---------------------------------------------
opre() {
if [[ -e "original_$script" ]]
then
	echo "[-] original_$script already exists"
	echo
	num=
	original_script=$(echo "original_$script""$num")

	while [[ -e  $original_script ]]
	do
	num=$(($num + 1))
	original_script=$(echo "original_$script""$num")
	done
	cp $script $original_script
	echo "[+] creating copy"
	echo "[+] $script --> $original_script"
	echo
else
	cp $script "original_$script"
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
for x in $functions
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
random=$(tr -dc a-z </dev/urandom | head -c 5)
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

opre
ocasing
ofunction
ovariable
ojunk
ostructure
exit 0
