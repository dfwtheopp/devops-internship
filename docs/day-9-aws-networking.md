# Day 9: AWS Networking

## 1. Introduction

The goal of this task was to understand how AWS networking works and how resources communicate securely. I learned about VPCs, subnets, route tables, Internet Gateways, Security Groups, and Network ACLs.

## 2. VPC and CIDR

A **Virtual Private Cloud (VPC)** is an isolated network in AWS where resources such as EC2 instances can run.

A **CIDR block** defines the range of IP addresses available in a network.

For this practice, I plan to use the following network:

| Resource       | CIDR block     |
| -------------- | -------------- |
| VPC            | `10.20.0.0/16` |
| Public subnet  | `10.20.1.0/24` |
| Private subnet | `10.20.2.0/24` |

The subnets use different, non-overlapping IP ranges within the VPC.

## 3. Public and Private Subnets

A **public subnet** can provide internet access to resources through an Internet Gateway and a suitable route table. Resources also need the appropriate IP configuration and security rules.

A **private subnet** is used for resources that should not be directly accessible from the internet, such as a PostgreSQL database.

Keeping application and database resources separate helps improve security.

## 4. Internet Gateway and Route Tables

An **Internet Gateway (IGW)** connects a VPC to the internet when the necessary routes and resource configurations are in place.

A **route table** determines where network traffic is directed.

A typical public subnet route table contains:

| Destination    | Target           |
| -------------- | ---------------- |
| `10.20.0.0/16` | Local            |
| `0.0.0.0/0`    | Internet Gateway |

The local route allows communication within the VPC. The default route directs other IPv4 traffic towards the Internet Gateway.

## 5. Security Groups and Network ACLs

A **Security Group** controls inbound and outbound traffic for resources such as EC2 instances. It is stateful, meaning return traffic for an allowed connection is automatically permitted.

A **Network Access Control List (Network ACL)** controls traffic at the subnet level. It is stateless, so inbound and outbound rules must account for return traffic separately.

For this project:

* The application should accept only the traffic it requires.
* SSH access should be restricted to an authorized source.
* PostgreSQL should accept connections only from the application where appropriate.

## 6. IP Addresses and Localhost

A public IP address can allow a resource to communicate over the internet when its network and security configurations permit it. A private IP address is used for communication within private networks and connected networks.

`localhost` refers to the machine or network environment where a command is running. In Docker Compose, the application can connect to the database using the database service name, such as `db:5432`, rather than `localhost:5432`.

## 7. Network Architecture

The planned architecture separates the application and database into different subnets:

**Internet → Internet Gateway → Public Subnet (Application) → Private Subnet (PostgreSQL Database)**

The application can receive permitted external traffic, while the database should not be directly accessible from the public internet.

## 8. Implementation and Testing

The practical work involves:

* Inspecting the existing VPC, subnet CIDR, and route table.
* Creating a separate practice VPC with public and private subnets.
* Attaching an Internet Gateway and configuring the public route table.
* Reviewing and configuring the relevant security rules.
* Testing permitted connectivity and checking that unauthorized access is blocked.
* Investigating and fixing one controlled networking failure.

The actual resource IDs, test results, and troubleshooting findings will be recorded after the practical exercises are completed.

## 9. Conclusion

This task helped me understand how AWS networking components work together. I learned how VPCs and subnets organize resources, how route tables direct traffic, and how Security Groups and Network ACLs control access. These concepts are important for deploying applications securely in the cloud.
