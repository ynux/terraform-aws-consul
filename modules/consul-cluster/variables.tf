# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "cluster_name" {
  description = "The name of the Consul cluster (e.g. consul-stage). This variable is used to namespace all resources created by this module."
}

variable "ami_id" {
  description = "The ID of the AMI to run in this cluster. Should be an AMI that had Consul installed and configured by the install-consul module."
}

variable "instance_type" {
  description = "The type of EC2 Instances to run for each node in the cluster (e.g. t2.micro)."
}

variable "vpc_id" {
  description = "The ID of the VPC in which to deploy the Consul cluster"
}

variable "allowed_inbound_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow connections to Consul"
  type        = "list"
}

variable "user_data" {
  description = "A User Data script to execute while the server is booting. We recommend passing in a bash script that executes the run-consul script, which should have been installed in the Consul AMI by the install-consul module."
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "cluster_size" {
  description = "The number of nodes to have in the Consul cluster. We strongly recommended that you use either 3 or 5."
  default     = 3
}

variable "cluster_tag_key" {
  description = "Add a tag with this key and the value var.cluster_tag_value to each Instance in the ASG. This can be used to automatically find other Consul nodes and form a cluster."
  default     = "consul-servers"
}

variable "cluster_tag_value" {
  description = "Add a tag with key var.clsuter_tag_key and this value to each Instance in the ASG. This can be used to automatically find other Consul nodes and form a cluster."
  default     = "auto-join"
}

variable "subnet_ids" {
  description = "The subnet IDs into which the EC2 Instances should be deployed. We recommend one subnet ID per node in the cluster_size variable. At least one of var.subnet_ids or var.availability_zones must be non-empty."
  type        = "list"
  default     = []
}

variable "availability_zones" {
  description = "The availability zones into which the EC2 Instances should be deployed. We recommend one availability zone per node in the cluster_size variable. At least one of var.subnet_ids or var.availability_zones must be non-empty."
  type        = "list"
  default     = []
}

variable "ssh_key_name" {
  description = "The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair."
  default     = ""
}

variable "allowed_ssh_cidr_blocks" {
  description = "A list of CIDR-formatted IP address ranges from which the EC2 Instances will allow SSH connections"
  type        = "list"
  default     = []
}

variable "allowed_ssh_security_group_ids" {
  description = "A list of security group IDs from which the EC2 Instances will allow SSH connections"
  type        = "list"
  default     = []
}

variable "allowed_ssh_security_group_count" {
  description = "The number of entries in var.allowed_ssh_security_group_ids. Ideally, this value could be computed dynamically, but we pass this variable to a Terraform resource's 'count' property and Terraform requires that 'count' be computed with literals or data sources only."
  default     = 0
}

variable "allowed_inbound_security_group_ids" {
  description = "A list of security group IDs that will be allowed to connect to Consul"
  type        = "list"
  default     = []
}

variable "allowed_inbound_security_group_count" {
  description = "The number of entries in var.allowed_inbound_security_group_ids. Ideally, this value could be computed dynamically, but we pass this variable to a Terraform resource's 'count' property and Terraform requires that 'count' be computed with literals or data sources only."
  default     = 0
}

variable "additional_security_group_ids" {
  description = "A list of additional security group IDs to add to Consul EC2 Instances"
  type        = "list"
  default     = []
}

variable "security_group_tags" {
  description = "Tags to be applied to the LC security group"
  type        = "map"
  default     = {}
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default."
  default     = "Default"
}

variable "associate_public_ip_address" {
  description = "If set to true, associate a public IP address with each EC2 Instance in the cluster."
  default     = false
}

variable "spot_price" {
  description = "The maximum hourly price to pay for EC2 Spot Instances."
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance. Must be one of: empty string, default or dedicated. For EC2 Spot Instances only empty string or dedicated can be used."
  default     = ""
}

variable "root_volume_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized."
  default     = false
}

variable "root_volume_type" {
  description = "The type of volume. Must be one of: standard, gp2, or io1."
  default     = "standard"
}

variable "root_volume_size" {
  description = "The size, in GB, of the root EBS volume."
  default     = 50
}

variable "root_volume_delete_on_termination" {
  description = "Whether the volume should be destroyed on instance termination."
  default     = true
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  default     = "10m"
}

variable "service_linked_role_arn" {
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  default     = ""
}

variable "health_check_type" {
  description = "Controls how health checking is done. Must be one of EC2 or ELB."
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time, in seconds, after instance comes into service before checking health."
  default     = 300
}

variable "instance_profile_path" {
  description = "Path in which to create the IAM instance profile."
  default     = "/"
}

variable "server_rpc_port" {
  description = "The port used by servers to handle incoming requests from other agents."
  default     = 8300
}

variable "cli_rpc_port" {
  description = "The port used by all agents to handle RPC from the CLI."
  default     = 8400
}

variable "serf_lan_port" {
  description = "The port used to handle gossip in the LAN. Required by all agents."
  default     = 8301
}

variable "serf_wan_port" {
  description = "The port used by servers to gossip over the WAN to other servers."
  default     = 8302
}

variable "http_api_port" {
  description = "The port used by clients to talk to the HTTP API"
  default     = 8500
}

variable "dns_port" {
  description = "The port used to resolve DNS queries."
  default     = 8600
}

variable "ssh_port" {
  description = "The port used for SSH connections"
  default     = 22
}

variable "tags" {
  description = "List of extra tag blocks added to the autoscaling group configuration. Each element in the list is a map containing keys 'key', 'value', and 'propagate_at_launch' mapped to the respective values."
  type        = "list"
  default     = []
}

variable "enabled_metrics" {
  description = "List of autoscaling group metrics to enable."
  type        = "list"
  default     = []
}

variable "enable_iam_setup" {
  description = "If true, create the IAM Role, IAM Instance Profile, and IAM Policies. If false, these will not be created, and you can pass in your own IAM Instance Profile via var.iam_instance_profile_name."
  type        = bool
  default     = true
}

variable "iam_instance_profile_name" {
  description = "If enable_iam_setup is false then this will be the name of the IAM instance profile to attach"
  default     = ""
}
