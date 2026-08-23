resource "aws_ecr_repository" "this" {
  for_each = var.repositories

  name                 = "${var.project_name}-${var.env}-${each.value}"
  image_tag_mutability = local.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = local.scan_on_push
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each = var.repositories

  repository = aws_ecr_repository.this[each.value].name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = local.max_tagged_image_count
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}