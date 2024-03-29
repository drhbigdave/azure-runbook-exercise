resource "azurerm_resource_group" "example" {
  name     = "resourceGroup1"
  location = "East US"
}

resource "azurerm_automation_account" "example" {
  name                = "account1"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"

  sku {
    name = "Basic"
  }
}

#data "local_file" "example" {
#  filename = "${path.module}/example.ps1"
#}

resource "azurerm_automation_runbook" "example" {
  name                = "Get-AzureVMTutorial"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  account_name        = "${azurerm_automation_account.example.name}"
  log_verbose         = "true"
  log_progress        = "true"
  description         = "This is an example runbook"
  runbook_type        = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/drhbigdave/azure-runbook-exercise/master/Get-AzureVMTutorialv001.ps1"
  }

}