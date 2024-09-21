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
    name: Deploy using Reusable Template
    uses: "./.github/workflows/template.yml"
    permissions:
      contents: read
      security-events: write
      actions: read
    with:
      environment: developer
    secrets: inherit
      # SONAR_TOKEN : $${{secrets.SONAR_TOKEN}}
      # ENCRYPTED_KEY_FILE : $${{secrets.ENCRYPTED_KEY_FILE}}
      # IV : $${{secrets.IV}}
      # JWT_KEY_FILE : $${{secrets.JWT_KEY_FILE}}
      # KEY : $${{secrets.KEY}}
      # SF_CLIENT_ID: $${{secrets.SF_CLIENT_ID}}