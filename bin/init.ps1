# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
# New-item –type file –force $profile
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#[System.Windows.Forms.MessageBox]::Show("We are proceeding with next step." , "Status" , 4) ;;   0:    OK
# 1:    OK Cancel
# 2:    Abort Retry Ignore
# 3:    Yes No Cancel
# 4:    Yes No
# 5:    Retry Cancel
# [System.Media.SystemSounds]::Beep.Play() [System.Media.SystemSounds]::Hand.Play()
$Global:CosmosPath = "";
$username = "fareast\bichongl"
if(Test-Path "C:\app\emacs\.emacs.d\Password.txt")
{
    $password = Get-Content "C:\app\emacs\.emacs.d\Password.txt"
}
else
{
    Read-Host "Enter Password" -AsSecureString |  ConvertFrom-SecureString | Out-File "C:\app\emacs\.emacs.d\Password.txt"
    $password = Get-Content "C:\app\emacs\.emacs.d\Password.txt"
}
$PSS = ConvertTo-SecureString $password
$cred = new-object system.management.automation.PSCredential $username,$PSS
function ..()
{
    cd ..
}

function disk()
{
    $diskC = Get-WmiObject Win32_LogicalDisk -ComputerName . -Filter "DeviceID='C:'"  | Select-Object Size,FreeSpace
    $diskD = Get-WmiObject Win32_LogicalDisk -ComputerName . -Filter "DeviceID='D:'"  | Select-Object Size,FreeSpace
    "Local Computer C: {0:#.0} GB free of {1:#.0} GB Total" -f ($diskC.FreeSpace/1GB),($diskC.Size/1GB) | write-output
    "Local Computer D: {0:#.0} GB free of {1:#.0} GB Total" -f ($diskD.FreeSpace/1GB),($diskD.Size/1GB) | write-output
}

function compile([String]$jobfile)
{
    Write-Host "Start to compile $jobfile";
    scope compile -i $jobfile -vc https://cosmos11.osdinfra.net/cosmos/MMRepository.prod
}

function os([String]$concept)
{
	$newurl = "http://asgvm-280/os?concept=$concept"
	ie $newurl;
}

function th([String]$id)
{
	$newurl = "https://www.mm.bing.net/th?id=OVP.$id"
	ie $newurl;
}

function submit([String]$jobfile)
{
    Write-Host "Start to submit $jobfile";
    scope submit -i $jobfile -vc https://cosmos11.osdinfra.net/cosmos/MMRepository.prod
}

function pl([String]$url)
{
    D:\Work\checkplaylist\bin\Debug\checkplaylist.exe $url
}

function dc
{
    Param($dir)
    $ip = Test-Connection -ComputerName (hostname) -Count 1  | Select IPV4Address
    $client = New-Object System.Net.Sockets.TcpClient $ip.IPV4Address.IPAddressToString, 11001
    $stream = $client.GetStream()
    $writer = New-Object System.IO.StreamWriter $stream
    $writer.AutoFlush = $true
    $writer.Write($dir + "<EOF>")
    $reader = New-Object System.IO.StreamReader $stream
    $Encoding = new-object System.Text.ASCIIEncoding

    $Result = ''
    $Buffer = New-Object -TypeName System.Byte[] -ArgumentList 1024
    do {
        try {
            $ByteCount = $stream.Read($Buffer, 0, $Buffer.Length)
        } catch [System.IO.IOException] {
            $ByteCount = 0
        }
        if ($ByteCount -gt 0) {
            $Result += $Encoding.GetString($Buffer, 0, $ByteCount)
        }
    } while ($stream.DataAvailable -and $client.Client.Connected)


    $arr = $Result -split '\t'
    if($arr.Length -eq 1)
    {
        if(Test-Path $arr[0])
        {
            pushd $arr[0]
        }
        else
        {
            Write-Host $arr[0]
        }
        $writer.Dispose()
        $reader.Dispose()
        $stream.Dispose()
        $client.Dispose()
        return;
    }
    if($arr.Length -ge 1)
    {
        for($i = 0;$i -lt $arr.Length; $i++)
        {
            $line = $arr[$i]
            if($line -ne '')
            {
                Write-Host "[ $i ] $line";
            }
        }
    }
    $flag = $false;
    $key = Read-Host "Choose the above directory to fast jump [0] "
    for($i = 0;$i -lt 10;$i++)
    {
        if( $key -eq $i  -and $arr.Length -gt $i)
        {
            pushd $arr[$i]
            $flag = $true;
            break;
        }

        if($key -eq '' -and $arr.Length -gt 0)
        {
            pushd $arr[0];
            $flag = $true;
            break;
        }
    }
    if(!$flag)
    {
        Write-Host "Invalid Input!";
    }

    $writer.Dispose()
    $reader.Dispose()
    $stream.Dispose()
    $client.Dispose()
}

function password()
{
    Read-Host "Enter Password" -AsSecureString |  ConvertFrom-SecureString | Out-File "C:\app\emacs\.emacs.d\Password.txt"
}

function base64([String]$content)
{
    if($content -eq '')
    {
        Write-Host "Usage: base64 string-as-input"
        return;
    }

    if($content.Trim().EndsWith("=="))
    {
        $HexCodeLine = [Convert]::FromBase64String($content.Trim());
        $UniCodeLine = [System.Text.Encoding]::Unicode.GetString($HexCodeLine);
        echo "$UniCodeLine"
    }
    else
    {
        Write-Host "Encoding base64 of $content"
        $UniCodeLine = [System.Text.Encoding]::Unicode.GetBytes($content)
        $HexCodeLine = [Convert]::ToBase64String($UniCodeLine)
        echo "$HexCodeLine"
    }
}

function ssh()
{
    plink -ssh -v -noagent -v thirty.cloudapp.net -l libicong00 -pw bichong@MS2012
}

function ssh1()
{
    plink -ssh -v -noagent -v 10.177.88.91 -l bichong -pw wxr8738078
}

