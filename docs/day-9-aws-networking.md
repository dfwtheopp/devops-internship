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

I created a separate practice VPC called devops-day9-vpc with the CIDR range 10.20.0.0/16. I created a public subnet using 10.20.1.0/24 and a private subnet using 10.20.2.0/24.

I then created and attached an Internet Gateway to the VPC. I configured a public route table with a local route and a default route to the Internet Gateway, and associated it with the public subnet.

I checked the private subnet's route table and confirmed that it had a local route but no default route directly to the Internet Gateway.

I also created separate Security Groups for the application and database and checked their inbound rules. The application uses port 8000, while PostgreSQL uses port 5432 and allows traffic from the application Security Group.

These checks helped me understand how routing and security rules work together. However, I have not yet tested an actual connection between the application and database because they have not been deployed into this practice VPC.

If the application could not receive traffic on port 8000, I would check whether it was running, confirm its listening port, and inspect the Security Group rules and route table. I would then fix the identified problem and test again. An actual connectivity test and controlled failure test remain to be completed.

## Failure Lab

For the failure lab, I temporarily removed the inbound rule for port 8000 from the application Security Group. This simulated a networking configuration problem because connections from the previously allowed source would no longer be permitted on that port.

I then restored the rule to return the Security Group to its intended configuration. This exercise helped me understand how Security Group rules affect incoming traffic and how correcting a rule can resolve a configuration problem.

Since I have not deployed an application into the practice VPC, I did not test an actual application connection or observe a real outage.

## 9. Conclusion

This task helped me understand how AWS networking components work together. I learned how VPCs and subnets organize resources, how route tables direct traffic, and how Security Groups and Network ACLs control access. I also learned why databases should be protected from direct internet access. These concepts are important when deploying applications securely in the cloud.