targetScope = 'resourceGroup'

param location string = resourceGroup().location

@description('Project name')
param projectName string = 'SAFEGlobal'