function note()
{
    #https://technet.microsoft.com/en-us/library/ff731008.aspx
    [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
    $a = Get-Process | Where-Object {$_.Name -eq "ONENOTE"}
    if($a -ne $null)
    {
        [Microsoft.VisualBasic.Interaction]::AppActivate($a.ID)
    }
    else
    {
        start "C:\Program Files (x86)\Microsoft Office\root\Office16\ONENOTE.EXE"
    }
}

function rt([String]$computer)
{
    #Enable-PSRemoting -Force
    #Set-Item wsman:\localhost\client\trustedhosts *
    #Restart-Service WinRM
    #Test-WsMan $computer
    $newName = ""
    if($computer -eq '06')
    {
        $newName = "lsstchost06"
    }
    elseif($computer -eq '92')
    {
        $newName = "stcsrv-c92"
    }
    Enter-PSSession -ComputerName $newName -Credential $cred
}

function rdp([String]$computer)
{
    $newName = ""
    if($computer -eq '06')
    {
        $newName = "lsstchost06"
    }
    elseif($computer -eq '92')
    {
        $newName = "stcsrv-c92"
    }
    Start-Process -FilePath "$env:windir\system32\mstsc.exe" -ArgumentList "/v:$newName" -Wait -Credential $cred

}

function outlook()
{
    [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
    $a = Get-Process | Where-Object {$_.Name -eq "OUTLOOK"}
    if($a -ne $null)
    {
        [Microsoft.VisualBasic.Interaction]::AppActivate($a.ID)
    }
    else
    {
        start "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
    }
}

function ball()
{
    [CmdletBinding()]
    Param (
        [Parameter(Position=0)]$Title='Problem',
        [Parameter(Position=1)]$Text ='Check all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuffCheck all stuff',
        [Parameter(Position=2)][int]$Timeout = 2000,
        $Icon = 'Info'
    )
    Process {
        Add-Type -AssemblyName System.Windows.Forms
        If ($notification -eq $null) {
            $notification = New-Object System.Windows.Forms.NotifyIcon
        }
        $Path = Get-Process -Id $PID | Select-Object -ExpandProperty Path
        $notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($Path)
        $notification.BalloonTipIcon = $Icon
        $notification.BalloonTipText = $Text
        $notification.BalloonTipTitle = $Title
        $notification.Visible = $true
        $notification.ShowBalloonTip($Timeout)
        #Balloon message clicked
        #register-objectevent $notification BalloonTipClicked BalloonClicked_event `
          #-Action {[System.Windows.Forms.MessageBox]::Show(“Balloon message clicked”,”Information”);$notification.Visible = $False} | Out-Null

        #Balloon message closed
        #register-objectevent $notification BalloonTipClosed BalloonClosed_event `
          #-Action {[System.Windows.Forms.MessageBox]::Show(“Balloon message closed”,”Information”);$notification.Visible = $False} | Out-Null
        sleep($Timeout/1000)
        $notification.dispose()
    } # End of Process
}

function say
{
    #$voice = new-object -ComObject "SAPI.SPVoice"
    #$voice.speak("Powershell rocks!")
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string] $Text,
        [switch] $Async=$false
    )

    [Reflection.Assembly]::LoadWithPartialName('System.Speech') | Out-Null
    $speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer
    #$speaker.GetInstalledVoices().VoiceInfo
    $speaker.SelectVoice('Microsoft Hazel Desktop')
    $speaker.Rate = 2
    if ($Async) {
        $speaker.SpeakAsync($Text)
    } else {
        $speaker.Speak($Text)
    }
}

function c([String]$file)
{
    if($file -eq '')
    {
        c:
    }
    elseif($file -eq 'org')
    {
        pushd C:\app\emacs\org
    }
}

function ce(){pushd c:\app\emacs}
function co(){pushd c:\app\emacs\org\}
function t(){pushd d:\tmp\}

function d()
{
    pushd d:
}

function pd()
{
    popd
}

function q()
{
    exit
    exit
}

function CosmosPS()
{
    Import-Module C:\Users\bichongl\OneDrive\CosmosPowerShell\Cosmos.psd1
    Get-Command -Module Cosmos
}

function org([String]$file)
{
    if($file -eq "")
    {
        cr http://thirty.cloudapp.net/home.html
    }
    elseif($file -eq "org")
    {
        cr http://thirty.cloudapp.net/Org.html
    }
    elseif($file -eq "gtd")
    {
        cr http://thirty.cloudapp.net/gtd.html
    }
    elseif($file -eq "git")
    {
        cr http://thirty.cloudapp.net/git.html
    }
    elseif($file -eq "home")
    {
        cr http://thirty.cloudapp.net/home.html
    }
    else
    {
        cr http://thirty.cloudapp.net/home.html
    }
}

function push()
{
    git pull
    git add *
    git commit -m "a new iteration"
    git push -u origin master
}

function cd2()
{
    cd ../..
}

function mmr()
{
    pushd D:\Code\VideoIG\private\indexgen\multimedia\MMRScripts\MMRV2\ProdCo3C\Video\Scripts\Pipeline\
}

function sm()
{
    pushd D:\Code\VideoIG\private\indexgen\multimedia\MMRScripts\MMRV2\ProdCo3C\Video\Scripts\Pipeline\
}

function fy([string]$word)
{
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $query = "http://fanyi.youdao.com/openapi.do?keyfrom=WoxLauncher&key=1247918016&type=data&doctype=json&version=1.1&q=";
    $url = $query + [System.Web.HttpUtility]::UrlEncode($word)
    $contentbuffer = (new-object Net.WebClient).DownloadData($url);
    $content = [System.Text.Encoding]::UTF8.GetString($contentbuffer, 0, $contentbuffer.Length) | ConvertFrom-Json;
    $result = "[" + $content.basic."us-phonetic" + "]" + "`t" + $content.basic.explains + "`n";
    Write-Host $result
    foreach($kv in $content.web)
    {
        Write-Host $kv.Key $kv.Value
    }
}

