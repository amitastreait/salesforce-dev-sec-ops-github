import json
import sys

# Function to calculate the overall code coverage and individual class coverage
def calculate_coverage(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)

    total_lines = 0
    covered_lines = 0
    coverage_threshold = 101
    failed_classes = []

    # Coverage for each class
    for class_coverage in data:
        class_name = class_coverage['name']
        class_total_lines = class_coverage['totalLines']
        class_covered_lines = class_coverage['totalCovered']
        
        # Calculate coverage for the current class
        class_coverage_percentage = (class_covered_lines / class_total_lines) * 100
        print(f"Class: {class_name}, Coverage: {class_coverage_percentage:.2f}%")
        
        # Check if the coverage is below the threshold
        if class_coverage_percentage < coverage_threshold:
            failed_classes.append((class_name, class_coverage_percentage))
        
        # Accumulate for overall coverage
        total_lines += class_total_lines
        covered_lines += class_covered_lines

    # Calculate overall coverage percentage
    overall_coverage = (covered_lines / total_lines) * 100

    # If there are any failed classes, print them and exit with code 1
    if failed_classes:
        print("\nBuild Failed! The following classes have less than 80% code coverage:")
        for class_name, coverage in failed_classes:
            print(f"  - {class_name}: {coverage:.2f}%")
        sys.exit(1)
    else:
        print(f"\nOverall Code Coverage: {overall_coverage:.2f}%")

# Main method that runs automatically
if __name__ == "__main__":
    file_path = 'test-result-codecoverage.json'  # Replace with your actual file path
    calculate_coverage(file_path)
