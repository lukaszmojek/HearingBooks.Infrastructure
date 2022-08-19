param servicePlanDetails object = {
  name: 'hearing-books-service-plan'
  location: resourceGroup().location
  kind: 'linux'
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
    family: 'F'
    capacity: 1
  }
} 

resource servicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: servicePlanDetails.name
  location: servicePlanDetails.location
  sku: servicePlanDetails.sku
  kind: servicePlanDetails.kind
}
