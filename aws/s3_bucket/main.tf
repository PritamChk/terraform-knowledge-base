resource "aws_s3_bucket" "test_bucket" {
  bucket = "my-tf-test-bucket-23122025-1040"

  tags = {
    Name        = "TF Bucket Example"
    Environment = "Dev"
  }
}