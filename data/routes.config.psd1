@{
    "northeurope" = @{
        "web-app" = @(
            "52.232.19.246", 
            "20.38.84.81"
        )
        "control-plane-nat" = @(
            "23.100.0.135", 
            "20.38.84.80"
        )
        "scc-relay" = @(
            "tunnel.westeurope.azuredatabricks.net"
            "tunnel.northeuropec2.azuredatabricks.net"
        )
        "metastore" = "consolidated-northeurope-prod-metastore.mysql.database.azure.com"
        "artifact-blob-storage-primary" = "dbartifactsprodnortheu.blob.core.windows.net"
        "artifact-blob-storage-secondary" = "dbartifactsprodwesteu.blob.core.windows.net"
        "log-blob-storage" = "dblogprodwesteurope.blob.core.windows.net"
        "event-hub" = "prod-westeurope-observabilityeventhubs.servicebus.windows.net"
    }
    "westeurope" = @{
        "web-app" = @(
            "52.232.19.246", 
            "40.74.30.80"
        )
        "control-plane-nat" = @(
            "23.100.0.135", 
            "40.74.30.81"
        )
        "scc-relay" = @(
            "tunnel.westeurope.azuredatabricks.net"
            "tunnel.westeuropec2.azuredatabricks.net"
        )
        "metastore" = "consolidated-westeurope-prod-metastore.mysql.database.azure.com"
        "artifact-blob-storage-primary" = "dbartifactsprodwesteu.blob.core.windows.net"
        "artifact-blob-storage-secondary" = "dbartifactsprodnortheu.blob.core.windows.net"
        "log-blob-storage" = "dblogprodwesteurope.blob.core.windows.net"
        "event-hub" = "prod-westeurope-observabilityeventhubs.servicebus.windows.net"
    }
    "uaenorth" = @{
        "web-app" = "40.123.212.253"
        "control-plane-nat" = "40.123.218.63"
        "scc-relay" = "tunnel.uaenorth.azuredatabricks.net"
        "metastore" = "consolidated-uaenorth-prod-metastore.mysql.database.azure.com"
        "artifact-blob-storage-primary" = "dbartifactsproduaenorth.blob.core.windows.net"
        "artifact-blob-storage-secondary" = "dbartifactsprodsafrican.blob.core.windows.net"
        "log-blob-storage" = "dblogproduaenorth.blob.core.windows.net"
        "event-hub" = "prod-uaenorth-observabilityeventhubs.servicebus.windows.net"
    }
}