function bw()
{
    $cur = Convert-Path .
    if($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\WDP_Dev" -and $cur.StartsWith("D:\Code\WDP_Dev", $false, $null))
    {
        pushd D:\Code\WDP_Dev\private\IndexGen\bw\
    }
    elseif($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\VideoIg" -and $cur.StartsWith("D:\Code\VideoIg", $false, $null))
    {
        pushd D:\Code\VideoIg\private\IndexGen\Multimedia\BlueWhale\
    }
}

function mmep()
{
    $cur = Convert-Path .
    if($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\WDP_Dev" -and $cur.StartsWith("D:\Code\WDP_Dev", $false, $null))
    {
        pushd D:\Code\WDP_Dev\private\IndexGen\bw\Multimedia\
    }
}

function pub()
{
    $cur = Convert-Path .
    if($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\WDP_Dev" -and $cur.StartsWith("D:\Code\WDP_Dev", $false, $null))
    {
        pushd D:\Code\WDP_Dev\private\IndexGen\bw\shared\Publications
    }
}

function table()
{
    $cur = Convert-Path .
    if($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\WDP_Dev" -and $cur.StartsWith("D:\Code\WDP_Dev", $false, $null))
    {
        pushd D:\Code\WDP_Dev\private\IndexGen\bw\shared\Tables
    }
}

function tmp()
{
    if($env:COMPUTERNAME -eq "MININT-BLOC2G0")
    {
        pushd d:/tmp
		explorer d:/tmp
        return;
    }
}

function debugbw([string]$url)
{
    if($env:COMPUTERNAME -ne "LSSTCHOST06")
    {
        Write-Host "Invalid machine, only available on LSSTCHOST06"
        return;
    }

    pushd D:\app\BlwMmVideoDebug
    .\BlwMmVideoDebug.exe trace --url $url.Trim() --env mmprod > 1.txt
    np .\1.txt
    popd
}

function cnbeta([int]$index=0)
{
    $url = "http://rss.cnbeta.com/rss"
    if($env:COMPUTERNAME -eq "MININT-BLOC2G0" -or $env:COMPUTERNAME -eq "LSSTCHOST06")
    {
        $filePath = [System.IO.Path]::Combine("D:\\tmp", "cnbeta.txt");
    }
    $nodeName = "title"
    $xmlDoc = New-Object "System.Xml.XmlDocument"
    if(($index > 0) -and [System.IO.File]::Exists("cnbeta.txt"))
    {
        $xmlDoc.Load($filePath)
    }
    else
    {
        Invoke-WebRequest -Uri $url -OutFile $filePath
        $xmlDoc.Load($filePath);
    }
    $hash = @{};
    $count = 0;
    foreach($item in $xmlDoc.GetElementsByTagName("item"))
    {
        [String]$desc = $item.description.'#cdata-section';
        $count = $count + 1;
        if($index -eq 0)
        {
            Write-Host $count, $item.title, `n, $desc.Trim().Replace("<strong>","").Replace("</strong>",""), `n;
        }
        $hash.Add($count, $item.link)
    }

    if($index -gt 0 -and $index -lt $hash.Count - 1)
    {
        $url = $hash[$index];
        Write-Host $url
        start $url
    }

}

function emacsnw
{
    Param($myargument)
    C:\app\emacs\bin\emacs.exe -nw $myargument
}

function emacs
{
    Param($myargument)
    C:\app\emacs\bin\runemacs.exe $myargument
}

function vs
{
    cmd /k "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
}

function vs12
{
    cmd /k "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x64
}

function profile
{
    emacs C:\Users\bichongl\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

function clr4
{
    $xml = @"
<?xml version="1.0"?>
<configuration>
<startup useLegacyV2RuntimeActivationPolicy="true">
<supportedRuntime version="v4.0.30319"/>
<supportedRuntime version="v2.0.50727"/>
</startup>
</configuration>
"@

    $xml | Out-File $pshome\powershell_ise.exe.config
    $xml | Out-File $pshome\powershell.exe.config
}

function PoshGit
{
    (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
    Get-PsGetModuleInfo Posh*
    Install-Module posh-git
}

function choco
{
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
}

function mp3([String]$url)
{
    $flag = $false
    if([System.IO.Directory]::Exists("D:\\tmp\\"))
    {
        $flag = $true;
        pushd "D:\\tmp\\";
    }
    if($url.StartsWith("https://www.youtube.com/") -and !$url.StartsWith("https://www.youtube.com/watch?v="))
    {
        youtube-dl -f 'bestaudio[ext=mp3]/bestaudio' -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $url
    }
    else
    {
        youtube-dl -f 'bestaudio[ext=mp3]/bestaudio' -o '%(title)s.%(ext)s' $url
    }
    if($flag)
    {
        popd
    }
}

function dl([String]$url)
{
    $flag = $false
    if([System.IO.Directory]::Exists("D:\\tmp\\"))
    {
        $flag = $true;
        pushd "D:\\tmp\\";
    }
    if($url.StartsWith("https://www.youtube.com/") -and !$url.StartsWith("https://www.youtube.com/watch?v="))
    {
        youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $url
    }
    else
    {
        youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '%(title)s.%(ext)s' $url
    }
    if($flag)
    {
        popd
    }
}

function scope1
{
    pushd "D:\app\ScopeSDK"
    $param = [system.string]::Join(' ', $args);
    if($param -eq "")
    {
        .\scope.exe -help all
    }
    elseif($args[0] -eq "copy")
    {
        .\scope.exe $param
    }
    popd;
}

Set-Alias np "C:\Program Files (x86)\Notepad++\notepad++.exe"

Set-Alias q "pushd"

Set-Alias p "popd"

Set-Alias scope "D:\app\ScopeSDK\scope.exe"

function msn()
{
    pushd "C:\Users\bichongl\Desktop\msn execise videos";
}

function vs12()
{
    Import-Module  -force Pscx
    # Add Visual Studio 2015 settings to PowerShell
    # Import-VisualStudioVars 140 x86

    # If you'd rather use VS 2013, comment out the
    # above line and use this one instead:
    Import-VisualStudioVars 2013 x86
}

function l()
{
    dir
}

function ll()
{
    dir
}

function init()
{
    np "C:\app\emacs\bin\init.ps1";
}

function reload()
{
    . "C:\app\emacs\bin\init.ps1";
}

function debugps()
{
    ise "C:\app\emacs\bin\init.ps1";
}

function count([string]$path)
{
    CosmosPS|out-null
    $newpath = $path.Replace("?property=info","");
    $cosmos = "cosmos11";
    $vc="MMRepository.prod";
    $regex = new-object System.Text.RegularExpressions.Regex ("(cosmos\d+).osdinfra.net/cosmos/([\w\.]+)([\w\d\.\/\?\-_]+)", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase);
    $matches = $regex.Match($newpath);
    if($matches.Success)
    {
        $cosmos = $matches.Groups[1].Value;
        $vc = $matches.Groups[2].Value;
        $newpath = $matches.Groups[3].Value;
    }
    $query = 'e = SSTREAM @"' + $newpath + '";g = SELECT TOP 1 COUNT(1) AS Num  FROM e;OUTPUT TO CONSOLE;';
    $virtualcluster = 'vc://' + $cosmos + '/' + $vc;
    Invoke-ScopeQuery -QueryString $query -VC $virtualcluster
}

function key([string]$key, [string]$path = "")
{
    CosmosPS|out-null
    if([String]::IsNullOrEmpty($path))
    {
        $newpath = $Global:CosmosPath;
    }
    else
    {
        $newpath = $path.Replace("?property=info","");
        $Global:CosmosPath = $newpath;
    }
    $cosmos = "cosmos11";
    $vc="MMRepository.prod";
    $regex = new-object System.Text.RegularExpressions.Regex ("(cosmos\d+).osdinfra.net/cosmos/([\w\.]+)([\w\d\.\/\?\-_]+)", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase);
    $matches = $regex.Match($newpath);
    if($matches.Success)
    {
        $cosmos = $matches.Groups[1].Value;
        $vc = $matches.Groups[2].Value;
        $newpath = $matches.Groups[3].Value;
    }
    $query = 'e = SSTREAM @"' + $newpath + '";g = SELECT TOP 10 * FROM e WHERE Key =="' + $key + '";OUTPUT TO CONSOLE;';
    $virtualcluster = 'vc://' + $cosmos + '/' + $vc;
    Invoke-ScopeQuery -QueryString $query -VC $virtualcluster
}

function tps()
{
    start D:\app\tpsutil\TPSUtilGui.exe
}

function wdp()
{
    if($env:inetroot -ne $null -or $env:inetroot -ne "d:\code\WDP_Dev")
    {
        $env:inetroot = "D:\Code\WDP_Dev";
        $env:corextbranch = "WDP_Dev";
        . D:\Code\WDP_Dev\init.ps1
    }
    pushd $env:inetroot
}

function code()
{
    if($env:computername -eq "FORTY")
    {
        pushd "c:\Code"
    }
    if($env:computername -eq "MININT-BLOC2G0")
    {
        pushd "d:\Code"
    }
}

function muduo()
{
    if($env:computername -eq "FORTY")
    {
        pushd "C:\Code\muduo\"
    }
    if($env:computername -eq "MININT-BLOC2G0")
    {
        pushd "d:\Code\muduo"
    }
}

function boost()
{
    if($env:computername -eq "FORTY")
    {
        pushd "C:\Code\boost_1_61_0"
    }
}

function vig()
{
    if($env:inetroot -ne $null -or $env:inetroot -ne "d:\code\VideoIg")
    {
        $env:inetroot = "D:\Code\VideoIg";
        $env:corextbranch = "VideoIg";
        . D:\Code\VideoIg\init.ps1
    }
    pushd $env:inetroot
}

function mig()
{
    if($env:inetroot -ne $null -or $env:inetroot -ne "d:\code\ImageIg")
    {
        $env:inetroot = "D:\Code\ImageIg";
        $env:corextbranch = "ImageIg";
        . D:\Code\ImageIg\init.ps1
    }
    pushd $env:inetroot
}

function is()
{
    if($env:inetroot -ne $null -or $env:inetroot -ne "d:\code\IndexServe")
    {
        $env:inetroot = "D:\Code\IndexServe";
        $env:corextbranch = "IndexServe";
        . D:\Code\IndexServe\init.ps1
    }
    pushd $env:inetroot
}

function data()
{
    pushd "D:\\data";
}

function home()
{
    pushd "C:\Users\bichongl\"
}

function dk()
{
    pushd "C:\Users\bichongl\Desktop\"
}

function mm12()
{
    if($env:inetroot -ne "d:\data\apgold")
    {
        $env:inetroot = "d:\data\apgold";
        $env:corextbranch = "apgold";
        . "d:\data\apgold\tools\path1st\myenv.ps1"
    }
    pushd D:\Data\APGold\autopilotservice\Global\VirtualEnvironments\Cosmos\cosmos12-Prod-Cy2-IndexGenMm
}

function mm13()
{
    if($env:inetroot -ne "d:\data\apgold")
    {
        $env:inetroot = "d:\data\apgold";
        $env:corextbranch = "apgold";
        . "d:\data\apgold\tools\path1st\myenv.ps1"
    }
    pushd D:\Data\APGold\autopilotservice\Global\VirtualEnvironments\Cosmos\cosmos13-prod-co3c-indexGenMmInt
}

function ag()
{
    if($env:inetroot -ne "d:\data\apgold")
    {
        $env:inetroot = "d:\data\apgold";
        $env:corextbranch = "apgold";
        . "d:\data\apgold\tools\path1st\myenv.ps1"
    }
}

function get([String]$file)
{
    $newfile = $file;
    $localfile = "";
    $localdir = pwd
    if($file.Contains("osdinfra.net"))
    {
        $newfile = $file.Replace("?property=info", "");
	}
	else
	{
		$newfile = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod" + $file;
	}

	$localfile = $newfile.Substring($newfile.LastIndexOf('/') + 1);
	if([System.IO.Directory]::Exists("D:\\tmp\\"))
	{
		$localfile = "D:\\tmp\\$localfile";
		$localdir = "D:\\tmp\\";
	}
	if(Test-Path $localfile)
	{
		del $localfile
	}
	pushd "D:\app\ScopeSDK"
	.\scope.exe copy $newfile $localfile
	pushd $localdir
	explorer .
	popd
	popd
}

function put([String]$file)
{
    $filename = $file.Substring($file.LastIndexOf('\') + 1);
    $localfile = [IO.Path]::GetFullPath($file);
    $newfile = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/my/" + $filename;
    pushd "D:\app\ScopeSDK"
    .\Scope.exe copy $localfile $newfile
    popd
}

function mm([String]$path)
{
    $newurl = "";
    if($path -eq "")
    {
        $cur = Convert-Path .
        if($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\WDP_Dev" -and $cur.StartsWith("D:\Code\WDP_Dev", $false, $null))
        {
            pushd D:\Code\WDP_Dev\private\IndexGen\bw\Multimedia\
            return;
        }
        elseif($env:inetroot -ne $null -and $env:inetroot -eq "d:\Code\VideoIG" -and $cur.StartsWith("D:\Code\VideoIG", $false, $null))
        {
            pushd D:\Code\VideoIG\private\IndexGen\Multimedia\
            return;
        }
        else
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod";
        }
    }
    elseif($path.StartsWith("http"))
    {
        $newurl = $path;
    }
    else
    {
        if($path.StartsWith("/"))
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod$path";
        }
        elseif($path -eq "my")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/my/";
        }
        elseif($path -eq "12")
        {
            $newurl = "https://cosmos12.osdinfra.net/cosmos/indexGen.Batch.Prod/local/GeoRep/To_cosmos08_MMRepository.prod/Prod/Video/";
        }
        elseif($path -eq "13")
        {
            $newurl = "https://cosmos13.osdinfra.net/cosmos/indexGen.Batch.Int/";
        }
        elseif($path -eq "expiry")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/local/Prod/Video/Expiry/Realtimeblocking/";
        }
        elseif($path -eq "bw")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/shares/indexGen.Batch.Prod.proxy/From_cosmos12_indexGen.Batch.Prod/Prod/Video/BlueWhale/";
        }
        elseif($path -eq "mmr")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/local/Prod/Video/Repository/Snapshot/";
        }
        elseif($path -eq "ft")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/local/Prod/Video/GreenCow/Repository/Snapshot/FeatureTable/";
        }
        elseif($path -eq "idf")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/local/Prod/Image/Repository/Snapshot/IDF/";
        }
        elseif($path -eq "dui")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/local/Prod/Image/Repository/Snapshot/DUI/";
        }
        elseif($path -eq "job")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/_Jobs/";
        }
        elseif($path -eq "sfs")
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/local/Prod/Video/SFS/CrawlOutput/MMVideoGreencow/";
        }
        else
        {
            $newurl = "https://cosmos11.osdinfra.net/cosmos/MMRepository.prod/$path";
        }
    }

    if(!$newurl.EndsWith("?property=info") -and !$path.EndsWith("\\"))
    {
		$newurl = $newurl + "?property=info";
        if($newurl.EndsWith(".ss") -or $newurl.EndsWith(".xml") -or $newurl.EndsWith(".txt") -or $newurl.EndsWith(".csv"))
        {
            
        }
    }

    ie $newurl;
}

