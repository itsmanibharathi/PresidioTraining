#!/bin/bash

# Run Checkov to generate a JSON report
checkov -d ./DevOpsTraning/Terraform/ -o json > checkov_report.json --no-cert-verify

# Run Python script to calculate compliance percentage
python3 calculate_compliance.py

# cleanup
rm checkov_report.json

