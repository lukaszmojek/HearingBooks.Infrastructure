param location string = resourceGroup().location
param skuName string = 'F0'

@allowed([
  ''
  'test'
  'staging'
  'production'
])
param environment string = ''

var environmentSuffix = environment == '' ? '' : '-${environment}'

var speechServiceName = 'hearing-books-speech-services${environmentSuffix}'

resource speech 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: speechServiceName
  location: location
  sku: {
    name: skuName
  }
  kind: 'SpeechServices'
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
