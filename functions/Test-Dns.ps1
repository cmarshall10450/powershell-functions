function Test-Dns {
    [cmdletbinding()]
    Param(
        [parameter(Position=1)]
        [string]$HostName
    )

    $re = [regex]"^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$"

    ($re.Match($HostName)).Success
}