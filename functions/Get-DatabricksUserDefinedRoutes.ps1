function Get-DatabricksUserDefinedRoutes {
    <#
    .Synopsis
    Get list of Databricks user-defined routes
    .DESCRIPTION
    Gets a list of user-defined routes to be added to a route table
    to allow a Databricks workspace to communicate with the Control Plane
    and other components. 
    .EXAMPLE
    Get-DatabricksUserDefinedRoutes -Workspace (Get-AzDatabricksWorkspace -Name <name> -ResourceGroupName <resource_group>)
    .INPUTS
        -Workspace - Databricks Workspace object
    .OUTPUTS
    [PSCustomObject[]] $routes - List of routes with name and cidr
    .NOTES
    This function should be used in conjuntion with other functions to transform an ARM parameters file
    #>

    [cmdletbinding()]
    Param(
        [parameter(Mandatory=$true)]
        [PSCustomObject] $Workspace
    )

    function Get-IpAddress {
        [cmdletbinding()]
        Param(
            [parameter(Position=1)]
            [string]$IpOrDns
        )

        if (Test-Dns $IpOrDns) {
            return ([System.Net.Dns]::GetHostAddresses($IpOrDns)[0]).IpAddressToString + "/32"
        } 
        elseif (Test-IpAddress $IpOrDns) {
            return $IpOrDns + "/32"
        } 
        else {
            throw "$IpOrDns is not a valid host name or IP address."
        }
    }

    $managedResourceGroupName = (Get-AzResourceGroup -Id $Workspace.ManagedResourceGroupId).ResourceGroupName
    $managedStorageAccountName = (Get-AzStorageAccount -ResourceGroupName $managedResourceGroupName).StorageAccountName

    $routeConfig = Import-PowershellDataFile "$($PSScriptRoot)/../data/routes.config.psd1"
    $locationRouteConfig = $routeConfig.GetEnumerator() | Where-Object {$_.Name -eq $Workspace.Location}
    
    if ($managedStorageAccountName) {
        $locationRouteConfig.Value.Add("dbfs-root-blob-storage", "$managedStorageAccountName.blob.core.windows.net")
    }

    if ($locationRouteConfig) {
        $routes = $locationRouteConfig.Value.GetEnumerator() | Foreach-Object {
            $routeName = "databricks-" + $_.Name

            if ($_.Value -is [array]) {
                $routes = $_.Value | Foreach-Object {$i = 1}{
                    $route = @{
                        name = $routeName + "-" + "$i".PadLeft(3, "0")
                        addressPrefix = Get-IpAddress $_
                        nextHopType = "Internet"
                    }
                    ++$i

                    $route
                }
                $routes
            } 
            elseif ($_.Value -is [string]) {
                @{
                    name = $routeName
                    addressPrefix = Get-IpAddress $_.Value
                    nextHopType = "Internet"
                }
            } 
            else {
                throw "Route value must be either [array] or [string]."
            }
        }

        $routes
    } 
    else {
        throw "$Location is not a supported location."
    }
}