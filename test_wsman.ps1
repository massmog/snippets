Clear-Host
$servers = ConvertFrom-Csv @"
Hostname,           Location
PC1,                Arbeitsplatz
homerouter.cpe,     Arbeitsplatz
BRW40B89ABA9E5B,    Rollcontainer
"@.Replace(' ', '')

#$admin_cred = Get-Credential -Credential PC1\Administrator

foreach($server in $servers) {
    try { 
        $all = Test-WSMan -ComputerName $server.'Hostname' -Authentication Default -ErrorAction Stop #-Credential $admin_cred; 
        if($null -ne $all){
            Write-Host "$($server.Hostname) ONLINE"
        }
    }
    catch {
        Write-Host "$($server.Hostname) OFFLINE"
    } 
}