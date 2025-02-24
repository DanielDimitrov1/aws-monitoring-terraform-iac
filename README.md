# AWS Monitoring with Terraform & Terragrunt

## Overview

This repository is designed for dynamically monitoring AWS infrastructure. It supports both Terraform and Terragrunt (an advanced approach to Infrastructure as Code (IaC) for managing multiple environments and accounts), requiring only minimal modifications to switch between them. 

I strongly recommend using Terragrunt because of its efficiency.

Additionally, this repo includes a deployment pipeline for Bitbucket called [pipeline.yaml](https://github.com/DanielDimitrov1/Monitoring_AWS_Terrafrom/blob/main/pipeline.yaml), in addition to GitHub Actions, providing flexibility in CI/CD setup.

***The authentication approach to AWS*** in this setup differs from the standard  method of storing the ACCESS_KEY and SECRET_ACCESS_KEY as environment secrets in GitHub repository settings.

Instead, I have defined an **AWS Identity provider** with strictly enforced policies and permissions, following to the principle of least privilege. ***This approach significantly improves security compared to the traditional and commonly used method.***


The current setup focuses on monitoring key AWS services, ensuring scalability, modularity, and maintainability. I can easily enhance it using **for_each loops, if statements, and other Terraform features** to provide more flexibility and customization as needed.


## Getting Started

To utilize this repository effectively, follow these steps:

### Clone this repo locally

```sh
git clone https://github.com/DanielDimitrov1/Monitoring_AWS_Terrafrom.git
```

### Create an S3 Bucket
Set up your own S3 bucket to store the Terraform state (`tfstate`) file.

### Set Load Balancer ARN
Retrieve your Load Balancer name and declare it in the data resource for calling it [ALB NAME](https://github.com/DanielDimitrov1/Monitoring_AWS_Terrafrom/blob/main/modules/load_balancer.tf)  ***(line 23)***.

### IAM Identity Provider Configuration

- Create a provider in IAM Identity Provider with the name: **token.actions.githubusercontent.com**.
- **Set Audience**: `sts.amazonaws.com`.
- **Type**: OpenID Connect.

### IAM Role and Permissions

- Create and assign an IAM role to the provider with all necessary permissions.
- Reference predefined policies located in the [permisions](https://github.com/DanielDimitrov1/Monitoring_AWS_Terrafrom/tree/main/permissions) directory and modify them as needed based on your services and resources.

### Configure AWS Region and Bucket Name

- Store the AWS region as a secret variable under the key **AWS_REGION**.
- Similarly, set the S3 bucket name in **AWS_BUCKET_NAME**.

### ⚠️Notes: ⚠️         Some configuration files and examples are included to illustrate real-world use cases. However, certain resources and services may not be pre-configured since they depend on specific monitoring needs.

### 📞Support: 📞  For any questions or further assistance, feel free to reach out.



## Features

**Infrastructure as Code (IaC):** Fully automated provisioning of monitoring configurations.

**Terragrunt Best Practices:** DRY principle, modular configurations, and environment-based deployments.

**AWS CloudWatch Alarms:** Monitoring critical AWS services with predefined thresholds and alerts.

**Scalable & Customizable:** Easily extend monitoring configurations for additional AWS resources.



## AWS Services Monitored

This repository currently provides monitoring configurations for various AWS services, BUT I can implement the same for any of the following:

**Compute & Networking:** EC2, Lambda, API Gateway, Load Balancer, EBS

**Databases & Storage:** RDS, DynamoDB, S3, ECR

**Messaging & Streaming:** SNS, SQS, Kinesis

**Content Delivery**: CloudFront

# CloudWatch Metrics & Alarms

The monitoring setup includes various CloudWatch alarms to track performance, latency, errors, and resource utilization. Some of the key metrics include:

## API Gateway Monitoring:

**ApiGatewayLatencyAlarm** – Monitors API latency.

**ApiGateway4xxErrorAlarm** – Tracks 4xx client errors.

**ApiGateway5xxErrorAlarm** – Tracks 5xx server errors.

**Latency** - The time between API Gateway receives a request from a client and when it returns a response back.

**Count** - Total amount of API requests for a given period.

## Database Monitoring (RDS/DynamoDB):

**FreeableMemory** – Monitors low available memory, indicating potential performance degradation.

**CPUUtilization** – Triggers alerts for high CPU usage.

**FreeStorageSpace** – Monitors available storage over the last 10 minutes.

**WriteLatency & ReadLatency** – Tracks database read and write performance.

## Additional Monitoring Capabilities

Beyond the listed metrics, I can extend monitoring configurations to cover additional performance, security, and availability aspects across AWS services.




# Why This Matters

**Proactive Monitoring:** Helps prevent downtime and performance issues before they impact users.

**Cost Optimization:** Detects inefficient resource usage and potential cost savings.

**Security & Compliance:** Monitors unauthorized access attempts and suspicious activities.



# About Me

I am passionate about **Infrastructure as Code, AWS, and cloud monitoring**. This repository demonstrates my ability to implement **scalable, modular, and efficient AWS monitoring solutions** using **Terraform and Terragrunt.**

If you're interested in similar implementations or need custom AWS monitoring solutions, feel free to reach out!

**✅ Let’s make cloud monitoring simple, automated, and efficient!**
