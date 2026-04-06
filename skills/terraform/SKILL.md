---
description: Build and manage Infrastructure as Code with Terraform - search registry providers, modules, policies, and HCP Terraform workspace management. Use when mentioning Terraform, HCL, HCP, or Terraform registry.
---

# Terraform

## Key Tools
- search_providers / get_provider_details - Provider documentation
- search_modules / get_module_details - Module discovery
- search_policies / get_policy_details - Sentinel policies
- HCP Terraform: list_workspaces, create_workspace, list_runs, create_run, action_run
- Variable management: list_variable_sets, create_variable_set, list_workspace_variables

## Workflow: Research → Write Config
1. search_providers to find resource docs (get provider_doc_id)
2. get_provider_details for full documentation
3. get_latest_provider_version for version constraint
4. Write accurate Terraform config

## Best Practices
- Always search_* before get_*_details
- Pin provider and module versions
- Use modules for common patterns
- Review plans before applying
- Never hardcode credentials

## MCP Server Config (requires Docker)
```json
{
  "mcpServers": {
    "terraform": {
      "command": "docker",
      "args": ["run", "-i", "--rm", "-e", "TFE_TOKEN", "hashicorp/terraform-mcp-server"],
      "env": {
        "TFE_TOKEN": "$TFE_TOKEN"
      }
    }
  }
}
```

Set `ENABLE_TF_OPERATIONS=true` for destructive operations (apply/destroy).
After changing env vars, restart the Docker container.
