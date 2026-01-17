# AWF Changelog

All notable changes to AWF will be documented in this file.

## [3.3.0] - 2026-01-17

### Added - Context Separation & Preferences

**Schema Split:**
- `schemas/session.schema.json` - Dynamic session state (working_on, pending_tasks, errors)
- `schemas/preferences.schema.json` - User preferences for AI communication
- `templates/session.example.json` - Session template
- `templates/preferences.example.json` - Preferences template

**Global Preferences:**
- `~/.antigravity/preferences.json` - Global defaults across all projects
- `.brain/preferences.json` - Local override per project
- Merge strategy: Local overrides Global

**Resilience Patterns (Hidden from users):**
- Auto-retry với exponential backoff
- Timeout protection (5-10 min)
- Fallback conversations thay vì error codes
- Error translation (technical → human-friendly Vietnamese)

### Changed

**brain.json Restructured:**
- Removed `current_session` → Moved to `session.json`
- Static knowledge only (tech_stack, DB, APIs, features)
- Updated to schema v1.1.0

**Workflow Updates:**
- `/recap` - New load order: prefs → brain → session
- `/save-brain` - Separates brain.json and session.json
- `/customize` - Added scope selection (Project/Global/Both)
- `/init` - Creates `.brain/` folder structure
- `/next` - Reads session.json first for context
- `/code`, `/deploy`, `/debug` - Added resilience patterns

### Benefits
- **Faster Updates**: session.json updates frequently, brain.json stays stable
- **Personalization**: Global preferences work across all projects
- **Better Recovery**: Auto-retry và fallback prevent frustration
- **Token Efficiency**: Load only what's needed

---

## [3.2.4] - 2026-01-17

### Added - Structured Context Format (brain.json)
- `schemas/brain.schema.json` - JSON schema for structured context
- `templates/brain.example.json` - Example brain.json template
- New phase in `/save-brain` - Generates `.brain/brain.json`
- Fast Context Load in `/recap` - Reads brain.json first (priority)

### Benefits
- **Token Efficiency**: ~2KB JSON vs ~10KB scattered markdown
- **Faster Recap**: Parse 1 file instead of scanning 10+ files
- **Structured Data**: AI understands context immediately
- **Explicit Schema**: Validated JSON format

### brain.json Sections
- `meta`: Schema version, timestamps
- `project`: Name, type, status, URLs
- `tech_stack`: Frontend, Backend, DB, Dependencies
- `database_schema`: Tables, Relationships
- `api_endpoints`: Routes with auth info
- `business_rules`: Business logic rules
- `features`: Features and status
- `current_session`: Working on, pending tasks, recent changes *(Deprecated in v3.3 → moved to session.json)*
- `knowledge_items`: Patterns, Gotchas, Conventions

---

## [3.2.0] - 2026-01-16

### Added
- `/brainstorm` workflow - Discovery phase for idea exploration & market research
- `/next` workflow - Anti-stuck guide, suggests next steps
- `docs/USER_GUIDE.md` - Comprehensive guide for 3 usage scenarios
- `docs/visualization/index.html` - Interactive web page for non-tech users
- Golden Rules in `/code` to prevent agent from doing unauthorized actions
- Detailed info gathering phase in `/visualize`

### Improved
- `/plan` workflow - Simplified for non-tech users, uses everyday language
- README.md - Now includes beginner-friendly documentation
- Command list organized by category

### New Features for Beginners
- Market research capability in /brainstorm
- MVP prioritization guidance
- Step-by-step workflow visualization
- "When stuck" help section

---

## [3.1.0] - 2026-01-16

### Added
- Version tracking system (`VERSION` file)
- `/awf-update` workflow for checking and installing updates
- Auto-update notification in GEMINI.md
- Explicit command mapping in GEMINI.md (fixes "no such file" error)

### Fixed
- Fixed `/recap` and other commands being interpreted as file paths
- Improved GEMINI.md instructions for better AI understanding

---

## [3.0.0] - 2026-01-15

### Added
- 14 Global Workflows for AI Engineering
- Bilingual support (English/Vietnamese)
- Numbered menu system for Next Steps
- "Fix All" option in `/audit` workflow

### Workflows
- `/init` - Project Initializer
- `/plan` - Product Architect
- `/visualize` - Creative Director
- `/code` - Senior Developer
- `/run` - Application Launcher
- `/test` - QA Engineer
- `/debug` - Detective
- `/refactor` - Code Gardener
- `/audit` - Code Doctor
- `/deploy` - DevOps/Release Manager
- `/rollback` - Emergency Responder
- `/save-brain` - Librarian/Memory Keeper
- `/recap` - Historian
- `/cloudflare-tunnel` - Admin
