variable "env_name" {
  type = "string"
}
variable "region" {
  type = "string"
}
variable "google_project_id" {
  type = "string"
}
variable "ip_cidr_range" {
  type = "string"
}
variable "zone" {
    type = "string"
}
variable "vof_disk_image" {
    type = "string"
}
variable "vof_disk_size" {
  type = "string"
}
variable "vof_disk_type" {
  type = "string"
}
variable "machine_type" {
  type = "string"
}
variable "max_instances" {
  type = "string"
}
variable "min_instances" {
  type = "string"
}
variable "healthy_threshold" {
  type = "string"
}
variable "unhealthy_threshold" {
  type = "string"
}
variable "timeout_sec" {
  type = "string"
}
variable "check_interval_sec" {
  type = "string"
}
variable "request_path" {
  type = "string"
}
variable "vof_host" {
  type = "string"
  default = "105.21.32.62"
}
variable "database_master_replica_password" {
  type = "string"
}
variable "database_charset" {
  type = "string"
}
variable "database_master_replica_name" {
  type = "string"
}
variable "database_collation" {
  type = "string"
}
variable "database_disk_type" {
  type = "string"
}
variable "database_activation_policy" {
  type = "string"
}
variable "database_pricing_plan" {
  type = "string"
}
variable "database_disk_size" {
  type = "string"
}
variable "database_machine_type_tier" {
  type = "string"
}
variable "database_region" {
  type = "string"
}
variable "database_backup_binary_log_enabled" {
  type = "string"
}
variable "database_backup_enabled" {
  type = "string"
}
variable "database_backup_start_time" {
  type = "string"
}
variable "database_failover_target" {
  type = "string"
}
variable "database_connect_retry_interval" {
  type = "string"
}
variable "state_path" {
  type = "string"
}

variable "credential_file" {
  type = "string"
  default = "service-account.json"
}
variable "db_instance_tier" {
  type = "string"
  default = "db-f1-micro"
}