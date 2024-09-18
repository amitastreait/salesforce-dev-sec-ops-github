name: Code Validation
run-name: ${{ github.actor }} is running the Github Actions 🚀

on:
  push:
    paths:
      - 'force-app/**'
    branches:
      - feature/*
      - bugfix/*
      - hotfix/*

jobs:
  build-and-deploy: 
    ## Permissions needed for security scan reports
    permissions:
      contents: read # for actions/checkout to fetch code
      security-events: write # for github/codeql-action/upload-sarif to upload SARIF results
      actions: read # only required for a private repository by github/codeql-action/upload-sarif to get the Action run status

    runs-on: ubuntu-latest ## Github Hosted [Self Hosted]
    environment: developer
    steps:
      - run: echo "This is my first Job"
        name: "First Job Message"
      - name: Checkout Code
        uses: actions/checkout@v4.1.7
        with:
          fetch-depth: 0
      - name: npm install
        run: echo "running npm install"
        ## Install Saleforce CLI
      - name: Install Salesforce CLI
        run: npm install @salesforce/cli --global 

      - name: Install Salesforce Code Anayzer
        id: salesforce-cli-scanner
        run: sf plugins install @salesforce/sfdx-scanner

      - name: Run Salesforce Code Anayzer Scan
        id: code-analyzer
        run: |
          mkdir reports
          echo "Folder is created"
          sf scanner run --format html --target force-app/main/default/classes --engine pmd,pmd-appexchange --category Design,Best Practices, Code Style,Performance,Security,Documentation, Error Prone --outfile reports/scan-reports.html
          echo "Starting the scan in sarif format"
          sf scanner run --format sarif --target force-app/main/default/classes --engine pmd,pmd-appexchange --category Design,Best Practices, Code Style,Performance,Security,Documentation, Error Prone --outfile reports/scan-reports.sarif
          echo "Scanning is Completed"
      
      ## Upload the report results as artifacts
      - name: Upload a Salesforce CLI Scan Report
        id: upload-reports
        uses: actions/upload-artifact@v4.4.0
        with:
          name: cli-scan-report
          path: reports/scan-reports.html

      ## Upload the report results to codeql for process
      - name: Upload SARIF file - Salesforce CLI Scan Report
        id: upload-sarif-file
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: reports/scan-reports.sarif
          token: ${{ github.token }}
          category: my-analysis-tool

      - name: PMD SCAN
        id: pmd_scan
        uses: pmd/pmd-github-action@v2 
        with:
          rulesets: 'pmd/ruleset.xml'

      - name: Upload SARIF file
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: pmd-report.sarif

      ## Scan the code using SonarCloud
      - name: SonarCloud Scan
        id: sonar
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}  # Needed to get PR information, if any
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
      
      - name: Fail build if there are violations
        if: steps.pmd_scan.outputs.violations != 0
        run: |
          echo "PMD Violatons ${{steps.pmd_scan.outputs.violations}} "
          exit 1

      - name: Decrypt the server.key.enc file
        run: openssl enc -nosalt -aes-256-cbc -d -in ${{ secrets.ENCRYPTED_KEY_FILE }} -out ${{ secrets.JWT_KEY_FILE }} -base64 -K ${{ secrets.KEY }} -iv ${{ secrets.IV }}
      - name: Authorize with Salesforce org
        run: sf org login jwt --username ${{ secrets.SF_USERNAME }} --jwt-key-file ${{ secrets.JWT_KEY_FILE }} --client-id ${{ secrets.SF_CLIENT_ID }} --set-default --alias ci-org --instance-url ${{ secrets.SF_INSTANCE_URL }}
      
      - name: Validate The Code to Salesforce
        ## Best is to have a separate Org for validation purpose
        run: sf project deploy validate --source-dir force-app --target-org ci-org
      
      # - name: deploy
      #  run: sf project deploy start --source-dir force-app --target-org ci-org
      
  clean-up:
    runs-on: ubuntu-latest
    needs: [build-and-deploy]
    steps:
      - run: echo "This is my second Job"
        name: "Print Message"