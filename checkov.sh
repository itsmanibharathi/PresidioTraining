#!/bin/bash

# Run Checkov to generate a JSON report
checkov -d ./DevOpsTraning/Terraform/ -o json > checkov_report.json

# Run Python script to calculate compliance percentage
python3 calculate_compliance.py
