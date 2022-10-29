resource "aws_s3_bucket" "mlbucket" {
  bucket = "dev-mlflow-bucket123"
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.mlbucket.id
  acl    = "private"
}