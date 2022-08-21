param location string = resourceGroup().location

@allowed([
  ''
  'test'
  'staging'
  'production'
])
param environment string = ''

var environmentSuffix = environment == '' ? '' : '-${environment}'

var servicePlan = {
  name: 'hearing-books-service-plan${environmentSuffix}'
  location: location
  kind: 'linux'
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 1
  }
}

var api = {
  name: 'hearing-books-api${environmentSuffix}'
  location: location
  kind: 'app,${servicePlan.kind}'
}

var storageAccount = {
  name: 'hearingbooks${environment}'
  location: location
  sku:{
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
}

resource serverFarm 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: servicePlan.name
  location: servicePlan.location
  sku: servicePlan.sku
  kind: servicePlan.kind
}

resource apiAppService 'Microsoft.Web/sites@2022-03-01' = {
  name: api.name
  location: api.location
  kind: api.kind
  properties: {
    serverFarmId: serverFarm.id
  }

  resource hostNameBindings 'hostNameBindings@2022-03-01' = {
    name: '${api.name}.azurewebsites.net'
    properties: {
      siteName: apiAppService.name
      hostNameType: 'Verified'
    }
  }
}

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccount.name
  location: storageAccount.location
  kind: 'StorageV2'
  sku: storageAccount.sku
  properties: {
    accessTier: 'Hot'
  }

  resource blob 'blobServices' = {
    name: 'default'
  }
}
