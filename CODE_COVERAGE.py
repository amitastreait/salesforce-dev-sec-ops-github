import json
import sys

# Function to calculate the overall code coverage and individual class coverage
def calculate_coverage(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)

    total_lines = 0
    covered_lines = 0
    coverage_threshold = 80
    failed_classes = []

    # Coverage for each class
    for class_coverage in data:
        class_name = class_coverage['name']
        class_coverage_percentage = class_coverage['coveredPercent']  # Use coveredPercent directly
        
        print(f"Class: {class_name}, Coverage: {class_coverage_percentage:.2f}%")
        
        # Check if the coverage is below the threshold
        if class_coverage_percentage < coverage_threshold:
            failed_classes.append((class_name, class_coverage_percentage))
        
        # Accumulate for overall coverage
        total_lines += class_coverage['totalLines']  # Assuming totalLines is still needed
        covered_lines += class_coverage['totalCovered']  # Assuming totalCovered is still needed

    # Calculate overall coverage percentage if needed
    overall_coverage = (covered_lines / total_lines) * 100 if total_lines > 0 else 0

    # If there are any failed classes, print them and exit with code 1
    if failed_classes:
        print(f"\n Build Failed! The following classes have less than {coverage_threshold}% code coverage: ")
        for class_name, coverage in failed_classes:
            print(f"  - {class_name}: {coverage:.2f}%")
        sys.exit(1) # break the pipeline
    else:
        print(f"\n Overall Code Coverage: {overall_coverage:.2f}% ")

# Main method that runs automatically
if __name__ == "__main__":
    ## coverage/test-result-codecoverage.json
    file_path = 'test-result-codecoverage.json'  # Replace with your actual file path
    calculate_coverage(file_path)