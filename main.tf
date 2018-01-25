terraform {
    required_version = ">= 0.11.2"
    backend "s3" {}
}

provider "aws" {
    region     = "${var.region}"
}

resource "aws_s3_bucket" "bucket" {
    bucket = "${lower( var.name )}"
    acl    = "${var.acl}"
    tags   = {
        Name        = "${var.name}"
        Project     = "${var.project}"
        Purpose     = "${var.purpose}"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "${var.freetext}"
    }
    force_destroy = "${var.force_destroy}"
    versioning    = {
        enabled    = "${var.versioning_enabled}"
        mfa_delete = "${var.mfa_delete}"
    }
    lifecycle_rule = {
        id                                     = "age-out-objects"
        enabled                                = true
        abort_incomplete_multipart_upload_days = "${var.abort_incomplete_multipart_upload_days}"
        expiration = {
            days = "${var.expiration_days}"
        }
    }
    acceleration_status = "${var.acceleration_status}"
    region              = "${var.region}"
    request_payer       = "${var.request_payer}"
}
