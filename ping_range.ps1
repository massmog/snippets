#Ping Range
#clear-host

write-host 'Creating ping tasks...'
1..256 | ForEach-Object {
   $all = Start-ThreadJob {
        if (test-connection "192.168.8.$($args)" -quiet -TimeoutSeconds 2 -Count 1) {
            $res = Resolve-DnsName "192.168.8.$($args)";
            write-host "SUCCESS 192.168.8.$($args)" 
        } 
    }-ArgumentList $_ -ThrottleLimit 100
}; 
write-host 'Waiting for ping results...'
$a = get-Job | Wait-Job
write-host 'Results:'
get-job | receive-job
get-job | stop-job

get-job | remove-job