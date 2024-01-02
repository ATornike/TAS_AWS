variable "s3_buckets" {
  // The buckets are dynamically added to the IAM Policy!! 
  description = "Creates S3 buckets needed for TAS"
  type        = list(string)
  default     = ["tas-ops-manager-bucket-123", "tas-buildpacks-bucket-123", "tas-packages-bucket-123", "tas-resources-bucket-123", "tas-droplets-bucket-123"]
}


resource "aws_s3_bucket" "tas_s3_buckets" {
  count = length(var.s3_buckets)
  //bucket = [count.index]
  bucket = var.s3_buckets[count.index]
}
