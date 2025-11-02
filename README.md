# VIBR Checkpoint Assignment

## Author / Repository Owner / PoC
**Vinay B R**  
DevOps Lead | AWS | Terraform | Kubernetes | CI/CD | 
Bangalore, India

---

This repository contains automation to **provision AWS infrastructure** using Terraform and then **run a Python script** that processes product data and uploads it to S3 bucket.  
Note: The entire process runs automatically through **GitHub Actions** — no manual intervention needed once you push your code.

---

## What this project does

1. **Terraform Workflow**
   - Creates an S3 bucket to store data.
   - Creates a CloudFront distribution for content delivery.
   - Exports the bucket name and CloudFront URL as Terraform outputs.

2. **Python Workflow**
   - Downloads product data from a sample API.
   - Filters products based on price.
   - Uploads the filtered data (`filtered_products.json`) to the S3 bucket.
   - The CloudFront URL can be used to view or access uploaded files.

---

## GitHub Actions Workflows

### 1. `main.yml` (Deploy Infra and Run Python Code)
- Runs automatically whenever you push changes to the `chkp-assignment` branch.
- Performs the following:
  1. Initializes and applies Terraform configuration.
  2. Fetch Terraform outputs (bucket name and CloudFront URL).
  3. Runs the Python script with those outputs as environment variables.

**100% automated** — no manual input required.

---

### 2. `destroy.yml` (Tear Down Infrastructure)
- This workflow is **manual trigger only**.
- It safely destroys all resources created by Terraform to avoid unwanted costs.
- To run:
  1. Go to the **Actions** tab in your GitHub repository.
  2. Select **“Destroy Terraform Infrastructure”**.
  3. Click **“Run workflow”** manually.

Use this when you’re done testing or want to clean up AWS resources.

---

## GitHub Secrets Required

Make sure these repository secrets are configured in GitHub:

| Secret Name | Description |
|--------------|-------------|
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Key |

These are used by both the Terraform and Python steps to authenticate to AWS.

---

## Repository Structure

<pre>
vibr-chkp-assignment/
├── terraform/                     # Terraform IaC files
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── modules/                   # Contains S3 and CloudFront modules
│       ├── s3/
│       │   └── main.tf
│       └── cloudfront/
│           └── main.tf
│
├── python/
│   └── process_products.py         # Python script for data processing
│
├── .github/
│   └── workflows/
│       ├── main.yml                # Auto-provision + run Python script
│       └── destroy.yml             # Manual teardown workflow
│
└── README.md
</pre>



---

## How It Works !

1. Push code → GitHub Actions runs the **Deploy / Main** workflow.
2. Terraform provisions AWS resources.
3. Terraform outputs are passed to the Python step.
4. Python script downloads, filters, and uploads product data to the S3 bucket.
5. You can access results via the CloudFront URL.

---

## Notes

- The **destroy.yml** file is intentionally manual to prevent accidental resource deletion.
- The **deploy.yml** file ignores commits that only modify workflow files.
- Region used: `ap-south-1` (Mumbai).

---


