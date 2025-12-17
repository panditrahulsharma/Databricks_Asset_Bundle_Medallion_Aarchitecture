# Quick Start

This guide helps you get up and running quickly by generating a Databricks access token and configuring CI/CD secrets to run the pipeline.

---

## 1. Generate a Databricks Personal Access Token (PAT)

You need a Databricks token to authenticate CI/CD workflows with your Databricks workspace.

### Steps

1. Log in to your **Databricks Workspace**.
2. In the top-right corner, click on your **User Profile** → **Settings**.
3. Navigate to **Developer** → **Access tokens**.
4. Click **Generate new token**.
5. (Optional) Provide a comment and set an expiry period.
6. Click **Generate** and **copy the token immediately**.

> ⚠️ **Important**: You won’t be able to view the token again. Store it securely.

You will need:

* **Databricks Workspace URL** (e.g. `https://dbc-xxxx.cloud.databricks.com`)
* **Databricks Access Token**

---

## 2. Create CI/CD Secrets

These secrets are required for the CI/CD pipeline to authenticate and deploy to Databricks.

### GitHub Actions (Recommended)

1. Go to your **GitHub repository**.
2. Navigate to **Settings** → **Secrets and variables** → **Actions**.
3. Click **New repository secret** and add the following:

| Secret Name        | Description                      |
| ------------------ | -------------------------------- |
| `DATABRICKS_HOST`  | Databricks workspace URL         |
| `DATABRICKS_TOKEN` | Databricks personal access token |

> If you use multiple environments (dev/test/prod), prefer **Environment Secrets** instead of repository-level secrets.

---

## 3. Run the CI/CD Pipeline

Once secrets are configured, you can trigger the pipeline.

### Automatic Trigger

* Push a commit to the configured branch (e.g. `main`).
* The CI/CD workflow will start automatically.

### Manual Trigger (if enabled)

1. Go to **Actions** tab in GitHub.
2. Select the workflow.
3. Click **Run workflow**.

---

## 4. Verify Deployment

* Check the **GitHub Actions logs** for successful execution.
* Verify resources (jobs, notebooks, catalogs, schemas, etc.) in the Databricks workspace.

---

## Troubleshooting

* **Authentication errors**: Verify `DATABRICKS_HOST` and `DATABRICKS_TOKEN` values.
* **Permission issues**: Ensure the token owner has required workspace permissions.
* **Pipeline not triggering**: Confirm branch name and workflow trigger configuration.

---

✅ You’re all set! The CI/CD pipeline should now be able to deploy to Databricks successfully.
