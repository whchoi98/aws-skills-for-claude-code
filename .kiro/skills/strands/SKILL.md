---
name: strands-agents-sdk
description: Build AI agents with Strands SDK using Bedrock, Anthropic, OpenAI, Gemini, or Llama models. Use when mentioning Strands SDK, AI agent building, or multi-provider LLM agents.
---

# Strands Agents SDK

## Overview
Build AI agents with tool calling, conversation context, and multiple LLM providers. Default provider is Amazon Bedrock.

## MCP Tools
- search_docs - Search Strands documentation
- fetch_doc - Fetch full documentation by URL

## Quick Setup (Bedrock)
```bash
export AWS_BEDROCK_API_KEY=your_key
pip install strands-agents strands-agents-tools
```

## Other Providers
- Anthropic: `pip install 'strands-agents[anthropic]'` + `ANTHROPIC_API_KEY`
- OpenAI: `pip install 'strands-agents[openai]'` + `OPENAI_API_KEY`
- Gemini: `pip install 'strands-agents[gemini]'` + `GOOGLE_API_KEY`
- Llama: `pip install 'strands-agents[llamaapi]'` + `LLAMA_API_KEY`

## Best Practices
- Use Bedrock as default provider
- Install only needed provider extensions
- Always install community tools: `pip install strands-agents-tools`
- Set API keys as environment variables
- Use clear docstrings for custom tools (models read them)
- Use @tool decorator for custom tools
- Lower temperature (0.1-0.3) for factual tasks

## MCP Server Config
```json
{
  "mcpServers": {
    "strands-agents": {
      "command": "uvx",
      "args": ["strands-agents-mcp-server"]
    }
  }
}
```
