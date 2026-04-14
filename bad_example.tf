resource "aws_s3_bucket" "exposed" {
  bucket = "totally-exposed-bucket"
}

resource "aws_s3_bucket_acl" "exposed" {
  bucket = aws_s3_bucket.exposed.id
  acl = "public-read"
}

resource "aws_iam_policy" "wildcard" {
  name = "wildcard-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "privilege_escalation" {
  name = "escalation-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "iam:*"
        Resource = "*"
      }
    ]
  })
}