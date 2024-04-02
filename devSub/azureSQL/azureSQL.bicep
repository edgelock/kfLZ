param location string = resourceGroup().location
param region string = 'eus2'
param environment string = 'dev'
param suffix string = 'cms'
@description('The name of the SQL logical server.')
param serverName string = 'sql-${region}-${environment}-${suffix}'

@description('The name of the SQL Database.')
param sqlDBName string = 'sql-db01-${region}-${environment}-${suffix}'

@description('The administrator username of the SQL logical server.')
param administratorLogin string = 'cmssqladmin'

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string = 'Pc!C0mpl!@nc3'

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}
