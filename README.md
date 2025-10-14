# template-gha-actions
# Daily Routine Check Workflow

- **Purpose:** Automated daily scan and validation of the repository using a scheduled GitHub Actions workflow.
- **Features:**
  - Security, code quality, and artifact checks.
  - Slack notifications for both success and failure cases.
  - Continuous monitoring and early detection of issues.
- **Notes:**
  - This is a template repository where we test multiple security GitHub Actions. The vulnerability here is deliberately done for testing vulnerabilities only. This vulnerable image wont be published to any ECR and wont be deployed anywhere. 
  - No functional changes to application code.
  - Workflow runs daily as part of routine maintenance.
