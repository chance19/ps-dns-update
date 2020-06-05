# Powershell script to update the DNS entries of a Windows based machine.

# Get the current dns servers applied to all network interfaces
$currentDNS = Get-DnsClientServerAddress

# Loop through each interface and determine which interfaces need updating
foreach($obj in $currentDNS)
{
    # If the interface currently has an entry that is like 192.168.102.16 then run the Set-DnsClientServerAddress command, else, don't make a change
    if ($obj.Address -like "192.168.10.10"){
        Write-host $obj.InterfaceAlias
        Write-host "Interface ID : $($obj.name) : Has DNS :  $($obj.address)" 
        Set-DnsClientServerAddress -InterfaceIndex $obj.name -ServerAddresses ("192.168.10.10","192.168.10.12","10.1.0.10","10.2.0.10")
    } else {
        Write-host "Interface ID : $($obj.name) : No DNS entries, no change" 
    }
}

# IP Config to check that the change has taken affect.
ipconfig /all