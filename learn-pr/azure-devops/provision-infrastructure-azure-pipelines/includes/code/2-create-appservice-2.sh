#!/bin/bash

# Create the resource group.
az group create \
  --name my-rg \
  --location northeurope

# Create the app service plan.
az appservice plan create \
  --resource-group my-rg \
  --name my-asp \
  --is-linux

# Create the app service.
az webapp create \
  --resource-group my-rg \
  --plan my-asp \
  --name my-webapp \
  --runtime "DOTNET|5.0"