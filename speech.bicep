param location string = resourceGroup().location
param skuName string = 'F0'
param speechServiceName string = 'hearing-books-speech-services'

resource speech 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: speechServiceName
  location: location
  sku: {
    name: skuName
  }
  kind: 'SpeechServices'
  properties: {
    publicNetworkAccess: 'Enabled'
    restore: true
  }
}
