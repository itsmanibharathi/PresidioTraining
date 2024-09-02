# Day2
## Task 1
Develop and execute a solution to migrate the data from an Excel file into an Azure SQL Server
database with the help of Azure Data Factory (ADF) and Azure Storage Account. Please migrate only the
mentioned columns, with the correct data type.

> Azure Resource

![image](https://github.com/user-attachments/assets/5cbbd4d0-3e06-42b6-b9f7-9032048d7e98)

![image](https://github.com/user-attachments/assets/66ceb777-30f3-4891-a53e-b9718753e431)

![image](https://github.com/user-attachments/assets/e1b46a7d-f332-47fa-bdc1-e6b9aab605fd)

![image](https://github.com/user-attachments/assets/09feb1a0-f546-43de-b9d3-fb7cd1f70cb2)

![image](https://github.com/user-attachments/assets/5cde3b6d-dd70-41cd-80b1-12e2437c8daa)

>Source Data

![image](https://github.com/user-attachments/assets/16a31b8b-5a6a-4d5d-bc4e-56efa9b46472)

> Target

![image](https://github.com/user-attachments/assets/7583d461-270a-43e5-adea-0541d227db14)

## Task 2

What does Azure Migrate do? Perform a hands-on database assessment using Azure Migrate and
migrate databases from a VM to a SQL Managed Instance.

**Source :** Local Sql Server

**Target :** Azure Sql db

### Assessments Report

```json
{
  "Status": "Completed",
  "TargetPlatform": "AzureSqlDatabase",
  "Name": "Demo",
  "SourcePlatform": "SqlOnPrem",
  "StartedOn": "2024-09-02T09:39:10.7364794+00:00",
  "Databases": [
    {
      "ServerName": "J9GCBX3\\KIKO",
      "Name": "dbGenSparkCapstoneProject",
      "CompatibilityLevel": "CompatLevel160",
      "SizeMB": 16.0,
      "Status": "Completed",
      "ServerVersion": "16.0.1121.4",
      "AssessmentRecommendations": [
        {
          "CompatibilityLevel": "CompatLevel160",
          "Category": "Compatibility",
          "Severity": "Warning",
          "ChangeCategory": "BreakingChange",
          "RuleId": "ServiceBroker",
          "Title": "Service Broker feature is not supported in Azure SQL Database",
          "Impact": "SQL Server Service Broker provides native support for messaging and queuing applications in the SQL Server Database Engine. Service Broker feature is not supported in Azure SQL Database.",
          "Recommendation": "Service Broker feature is not supported in Azure SQL Database. Consider migrating to Azure SQL Managed Instance that supports service broker within the same instance. Alternatively, migrate to SQL Server on Azure Virtual Machine.",
          "MoreInfo": "()",
          "ImpactedObjects": [
            {
              "Name": "dbGenSparkCapstoneProject",
              "ObjectType": "Database",
              "ImpactDetail": "",
              "SuggestedFixes": []
            }
          ]
        }
      ],
      "ServerEdition": "Enterprise Evaluation Edition (64-bit)"
    }
  ],
  "ServerInstances": [
    {
      "ServerName": "J9GCBX3\\KIKO",
      "Version": "16.0.1121.4",
      "Status": "Completed",
      "AssessmentRecommendations": [
        {
          "Category": "FeatureParity",
          "Severity": "Information",
          "FeatureParityCategory": "UnsupportedFeature",
          "RuleId": "AgentJobs",
          "Title": "SQL Server Agent jobs are not available in Azure SQL Database",
          "Impact": "SQL Server Agent is a Microsoft Windows service that executes scheduled administrative tasks, which are called jobs in SQL Server. SQL Server Agent jobs are not available in Azure SQL Database.",
          "Recommendation": "Use Elastic Database Jobs (preview), which are the replacement for SQL Server Agent jobs in Azure SQL Database. Elastic Database Jobs for Azure SQL Database allow you to reliably execute T-SQL scripts that span multiple databases while automatically retrying and providing eventual completion guarantees.  Alternatively consider migrating to Azure SQL Managed Instance or SQL Server on Azure Virtual Machines.",
          "MoreInfo": "Getting started with Elastic Database Jobs (Preview) (https://docs.microsoft.com/en-us/azure/azure-sql/database/elastic-jobs-overview)",
          "ImpactedObjects": [
            {
              "Name": "syncTable",
              "ObjectType": "Job",
              "ImpactDetail": "",
              "SuggestedFixes": []
            }
          ]
        },
        {
          "Category": "FeatureParity",
          "Severity": "Warning",
          "FeatureParityCategory": "UnsupportedFeature",
          "RuleId": "ServiceBroker",
          "Title": "Service Broker feature is not supported in Azure SQL Database",
          "Impact": "SQL Server Service Broker provides native support for messaging and queuing applications in the SQL Server Database Engine. Service Broker feature is not supported in Azure SQL Database.",
          "Recommendation": "Service Broker feature is not supported in Azure SQL Database. Consider migrating to Azure SQL Managed Instance that supports service broker within the same instance. Alternatively, migrate to SQL Server on Azure Virtual Machine.",
          "MoreInfo": "()",
          "ImpactedObjects": [
            {
              "Name": "dbGenSparkCapstoneProject",
              "ObjectType": "Databases",
              "ImpactDetail": null,
              "SuggestedFixes": []
            }
          ]
        }
      ]
    }
  ],
  "EndedOn": "2024-09-02T09:39:15.7714057+00:00",
  "EvaluateFeatureRecommendations": false,
  "EvaluateCompatibilityIssues": true,
  "EvaluateFeatureParity": true,
  "DmaVersion": {}
}
```
![image](https://github.com/user-attachments/assets/fdb9d7d0-9c02-4a4c-9275-a730fa9c3cf6)


### Migration
![image](https://github.com/user-attachments/assets/df95be0f-6012-43e4-b6d9-28d6dff4b1e9)


