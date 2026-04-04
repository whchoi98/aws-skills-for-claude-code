---
name: stackgen-iac
description: Design, manage, and deploy cloud infrastructure with StackGen - create appstacks, manage resources, configure environments, and push IaC to Git. Use when mentioning StackGen, appstack, or multi-cloud IaC.
---

# StackGen Infrastructure as Code

## Key Tools
- Appstack: get_appstacks, create_appstack, copy_topology, get_appstack_resources
- Resources: add_resource_to_appstack, update_resource, delete_resource, connect_resources
- Environments: get_env_profiles, create_env_profile, update_env_profile
- Git: list_git_configuration, add_git_configuration, push_appstack_to_git
- Policy: get_policies, get_current_violations

## Workflow
1. create_appstack (AWS, Azure, or GCP)
2. add_resource_to_appstack
3. connect_resources (dependencies)
4. create_env_profile (dev/staging/prod)
5. push_appstack_to_git

## MCP Server Config
```json
{
  "mcpServers": {
    "stackgen": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.stackgen.com/mcp"]
    }
  }
}
```
