import re

def extract_apex_classes(file_path):
    # Read the text content from a file
    with open(file_path, 'r') as file:
        text_content = file.read()

    # Using regex to extract the test class names from the last line
    match = re.search(r"APEX TEST CLASS TO RUN \[RUN:([^\]]+)\]", text_content)
    if match:
        apex_classes = match.group(1).split(',')
        apex_classes_string = ' '.join(cls.strip() for cls in apex_classes)
        print(apex_classes_string)
        return apex_classes_string  # Return as a string
    else:
        print("No Apex classes found")
        return "No Apex classes found"

# Main method that runs automatically
if __name__ == "__main__":
    extract_apex_classes('pr_body.txt')