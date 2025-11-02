resource "aws_s3_bucket" "vibrs3" {
  bucket = var.bucket_name
  force_destroy = true    # as it is assignment adding this value to avoid errors during destroy

  tags = merge(
    var.tags,
    {
      Name  = "ProductCloudFront"
      Owner = var.owner_name
    }
  )
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.vibrs3.id
  key          = "index.html"
  source       = "${path.root}/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.root}/index.html")

  tags = {
    Name = "index.html"
  }
}

