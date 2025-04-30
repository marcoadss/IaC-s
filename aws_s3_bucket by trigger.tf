variable "bucket_name"{
    type    = string
    description = "Variavel que armazena um nome para o bucket de site estatico"
    }

    # Cria o bucket
resource "aws_s3_bucket" "static_site_bucket" {
    bucket = "static-site-${var.bucket_name}

    # Define tags para o bucket
    tags = {
        Name = "Static Site"
        Environment = "Production"
    }

    # Configuracoes para hospedagem do site estatico
    website{
        index_document = "index.html"
        error_document = "error404.html"
    }

    # Define a regiao do bucket (default us-east-1)
    region = "us-east-1"

# Define o site estatico como publico
resource "aws_s3_bucket_public_acces_block" "static_site_bucket"{
    bucket = aws_s3_bucket.static_site_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
    }
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.static_site_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.static_site_bucket.arn}/*"
            },
            ]
        })
    }
}