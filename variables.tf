############################
# Step Function - command 1
############################

variable "ReplicationConfigurationTemplateID" {
  description = "The ID of the Replication Configuration Template"
  type        = string
}

variable "Bandwidth" {
  description = "The chosen bandwith"
  type        = number
}

variable "step-expression" {
  description = "This is the cron job timings for the first commands CW alarm trigger"
  type        = string

}

############################
# Step Function - command 2
############################

variable "SourceserverID" {
  description = "The source server id's"
  type        = list(string)
}

variable "Bandwidth-2" {
  description = "The chosen bandwith"
  type        = number
}

variable "step-expression-2" {
  description = "This is the cron job timings for the first commands CW alarm trigger"
  type        = string

}
