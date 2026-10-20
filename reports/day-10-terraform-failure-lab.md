# Day 10: Terraform Failure Testing

## What I Did

Since I wasn't given a broken Terraform file by my mentor, I created a separate practice file to test how Terraform handles errors.

## The Error

I intentionally left out a closing brace in my `main.tf` file and ran `terraform fmt`.

Terraform returned an error saying that the configuration block was not closed.

## What I Thought Was Wrong

After reading the error message, I suspected that I had forgotten to close the variable block with a `}`.

## How I Fixed It

I added the missing closing brace to the variable block.

My corrected configuration was:


variable "student_name" {
  type    = string
  default = "DevOps Intern"
}


## How I Checked the Fix

I used these commands:

* `terraform fmt` to format the configuration.
* `terraform init -backend=false` to initialize the practice configuration without setting up a remote backend.
* `terraform validate` to check whether the configuration was valid.

**Result:** Terraform initialized successfully, and `terraform validate` confirmed that the corrected configuration was valid.

## What I Learned

* I learned how to read Terraform error messages.
* I learned that every configuration block needs a matching closing brace.
* I learned to identify the cause of an error before making changes.
* I learned to run formatting and validation after fixing a configuration.
* I learned to practise troubleshooting in a separate folder so I don't interfere with my main project.