function sg()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }

    pushd $env:inetroot
}

function fd()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }
    pushd "D:\Data\SearchGold\deploy\builds\data\latest\mmfeeds\"
}

function data()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }
    pushd "D:\Data\SearchGold\deploy\builds\data\"
}

function latest()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }
    pushd "D:\Data\SearchGold\deploy\builds\data\latest\"
}

function mmcb()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }
    pushd "D:\Data\SearchGold\deploy\builds\data\latest\MMCB\"
}

function kif()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }
    pushd "D:\Data\SearchGold\deploy\builds\data\answers\kifrepositoryV2\KifSchemas\"
}

function mmrv2()
{
    if($env:inetroot -ne "d:\data\searchgold")
    {
        $env:inetroot = "d:\data\searchgold";
        $env:corextbranch = "searchgold";
        . "d:\data\searchgold\tools\path1st\myenv.ps1"
    }
    pushd "D:\Data\SearchGold\deploy\builds\data\latest\MMCB\mmrv2\prodco3c\video"
}

function root()
{
    pushd $env:inetroot
}

function one()
{
    pushd C:\Users\bichongl\OneDrive\
}

function tps()
{
    start D:\app\tpsutil\TPSUtilGui.exe
}

function word()
{
    start winword
}

function xls()
{
    start EXCEL.EXE
}

