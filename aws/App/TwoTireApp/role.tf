# 1. Trust Policy: Allows EC2 instances to "assume" (use) this role
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# 2. Create the Role
resource "aws_iam_role" "ec2_s3_role" {
  name               = "${var.quiz_vpc_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name = "${var.quiz_vpc_name}-ec2-role"
  }
}

# 3. Attach Permissions: Give the role Full Access to S3
resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# 4. Create Instance Profile: This is the "container" needed to attach the role to an EC2
resource "aws_iam_instance_profile" "app_instance_profile" {
  name = "${var.quiz_vpc_name}-instance-profile"
  role = aws_iam_role.ec2_s3_role.name
}
