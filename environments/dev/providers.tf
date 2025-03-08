# Provider Block
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 1.0" 
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg-terraform-remote-state"
    storage_account_name  = "stterraformstate759"
    container_name        = "tfstate"
    key                   = "dev.terraform.tfstate"
    
  }
}

terraform {
  required_version = ">= 1.0" 
}


provider "azurerm" {
  features {}
}

