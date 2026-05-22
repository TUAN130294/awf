[🇻🇳 Tiếng Việt](README.md) | 🇬🇧 **English**

# AWF v4.0 - Antigravity Workflow Framework

> **Extension framework for Antigravity Agent.**
> Transform your AI into a professional team (PM, Designer, Coder) with standardized workflows.

[![Version](https://img.shields.io/badge/version-4.1.2-blue.svg)](https://github.com/TUAN130294/awf)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## Why AWF?

**Traditional AI coding:**
```
You: "Build me a todo app"
AI: *dumps 500 lines of code*
You: "Wait, what? Where do I put this?"
```

**With AWF:**
```
You: /init
AI: "What kind of app do you want to build? Tell me in plain language..."
    *guides you step by step*
    *explains everything in simple terms*
    *remembers context across sessions*
```

---

## Key Features

- **Multi-Persona AI**: Specialized AI team (PM Ha, Dev Tuan, Designer Mai, QA Long)
- **Eternal Context**: Auto-save and restore your working session
- **All-in-One**: No need to install additional skills/agents
- **Non-Tech Friendly**: Technical jargon automatically translated to plain language
- **Auto-Update**: Check and update to latest version anytime

---

## Quick Install (One Command)

### Windows (PowerShell)
Select the version suitable for your Antigravity setup:

* **For Antigravity v2.0+ (Recommended - New Skill Layout)**:
  ```powershell
  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1))) -Version 2.0
  ```

* **For Antigravity v1.0 (Legacy Global Layout)**:
  ```powershell
  & ([scriptblock]::Create((irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1))) -Version 1.0
  ```

* **Install Both (Maximum Compatibility / Default)**:
  ```powershell
  irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1 | iex
  ```

> ⚠️ **Windows: ExecutionPolicy error?** Run this first:
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### macOS / Linux
Select the version suitable for your Antigravity setup:

* **For Antigravity v2.0+ (Recommended - New Skill Layout)**:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | bash -s -- -v 2.0
  ```

* **For Antigravity v1.0 (Legacy Global Layout)**:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | bash -s -- -v 1.0
  ```

* **Install Both (Maximum Compatibility / Default)**:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | bash
  ```

**Done!** AWF will automatically download and configure into Antigravity.

---

## Getting Started

After installation, type this in Antigravity Chat:

```
/init
```

AI will ask what project you want to build and guide you step by step.

---

## Command Reference

### Project Lifecycle

| Command | Function | Description |
|---------|----------|-------------|
| `/init` | Bootstrap | Start a new project from scratch |
| `/brainstorm` | Ideation | Explore and refine your idea |
| `/plan` | Planning | AI acts as PM, interviews requirements |
| `/visualize` | Design | Create UI/UX before coding |
| `/code` | Development | AI codes according to spec |
| `/run` | Execute | Launch your application |
| `/debug` | Fix Bugs | Analyze and fix errors automatically |
| `/test` | Testing | Run test cases |
| `/deploy` | Ship | Push to production |

### Context & Memory

| Command | Function | Description |
|---------|----------|-------------|
| `/recap` | Remember | Restore context from previous session |
| `/save-brain` | Save | Store project knowledge for later |
| `/next` | Navigate | Get suggestions for next steps |

### Customization

| Command | Function | Description |
|---------|----------|-------------|
| `/customize` | Personalize | Set AI communication style |
| `/awf-update` | Update | Check and update AWF |

---

## For Non-Technical Users

AWF automatically adjusts its language based on your technical level:

### Technical Level: Newbie
```
Database     → "Storage for your app's information"
API          → "Bridge between different software"
Deploy       → "Put your app online for others to use"
Debug        → "Find and fix problems"
```

### Error Translation
When errors happen, AWF translates them:
```
ECONNREFUSED     → "Database not running - start your database app"
Cannot find module → "Missing library - run npm install"
CORS error       → "Server blocking request - needs server config"
```

---

## AI Personas

AWF includes specialized AI personalities:

| Persona | Role | Style |
|---------|------|-------|
| **Ha** | Product Manager | Friendly, asks clarifying questions, prioritizes user needs |
| **Tuan** | Senior Developer | Patient, explains the "why", never judges |
| **Mai** | UX Designer | Visual thinker, uses real-world examples |
| **Long** | QA Detective | Calm, thorough, always has a hypothesis |

---

## Folder Structure (After Install)

```
~/.gemini/antigravity/
├── global_workflows/    # Main workflows (/init, /plan, /code...)
├── skills/              # AWF Skills (auto-activate)
├── schemas/             # JSON Schemas
└── templates/           # Configuration templates
```

---

## AWF Skills (Auto-Activate)

These skills work silently in the background:

| Skill | Trigger | Function |
|-------|---------|----------|
| `awf-session-restore` | Session start | Auto-restore previous context |
| `awf-adaptive-language` | Session start | Adjust language to user level |
| `awf-error-translator` | On error | Translate technical errors to plain language |
| `awf-context-help` | `/help` or `?` | Smart help based on current context |

---

## Update

To check and update to the latest version:
```
/awf-update
```

---

## Workflow Chain

```
/brainstorm → /plan → /visualize → /code → /test → /deploy
      ↓                              ↓
   BRIEF.md                      /debug (if errors)
                                     ↓
                                /save-brain (end of session)
```

---

## Configuration

### Personality Modes (via /customize)

**Mentor Mode:**
- Explains WHY, not just HOW
- Asks questions back to make you think
- "Do you understand why we use try-catch here?"

**Strict Coach Mode:**
- High standards for code quality
- Points out best practices
- "This approach isn't optimal because..."

### Technical Levels

| Level | Behavior |
|-------|----------|
| `newbie` | Hide all technical details, explain everything |
| `basic` | Mix of simple and technical terms |
| `technical` | Full technical terminology, no explanations |

---

## Changelog

### v4.1.2 (Latest)
- 🆕 Support selective installation for Antigravity 1.0 and 2.0+ via `-Version` parameter
- ✅ Fix UTF-8 encoding/font issues in Windows PowerShell Console
- ✅ Rename README.md in global_workflows to README.txt to prevent parser crash

### v4.1.0
- 🆕 **Eternal Context System** - Auto-save to never lose context
- 🆕 Smart trigger skill `awf-auto-save`
- 🆕 3-Tier lazy loading for session restore
- ✅ Session schema v2.0 with summary & checkpoints

### v4.0.1
- Fix Windows install script issues
- Improved Session Restore skill
- Added `/awf-update` workflow

### v4.0.0
- New Skill System (awf-session-restore, awf-error-translator...)
- Schemas & Templates
- Multi-language support
- Non-Tech Mode for all workflows

### v3.2.4
- Flexible `/customize` options
- Response length settings
- Global + Local preferences

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## Support

- Issues: [GitHub Issues](https://github.com/TUAN130294/awf/issues)
- Discussions: [GitHub Discussions](https://github.com/TUAN130294/awf/discussions)

---

## License

MIT License - feel free to use in personal and commercial projects.

---

**Happy Vibe Coding!**

*Authored by Antigravity Team*