function putty()
{
    D:\app\putty\putty.exe -l libicong00 -load thirty -pw bc@MS2012
}

function xts()
{
    start D:\app\XTS\xts.exe
}

function html($url)
{
    if([String]::IsNullOrEmpty($url))
    {
        wget.cmd --help;
        return;
    }
    $path = "D:\\tmp\\" + [IO.Path]::GetRandomFileName() + ".html";
    if($url.StartsWith("https"))
    {
        wget.cmd -O $path --no-check-certificate $url | Out-Null
    }
    else
    {
        wget.cmd -O $path $url | Out-Null
    }
    if([IO.File]::Exists($path))
    {
        np $path;
    }
}

function flv($url)
{
    if([String]::IsNullOrEmpty($url))
    {
        wget.cmd --help;
        return;
    }
    $path = "D:\\tmp\\" + [IO.Path]::GetRandomFileName() + ".flv";
    if($url.StartsWith("https"))
    {
        wget.cmd -O $path --no-check-certificate $url | Out-Null
    }
    else
    {
        wget.cmd -O $path $url | Out-Null
    }
    if([IO.File]::Exists($path))
    {
        ffplay $path;
    }
}

function c2img($filename)
{
    Write-Host "binary file name: $filename";
    $filecontent = [System.IO.File]::ReadAllText($filename);
    $chararray = $filecontent.Split(',');
    $buffer = @();
    foreach($c in $chararray)
    {
        if([System.String]::IsNullOrEmpty($c))
        {
            continue;
        }
        $b = [SByte]::Parse($c.Replace('"',""));
        $buffer+=[System.BitConverter]::GetBytes($b)[0];
    }
    [System.IO.File]::WriteAllBytes($filename+".jpg", $buffer);
}

function a([string]$url)
{
	grep.exe -r -nHE $url *
}

function mr([string]$url)
{
    try
    {
        Add-Type -Path 'C:\app\emacs\bin\MMRV2.Utility.dll' | Out-Null
    }
    catch
    {
    }
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    if($url -eq "")
    {
        $newurl = "http://stcsrv-c92/MmrV2Reader/";
    }
    elseif($url -eq "mr")
    {
        powershell_ise "C:\Users\bichongl\OneDrive\app\mr.ps1";
        return;
    }
    else
    {
        $key = $url.Trim();
        if($url.StartsWith("http"))
        {
            $key = [MMRV2.Utility.HashValue]::GetHttpUrlHashBase64String($url)
        }
        $key = [System.Web.HttpUtility]::UrlEncode($key)
        $dt = [DateTime]::Today.AddDays(-1).ToString("yyyy_MM_dd");
        $newurl = "http://stcsrv-c92/MmrV2Reader/Default.aspx?vc=cosmos11&vertical=Video&env=Prod&date=$dt&query=$key&type=MMRepository";
    }
    ie($newurl);
}

