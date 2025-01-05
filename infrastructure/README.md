# infrastructure/README.md

# IaC


## Project Structure

```
terraform-project
├── environments
│   ├── dev
│   ├── qa
│   └── prod
├── main.tf
├── variables.tf
├── terraform.tfvars
└── README.md
```

### Environments

- **Dev**: Contains the main Terraform configuration for the development environment.
- **QA**: Contains the main Terraform configuration for the quality assurance environment.
- **Prod**: Contains the main Terraform configuration for the production environment.
