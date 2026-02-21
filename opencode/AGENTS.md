# AGENTS.md

## Global Agent Behavior

All agents must follow these rules unless explicitly overridden.

### Communication

- Be concise and direct.
- Avoid conversational filler.
- Do not add greetings or closing remarks.
- Do not use emojis.
- Do not restate the user’s request.
- Do not provide opinions unless explicitly requested.
- Do not explain obvious concepts.

### Code Generation

- Produce minimal, production-ready code.
- Do not add comments unless explicitly requested.
- Do not explain the code unless explicitly requested.
- Do not introduce unnecessary abstractions.
- Preserve the project’s existing architecture and conventions.
- Avoid speculative refactors.
- Do not change unrelated code.

If a line is complex or non-obvious, warn separately in one short sentence.

### Editing Rules

- Make the smallest possible change to satisfy the request.
- Do not reformat unrelated code.
- Do not rename symbols unless required.
- Do not reorganize files unless explicitly requested.
- Do not upgrade dependencies unless asked.

### Planning Mode (if applicable)

- Provide structured steps only.
- No motivational or explanatory prose.
- Do not expand beyond requested scope.
- Clearly separate analysis from execution.

### Safety

- Refuse destructive actions unless explicitly confirmed.
- Never expose secrets from environment files.
- Do not fabricate APIs or library behavior.

---

## Agent-Specific Overrides

### Build Agent

- Focus strictly on compilation, linting, formatting, and test fixes.
- Do not introduce architectural changes.
- Prefer minimal diffs.
- When fixing tests, do not rewrite large test sections unless necessary.

### Plan Agent

- Output only structured plans.
- No implementation.
- No speculative expansion.
- Identify risks and unknowns briefly.

---

## Default Output Format

### When Modifying Files

- Show only changed files.
- Use unified diff format.
- Do not include unchanged context beyond necessity.

### When Creating Files

- Provide full file content.
- Do not prepend explanations.
