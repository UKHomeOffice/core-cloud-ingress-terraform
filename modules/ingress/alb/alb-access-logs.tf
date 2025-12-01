# ########
# # Logs Bucket per AWS account
# resource "aws_s3_bucket" "alb_logs" {
#   bucket = "tenant1-external-alb-logs-${var.account_id}"
# }

# ########
# # Required for ALB access logging
# ########
# resource "aws_s3_bucket_public_access_block" "alb_logs" {
#   bucket                  = aws_s3_bucket.alb_logs.id
#   block_public_acls       = false
#   ignore_public_acls      = false
#   block_public_policy     = true
#   restrict_public_buckets = true
# }

# ########
# # AWS requires this policy so the ELB service can put the logs in the bucket
# ########
# resource "aws_s3_bucket_policy" "alb_logs" {
#   bucket = aws_s3_bucket.alb_logs.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "ELBAccessLogs"
#         Effect    = "Allow"
#         Principal = { Service = "logdelivery.elasticloadbalancing.amazonaws.com" }
#         Action    = [ "s3:PutObject" ]
#         Resource  = "${aws_s3_bucket.alb_logs.arn}/*"
#       }
#     ]
#   })
# }

###################
# REPLACED BECAUSE - TF OUTPUT SHOWS
###################

/*         }
        # (28 unchanged attributes hidden)
      ~ access_logs {
          ~ bucket  = "aws-accelerator-elb-access-logs-905418430070-eu-west-2" -> "tenant1-external-alb-logs-205144096913"
          ~ prefix  = "512852113180/elb-tenant1-external-205144096913" -> "tenant1-external"
            # (1 unchanged attribute hidden)
        }
        # (4 unchanged blocks hidden)
    }
 */