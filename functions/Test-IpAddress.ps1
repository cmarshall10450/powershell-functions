function Test-IpAddress {
    [cmdletbinding()]
    Param(
        [parameter(Position=1)]
        [string]$IpAddress
    )

    $re = [regex]"^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"

    ($re.Match($IpAddress)).Success
}