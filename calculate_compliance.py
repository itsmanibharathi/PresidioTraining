import json

def calculate_compliance(report_path):
    with open(report_path) as f:
        data = json.load(f)

    total_checks = len(data["results"]["failed_checks"]) + len(data["results"]["passed_checks"])
    passed_checks = len(data["results"]["passed_checks"])

    if total_checks == 0:
        compliance_percentage = 100
    else:
        compliance_percentage = (passed_checks / total_checks) * 100

    return compliance_percentage

report_path = "checkov_report.json"
compliance = calculate_compliance(report_path)
print(f"Compliance Percentage: {compliance:.2f}%")
