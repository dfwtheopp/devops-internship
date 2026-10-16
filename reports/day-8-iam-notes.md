# Day 8: AWS IAM Investigation

## Objective

The purpose of this task was to understand AWS Identity and Access Management (IAM), examine an existing IAM role, and learn how AWS controls access to its resources.

## 1. What Is an IAM User?

An IAM user is an identity in AWS that can be assigned permissions. Depending on its configuration, it may have credentials for accessing AWS services.

## 2. What Is an IAM Role?

An IAM role is an identity that has permissions and can be assumed by an authorized principal. Roles are commonly used to provide temporary access without distributing permanent credentials.

## 3. What Is an IAM Policy?

An IAM policy is a document that defines which actions are allowed or denied on particular resources, sometimes under specific conditions.

## 4. What Does Least Privilege Mean?

Least privilege means granting only the permissions needed to perform a particular task. This reduces the risk of accidental changes and unauthorized access.

## 5. Why Should AWS Credentials Never Be Committed to Git?

AWS credentials must not be committed to Git because someone could obtain them and use them to access or modify AWS resources. Secrets may also remain in Git history even after the original file is deleted.

Credentials should be stored and managed using approved secure methods.

## 6. Investigation of AccountFullAccessRole

I inspected the `AccountFullAccessRole` role in the AWS IAM console.

The role had an attached `AdministratorAccess` policy. This policy provides broad permissions across AWS services, subject to applicable AWS controls.

I also inspected its trust relationship.

The trust policy identified `account-access.amazonaws.com` as the trusted service principal and included the actions `sts:AssumeRole` and `sts:SetContext`.

This showed me that the trust policy identifies the principal permitted to assume the role, while the attached permissions policy describes what the role is allowed to do.

I did not modify the role or its policies.

## 7. What I Learned

This investigation helped me understand the difference between IAM users, roles, permissions policies, and trust policies.

I also learned why least privilege is important and why AWS credentials, private keys, and other secrets must never be committed to GitHub.
