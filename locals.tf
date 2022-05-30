locals {

  throttle-definition = {
    Comment = "A description of my state machine"
    StartAt = "DescribeReplicationConfigurationTemplates"
    States = {
      DescribeReplicationConfigurationTemplates = {
        Next = "UpdateReplicationConfigurationTemplate"
        Parameters = {
          ReplicationConfigurationTemplateIDs = [
            var.ReplicationConfigurationTemplateID
          ]
        }
        Resource = "arn:aws:states:::aws-sdk:mgn:describeReplicationConfigurationTemplates"
        Type     = "Task"
      }
      UpdateReplicationConfigurationTemplate = {
        End = true
        Parameters = {
          BandwidthThrottling                = var.Bandwidth
          ReplicationConfigurationTemplateID = var.ReplicationConfigurationTemplateID
        }
        Resource = "arn:aws:states:::aws-sdk:mgn:updateReplicationConfigurationTemplate"
        Type     = "Task"
      }
    }
  }

  throttle-definition-2 = {
    Comment : "A description of my state machine",
    StartAt : "DescribeSourceServers",
    States : {
      DescribeSourceServers : {
        Type : "Task",
        Parameters : {
          Filters : {
            SourceServerIDs : var.SourceserverID,
          }
        },
        Resource : "arn:aws:states:::aws-sdk:mgn:describeSourceServers",
        Next : "UpdateReplicationConfiguration"
      },
      UpdateReplicationConfiguration : {
        Type : "Task",
        End : true,
        Parameters : {
          SourceServerID : var.SourceserverID
          BandwidthThrottling : var.Bandwidth-2
        },
        Resource : "arn:aws:states:::aws-sdk:mgn:updateReplicationConfiguration"
      }
    }
  }


}