function hash([string]$url)
{
    try
    {
        Add-Type -Path 'C:\app\emacs\bin\MMRV2.Utility.dll' | Out-Null
    }
    catch
    {
    }

    Add-Type -Path 'C:\app\emacs\bin\Microsoft.Bing.HashUtil.dll' | Out-Null
    $key = [MMRV2.Utility.HashValue]::GetHttpUrlHashBase64String($url);
    Write-Host "HashValue:",$key;
    $hutKey = [Microsoft.Bing.HashUtil.HutHash]::GetUrlHashAsBase64String($url);
    Write-Host "HutHash:",$hutKey
    $bcodes = [Microsoft.Bing.HashUtil.HutHash]::GetHashAsBinary($hutKey + $hutKey);
    $docKeyBase64 = [System.Convert]::ToBase64String($bcodes).Substring(0,22);
    Write-host "DocKey:",$docKeyBase64;
    $hashvalue = New-Object -TypeName MMRV2.Utility.HashValue;
    $hashvalue.GetHttpUrlHash($url) | Out-Null
    $urlHash = $hashvalue.ToHexString();
    Write-Host "UrlHash:",$urlHash
    Write-Host "MediaUniqueId:", $urlHash$urlHash
}

function v([string]$url)
{
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $newurl = $url;
    if($url -eq "")
    {
        $newurl = "http://video.bing.com?setmkt=en-US&setlang=en&uid=FA908932&FORM=NFTOUS";
    }
    elseif($url.StartsWith("http"))
    {
        $url = [System.Web.HttpUtility]::UrlEncode($url);
        $newurl = "http://www.bing.com/videos/search?q=url%3A$url&qs=n&form=QBVLPG&sc=0-4&sp=-1&sk=&setmkt=en-US&setlang=en&adlt=off";
    }
    else
    {
        $url = [System.Web.HttpUtility]::UrlEncode($url);
        $newurl = "http://www.bing.com/videos/search?q=$url&qs=n&form=QBVLPG&sc=0-4&sp=-1&sk=&setmkt=en-US&setlang=en&adlt=off";
    }

    ie($newurl);
}

function newurl([string]$url)
{
    if($url -eq "")
    {
        $newurl = "https://www.google.com/ncr"
    }
    else
    {
        $newurl = $url;
    }

    switch($url)
    {
        "cf"{$newurl = "http://codeflow/dashboard"}
        "wiki"{$newurl = "https://www.bingwiki.com/Main_Page"}
        "gg"{$newurl = "https://www.google.com/?gfe_rd=cr&ei=l-3XVuTRCa_R8AeN5LyYCQ&gws_rd=cr&fg=1"}
        "ncr"{$newurl = "https://www.google.com/ncr"}
        "bing"{$newurl = "http://www.bing.com/?setmkt=en-US&setlang=en&uid=FA908932&FORM=NFTOUS"}
        "yt"{$newurl = "https://www.youtube.com/"}
        "mr"{$newurl = "http://stcsrv-c92/MmrV2Reader/"}
        "vh"{$newurl = "http://mmsearchtools/videohistory/"}
        "stamp"{$newurl = "http://stamp/"}
        "cr"{$newurl = "http://xapservices1/xocial"}
        "baja"{$newurl = "http://aka.ms/baja"}
        "pac"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_and_IPG/_search?type=Code&lp=search-project&text=repo%3Apackages%20IsLESHPCNotResolved&result=DefaultCollection%2FPacmanSourceDepot%2Fpackages%2Fpackages%2FXap.Service.RecTopicAnswer.Product%2Fbuddy%2FRecTopicAnswer%2FRecTopicAnswer%2FRecTopicAnswer.Experiment.syncmanifest.xml&preview=1&filters=ProjectFilters%7BPacmanSourceDepot%7DRepositoryFilters%7Bpackages%7D&_a=contents"}
        "wdp"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_and_IPG/_git/WDP_Dev"}
        "vig"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_UX/VideoIG%20Team/_git/VideoIG"}
        "mig"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_UX/VideoIG%20Team/_git/imageig"}
        "xap"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_and_IPG/XAP%20Development%20Experience%20Team/_git/xap"}
        "is"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_and_IPG/XAP%20Development%20Experience%20Team/_git/IndexServe"}
        "ux"{$newurl = "https://msasg.visualstudio.com/DefaultCollection/Bing_UX/VideoIG%20Team/_git/VideoUX"}
        "ismerge"{$newurl = "http://ismerge/ReportServer?/ISMergeReport/CategoryReport&Category=MM Prod&rs:ParameterLanguage=&rc:Parameters=Collapsed&rc:Toolbar=False"}
    }
    return $newurl;
}

function cr([string]$url)
{
    $newurl = newurl($url);
    start "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" $newurl;
}

function ie([string]$url)
{
    $newurl = newurl($url);
    openie($newurl);
}

function bq([string]$url)
{
    $newurl = $url;
    switch($url)
    {
        "wdp"{$newurl = "http://b/queue/MSASG_WDP_Dev_retail"}
        "vig"{$newurl = "http://b/queue/MSASG_videoig_master_retail"}
        "mig"{$newurl = "http://b/queue/MSASG_Imageig_retail"}
        ""{$newurl = "http://b/"}
    }
    ie($newurl);
}

function eg($url)
{
    $newurl = newurl($url);
    start microsoft-edge:$newurl
}

