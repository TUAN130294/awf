# AWF Changelog

All notable changes to AWF will be documented in this file.

## [4.0.0] - 2026-01-24

### Added - Foundation Skills (Phase 01)

**Core Foundation Skills:**
- **`awf-session-restore` skill** - Auto-restore session context on workflow start
  - Activates as pre-hook for ALL AWF workflows
  - Loads `.brain/session.json` and displays brief summary
  - Performance: < 500ms load time
  - Falls back gracefully if session file missing/corrupted

- **`awf-adaptive-language` skill** - Adjust terminology by technical level
  - Reads `technical_level` from preferences.json (newbie/basic/technical)
  - Newbie: Explains all jargon with everyday examples
  - Basic: First mention + explanation, then plain terminology
  - Technical: Standard technical terms, no explanations
  - Operates silently (no indicator shown to user)
  - Performance: < 100ms load, cached for session

**Schema Enhancements:**
- `preferences.schema.json` v2.0.0 - Added `technical.technical_level` field
- Enables language adaptation for all user skill levels
- Global + Local override strategy maintained

### Benefits
- **Better UX for Beginners**: Jargon automatically explained based on level
- **Faster Context Recovery**: Session auto-loads in < 1 second
- **Non-Intrusive**: Both skills work silently in background
- **Scalable**: Foundation for Phase 02 (UI Skills), Phase 03 (Code Skills)

### Breaking Changes
- None. v4.0 is fully backward compatible with v3.4

---

## [3.4.0] - 2026-01-17

### Added - Auto Workflow System

**`/plan` v2 - Auto Phase Generation:**
- Tự động tạo folder `plans/[timestamp]-[feature]/`
- Tự động tạo phase files (phase-01-setup.md, phase-02-database.md, etc.)
- Mỗi phase có TODO checklist, files to modify, test criteria
- Smart phase detection (3-7 phases tùy complexity)
- Progress tracking table trong plan.md

**`/code` v2 - Auto Test Loop:**
- Phase-aware coding: `/code phase-01` để code theo phase
- **NEW:** `/code all-phases` - Code tuần tự tất cả phases
- Auto-test sau mỗi task (PRODUCTION level)
- Fix loop: tự động fix và retest (max 3 lần)
- **NEW:** Test skip behavior - Ghi nhận tests bị skip, block deploy
- Auto update progress trong plan.md và session.json
- Checkpoint save sau mỗi 5 tasks

**`/next` v2 - Phase Progress Display:**
- Hiển thị progress bar với percentage
- Bảng status các phases (Done/In Progress/Pending)
- Gợi ý command để tiếp tục phase hiện tại

**`/deploy` v2 - Pre-Audit & Safety:**
- **NEW:** Gợi ý chạy `/audit` trước khi deploy
- **NEW:** Block deploy nếu có tests bị skip
- Warning trong handover nếu skip audit

**`/recap` v2 - Skipped Tests Reminder:**
- **NEW:** Hiển thị danh sách tests bị skip
- Reminder phải fix trước khi deploy

**Auto-Save Progress (Chống mất context):**
- Tự động save sau mỗi phase hoàn thành
- Checkpoint save sau mỗi 5 tasks
- Save trước khi hỏi user input
- Update session.json với working_on, pending_tasks, skipped_tests

### Changed
- `/plan` - Thêm giai đoạn 8 (Auto Phase Generation)
- `/code` - Thêm giai đoạn 4 (Auto Test Loop), giai đoạn 5 (Phase Progress Update), section 0.2.1 (All Phases)
- `/next` - Thêm section 1.4 (Check Plan Progress) và 2.2.5 (Phase Progress Display)
- `/deploy` - Thêm giai đoạn 0 (Pre-Audit), section 2.0 (Skipped Tests Check)
- `/recap` - Thêm skipped tests display
- `/save-brain` - Chuẩn hóa retry logic 3x

### Schema Updates
- `session.schema.json` - Added: `current_plan_path`, `current_phase`, `skipped_tests`

### Benefits
- **Tự động hóa:** Không cần gọi `/test` thủ công
- **Theo dõi tiến độ:** Biết đang ở phase nào, còn bao nhiêu
- **Chống mất context:** Auto-save sau mỗi milestone
- **Dễ resume:** `/recap` + `/next` để biết làm tiếp từ đâu
- **An toàn deploy:** Block deploy khi có tests skip hoặc chưa audit

---

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
