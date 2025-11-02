import json
import requests
import boto3
from botocore.exceptions import NoCredentialsError
from urllib.request import urlopen
import os

# -----------------------
# Configuration
# -----------------------
BUCKET_NAME = os.getenv("BUCKET_NAME", "vibr-chkp-assignment-bucket")
CLOUDFRONT_URL = os.getenv("CLOUDFRONT_URL", "https://d23rcc7nbb1cey.cloudfront.net")
OUTPUT_FILE = os.getenv("OUTPUT_FILE", "filtered_products.json")

# -----------------------
# Step 1: Download JSON
# -----------------------
print("Downloading product data...")
response = requests.get("https://dummyjson.com/products")
data = response.json()

# -----------------------
# Step 2: Filter Products
# -----------------------
print("Filtering products with price >= 100...")
filtered_products = [p for p in data.get("products", []) if p.get("price", 0) >= 100]

output_data = {"products": filtered_products}

# Save locally
with open(OUTPUT_FILE, "w") as f:
    json.dump(output_data, f, indent=4)

print(f"Filtered data saved to {OUTPUT_FILE}")

# -----------------------
# Step 3: Upload to S3
# -----------------------
print("Uploading filtered JSON to S3...")
s3 = boto3.client('s3')

try:
    s3.upload_file(OUTPUT_FILE, BUCKET_NAME, OUTPUT_FILE)
    print(f"Success ! Uploaded '{OUTPUT_FILE}' to S3 bucket: {BUCKET_NAME}")
except NoCredentialsError:
    print("Error ! AWS credentials not found. Please configure or export your profile.")

# -----------------------
# Step 4: Validate via CloudFront
# -----------------------
file_url = f"{CLOUDFRONT_URL}/{OUTPUT_FILE}"
print(f"Downloading via CloudFront URL: {file_url}")

try:
    with urlopen(file_url) as response:
        content = response.read().decode("utf-8")
        json_data = json.loads(content)
        print("Cheers ! Successfully verified JSON via CloudFront!")
        print(f"Total filtered products: {len(json_data.get('products', []))}")
except Exception as e:
    print("Opps ! Error fetching or parsing JSON via CloudFront:", e)
