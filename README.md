# AWS Monitoring with Terraform & Terragrunt

## Overview

This repository showcases my expertise in **Terraform, Terragrunt**, and **AWS monitoring tools** by implementing automated monitoring solutions for AWS resources. It provides infrastructure-as-code (IaC) to deploy CloudWatch alarms and other monitoring configurations efficiently and consistently.

The current setup focuses on monitoring key AWS services using Terraform and Terragrunt, ensuring scalability, modularity, and maintainability. This is a simple way of implementing monitoring, but I can enhance it using **for_each loops, if statements, and other Terraform features** to provide more flexibility and customization as needed.


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