function e
{
	Param($dir)
	$root = (Get-Item -Path ".\" -Verbose).FullName;
	if($dir -ne "" -and $dir -ne $null)
	{
		$root = $dir
	}

	explorer $root
}

function openie($newurl)
{
    if($newurl -eq "")
    {
        $newurl = "https://www.google.com/ncr";
    }
    # Set BrowserNavConstants to open URL in new tab
    # Full list of BrowserNavConstants: https://msdn.microsoft.com/en-us/library/aa768360.aspx

    $navOpenInNewTab = 0x800

    # Get running Internet Explorer instances
    $App = New-Object -ComObject shell.application

    # Grab the last opened tab
    $IE = $App.Windows() | Select-Object -Last 1

    #Load DLL
    $pinvoke = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
    Add-Type -MemberDefinition $pinvoke -name NativeMethods -namespace Win32

    #Get WindowHandle of the COM Object
    $hwnd = $IE.HWND

    if($hwnd -eq $null)
    {
        $IE = New-Object -COM 'InternetExplorer.Application'
        $hwnd = $IE.HWND
    }

    # Minimize window
    [Win32.NativeMethods]::ShowWindowAsync($hwnd, 2)|out-null

    # Restore window
    [Win32.NativeMethods]::ShowWindowAsync($hwnd, 4)|out-null

    # Open link in the new tab nearby
    $IE.navigate($newurl, $navOpenInNewTab)

    # Cleanup
    'App', 'IE' | ForEach-Object {Clear-Variable $_ -Force}
}

function msg()
{
    ##################
    # Messenger like popup dialog
    # Usage:
    # New-Popup.ps1
    # New-Popup.ps1 -slide -message "hello world" -title "PowerShell Popup"


    param(
        [string]$message="Your message here",
        [string]$title="Bing Multimedia",
        [int]$formWidth=300,
        [int]$formHeight=200,
        [int]$wait=4,
        [switch]$slide
    )

    [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")

    ################
    # extract powershell icon if doesn't exist
    $icon = $PSScriptRoot + "\icon.ico"
    if( !(test-path -pathType leaf $icon)){
        [System.Drawing.Icon]::ExtractAssociatedIcon((get-process -id $pid).path).ToBitmap().Save($icon)
    }

    ################
    # Create the form
    $form = new-object System.Windows.Forms.Form
    $form.ClientSize = new-object System.Drawing.Size($formWidth,$formHeight)
    $form.BackColor = [System.Drawing.Color]::LightBlue
    $form.ControlBox = $false
    $form.ShowInTaskbar = $false
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $form.topMost=$true

    # initial form position
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual

    if($slide){
        $top = $screen.WorkingArea.height + $form.height
        $left = $screen.WorkingArea.width - $form.width
        $form.Location = new-object System.Drawing.Point($left,$top)
    } else {
        $top = $screen.WorkingArea.height - $form.height
        $left = $screen.WorkingArea.width - $form.width
        $form.Location = new-object System.Drawing.Point($left,$top)
    }

    ################
    # pictureBox for icon
    $pictureBox = new-object System.Windows.Forms.PictureBox
    $pictureBox.Location = new-object System.Drawing.Point(2,2)
    $pictureBox.Size = new-object System.Drawing.Size(20,20)
    $pictureBox.TabStop = $false
    $pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
    $pictureBox.Load($icon)


    ################
    # create textbox to display the  message
    $textbox = new-object System.Windows.Forms.TextBox
    $textbox.Text = $message
    $textbox.BackColor = $form.BackColor
    $textbox.Location = new-object System.Drawing.Point(4,26)
    $textbox.Multiline = $true
    $textbox.TabStop = $false
    $textbox.WordWrap = $true
    #$textbox.Dock = [System.Windows.Forms.DockStyle]::Fill
    $textbox.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Italic)
    $textbox.BorderStyle = [System.Windows.Forms.BorderStyle]::None
    $textboxWidth = $formWidth
    $textboxHeight = $formHeight - 30
    $textbox.Size = new-object System.Drawing.Size($textboxWidth,$textboxHeight)
    $textbox.AutoSize = $True
    $textbox.Cursor = [System.Windows.Forms.Cursors]::Default
    $textbox.HideSelection = $false

    ################
    # Create 'Close' button, when clicked hide and dispose the form
    $button = new-object system.windows.forms.button
    $button.Font = new-object System.Drawing.Font("Webdings",12)
    $buttonx = $form.Width - 20
    $button.Location = new-object System.Drawing.Point($buttonx,4)
    $button.Size = new-object System.Drawing.Size(16,16)
    $button.Text = [char]114
    $button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $button.Add_Click({ $form.hide(); $form.dispose() })
    if($slide) {$button.visible=$false}

    ################
    # Create a label, for title text
    $label = new-object System.Windows.Forms.Label
    $label.Font = new-object System.Drawing.Font("Microsoft Sans Serif",12,[System.Drawing.FontStyle]::Bold)
    $label.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $label.Text = $title
    $label.Location = new-object System.Drawing.Point(24,3)
    $label.Size = new-object System.Drawing.Size(174, 20)
    #$label.Dock = [System.Windows.Forms.DockStyle]::Top


    ################
    # Create a timer to slide the form
    $timer = new-object System.Windows.Forms.Timer
    $timer.Enabled=$false
    $timer.Interval=10
    $timer.tag="up"
    $timer.add_tick({

                    if(!$slide){return}

                    if($timer.tag -eq "up"){
                        $timer.enabled=$true
                        $form.top-=2
                        if($form.top -le ($screen.WorkingArea.height - $form.height)){
                            #$timer.enabled=$false
                            $timer.tag="down"
                            start-sleep $wait
                        }
                    } else {

                        $form.top+=2
                        if($form.top -eq ($screen.WorkingArea.height + $form.height)){
                            $timer.enabled=$false
                            $form.dispose()
                        }
                    }
                })


    # add form event handlers
    $form.add_shown({
                        $form.Activate()
                        (new-Object System.Media.SoundPlayer "$env:windir\Media\notify.wav").play()
                        $timer.enabled=$true
                    })

    # draw seperator line
    $form.add_paint({
                        $gfx = $form.CreateGraphics()
                        $pen = new-object System.Drawing.Pen([System.Drawing.Color]::Black)
                        $gfx.drawLine($pen,0,24,$form.width,24)
                        $pen.dispose()
                        $gfx.dispose()
                    })



    ################
    # add controls to the form
    # hide close button if form is not sliding

    if($slide){
        $form.Controls.AddRange(@($label,$textbox,$pictureBox))
    } else {
        $form.Controls.AddRange(@($button,$label,$textbox,$pictureBox))
    }

    ################
    # show the form
    [void]$form.showdialog()
}

function dd
{
    $ES = "$PSScriptRoot\es.exe";
    if ($PSVersionTable['PSVersion'].Major -le 2) {
        $PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    }

    if (!(Test-Path (Resolve-Path $ES).Path)){
        Write-Warning "Everything commandline es.exe could not be found on the system please download and install via http://www.voidtools.com/es.zip"
        exit
    }

    $currentRoot = (Get-Item -Path ".\" -Verbose).FullName;
    $search = [system.string]::Join(' ', $args);
    if($search -eq "")
    {
        & (Resolve-Path $ES).Path --help
        return;
    }
	
	$result =  [System.Collections.ArrayList]@()
	
	if($args.Length -gt 1 -and $args[0] -eq ".")
	{
	    $dirs = Get-ChildItem -Directory

		foreach($dir in $dirs)
		{
			if($dir.Name.ToLower().IndexOf($args[1].ToLower()) -ge 0)
			{
				$result.Add($dir.FullName) | Out-Null
			}
		}
	}
	else
	{
		$path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($search)
		if([System.IO.Directory]::Exists($path))
		{
			pushd $path
			return;
		}

		$result = & (Resolve-Path $ES).Path $args
		if($result.Count -lt 1){
			Write-Host -ForegroundColor Red "Not found the directory: $search";
			return;
		}
	}

    if($result.Count -eq 1)
    {
        $record = $result;
        if([System.IO.Directory]::Exists($result)){
            pushd $result
        }
    }
    else
    {
        $newArray =  [System.Collections.ArrayList]@()
        $i = 0;

        foreach($dir in $result)
        {
            if([System.IO.Directory]::Exists($dir))
            {
                if($dir.ToLower().StartsWith($currentRoot.ToLower()))
                {
                    $newArray.Insert(0, $dir) | Out-Null
                }
                else
                {
                    $newArray.Add($dir) | Out-Null
                }
            }
        }

        foreach($dir in $newArray)
        {
            Write-Host "[ $i ] "  $dir
            $i++;
        }

        while($true)
        {
            $arrlen = $newArray.Count - 1;
            if($arrlen -eq 0)
            {
				pushd $newArray[0]
                break;
            }
            elseif($arrlen -lt 0)
            {
                Write-Host "Not found the dir $search"
                break;
            }

            $flag = $true
            $userInput = Read-host "Choose the above folder to fast jump [0 - $arrlen] / [Filter]"
			if($userInput -eq "")
			{
				pushd $newArray[0]
                break;
			}
			
            try
            {
                [int]$inputNum = [convert]::ToInt32($userInput, 10)
            }
            catch
            {
                $flag = $false;
            }
                
            if($flag -and $inputNum -ge 0 -and $inputNum -le $arrlen)
            {
				pushd $newArray[$inputNum]
                break;
            }
            else
            {
                $keys = $userInput.ToLower() -split ' '

                for($i = $arrlen; $i -ge 0; $i--)
                {
                    $del = $false
                    foreach($key in $keys)
                    {
                        if($key -eq "")
                        {
                            continue;
                        }
                    
                        if($newArray[$i].ToLower().IndexOf($key) -lt 0)
                        {
                            $del = $true;
                            break;
                        }
                    }

                    if($del)
                    {
                        $newArray.RemoveAt($i)
                    }
                }

                if($newArray -gt 0)
                {
                    $i = 0;
                    foreach($dir in $newArray)
                    {
                        Write-Host "[ $i ] "  $dir
                        $i++;
                    }
                }
                else
                {
                    Write-Host "No results after filter!!!";
                    break;
                }
            }
        }
    }
}



function ff
{
    $ES = "$PSScriptRoot\es.exe";
    if ($PSVersionTable['PSVersion'].Major -le 2) {
        $PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    }

    if (!(Test-Path (Resolve-Path $ES).Path)){
        Write-Warning "Everything commandline es.exe could not be found on the system please download and install via http://www.voidtools.com/es.zip"
        exit
    }
	
    $search = [system.string]::Join(' ', $args);
    if($search -eq "")
    {
        & (Resolve-Path $ES).Path --help
        return
    }
	
	$result =  [System.Collections.ArrayList]@()
	
	if($args.Length -gt 1 -and $args[0] -eq ".")
	{
	    $files = Get-ChildItem -File

		foreach($file in $files)
		{
			if($file.Name.ToLower().IndexOf($args[1].ToLower()) -ge 0)
			{
				$result.Add($file.FullName) | Out-Null
			}
		}
	}
	else
	{
		$path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($search)
		if([System.IO.File]::Exists($path))
		{
			 editor $path
			 return;
		}

		$result = & (Resolve-Path $ES).Path $args
		if($result.Count -lt 1){
			Write-Host -ForegroundColor Red "Not found the file: $search";
			return;
		}
	}

    if($result.Count -eq 1)
    {
        if([System.IO.File]::Exists($result)){
            editor $result
            return;
        }
    }
    else
    {
        $newArray =  [System.Collections.ArrayList]@()
        $i = 0;
        foreach($file in $result)
        {
            if([System.IO.File]::Exists($file)){
                Write-Host "[ $i ] "  $file
                $i++;
                $newArray.Add($file) | Out-Null
            }
        }

        while($true)
        {
            $arrlen = $newArray.Count - 1;
            if($arrlen -eq 0)
            {
                editor $newArray[0]
                break;
            }

            $flag = $true
            $userInput = Read-host "Choose the above file to fast open with editor [0 - $arrlen] / [Filter]"
			if($userInput -eq "")
			{
				editor $newArray[0]
                break;
			}
			
            try
            {
                [int]$inputNum = [convert]::ToInt32($userInput, 10)
            }
            catch
            {
                $flag = $false;
            }
                
            if($flag -and $inputNum -ge 0 -and $inputNum -le $arrlen)
            {
                editor $newArray[$inputNum]
                break;
            }
            else
            {
                $keys = $userInput.ToLower() -split ' '

                for($i = $arrlen; $i -ge 0; $i--)
                {
                    $del = $false
                    foreach($key in $keys)
                    {
                        if($key -eq "")
                        {
                            continue;
                        }
                    
                        if($newArray[$i].ToLower().IndexOf($key) -lt 0)
                        {
                            $del = $true;
                            break;
                        }
                    }

                    if($del)
                    {
                        $newArray.RemoveAt($i)
                    }
                }

                if($newArray -gt 0)
                {
                    $i = 0;
                    foreach($file in $newArray)
                    {
                        Write-Host "[ $i ] "  $file
                        $i++;
                    }
                }
                else
                {
                    Write-Host "No results after filter!!!";
                    break;
                }
            }
        }
    }
}