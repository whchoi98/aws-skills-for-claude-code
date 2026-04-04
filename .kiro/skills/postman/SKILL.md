---
name: postman-api-testing
description: Automate API testing and collection management with Postman - create workspaces, collections, environments, and run tests. Use when mentioning Postman, API testing, API collections, or API automation.
---

# Postman API Testing

## Key Tools (Minimal Mode - 40 tools)
- Workspace: createWorkspace, getWorkspace, getWorkspaces
- Collection: createCollection, getCollection, putCollection, createCollectionRequest, runCollection
- Environment: createEnvironment, getEnvironment, getEnvironments
- Mock: createMock, getMock, publishMock
- Spec: createSpec, getSpec, generateCollection, syncCollectionWithSpec
- Testing: runCollection

## Common Workflows

### Project Setup
1. Create workspace
2. Create collection with schema
3. Create environment (local/staging/prod)
4. Save IDs to .postman.json

### Generate from OpenAPI
1. Create spec with OpenAPI definition
2. Generate collection from spec
3. Sync collection with spec on changes

### Automated Testing
1. Get workspaces and collections
2. Run collection with environment
3. Review results and fix errors

## Best Practices
- Store workspace/collection/environment IDs in `.postman.json`
- Use environment variables for different contexts
- Add post-request test scripts for validation
- Run collections before deployment
- Ensure API server is running before tests

## MCP Server Config
```json
{
  "mcpServers": {
    "postman": {
      "url": "https://mcp.postman.com/minimal",
      "headers": {
        "Authorization": "Bearer $POSTMAN_API_KEY"
      }
    }
  }
}
```

Change URL to `https://mcp.postman.com/full` for 112 tools.
