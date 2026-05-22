Param(
    [ValidateSet("1.0", "2.0", "both")]
    [string]$Version = "both"
)

# AWF Installer for Windows (PowerShell)
# Tự động detect Antigravity Global Workflows và tương thích cả Antigravity 1.0 & 2.0+

# Force UTF-8 Console Output Encoding để hiển thị tiếng Việt và emoji đẹp mắt
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$RepoBase = "https://raw.githubusercontent.com/TUAN130294/awf/main"
$RepoUrl = "$RepoBase/workflows"

# Encoding UTF-8 không BOM cho PowerShell 5.1+
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Full workflow list (v4.0.2) - Ordered by flow
$Workflows = @(
    # Core Flow: init → brainstorm → plan → design → visualize → code → run
    "init.md", "brainstorm.md", "plan.md", "design.md",
    "visualize.md", "code.md", "run.md",
    # Quality: debug → test → audit
    "debug.md", "test.md", "audit.md",
    # Deploy & Maintain
    "deploy.md", "refactor.md", "rollback.md",
    # Support workflows
    "next.md", "recap.md", "help.md", "customize.md",
    "save_brain.md", "review.md",
    # System
    "awf-update.md", "cloudflare-tunnel.md", "README.md"
)

# Schemas and Templates (v3.3+)
$Schemas = @(
    "brain.schema.json", "session.schema.json", "preferences.schema.json"
)
$Templates = @(
    "brain.example.json", "session.example.json", "preferences.example.json"
)

# AWF Skills (v4.1+)
$AwfSkills = @(
    "awf-session-restore",
    "awf-auto-save",          # NEW: Eternal Context System - auto-save triggers
    "awf-adaptive-language",
    "awf-error-translator",
    "awf-context-help",
    "awf-onboarding"
)

# Detect Antigravity target paths
$Targets = @()
if (Test-Path "$env:USERPROFILE\.gemini\antigravity") {
    $Targets += "$env:USERPROFILE\.gemini\antigravity"
}
if (Test-Path "$env:USERPROFILE\.gemini\antigravity-ide") {
    $Targets += "$env:USERPROFILE\.gemini\antigravity-ide"
}
if ($Targets.Count -eq 0) {
    $Targets += "$env:USERPROFILE\.gemini\antigravity"
}

$AwfVersionFile = "$env:USERPROFILE\.gemini\awf_version"

# Get version from repo
try {
    $CurrentVersion = (Invoke-WebRequest -Uri "$RepoBase/VERSION" -UseBasicParsing).Content.Trim()
} catch {
    $CurrentVersion = "4.1.2"
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🚀 AWF - Antigravity Workflow Framework v$CurrentVersion        ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚙️ Cài đặt phiên bản: $Version" -ForegroundColor Yellow
Write-Host ""

# Check if updating
if (Test-Path $AwfVersionFile) {
    try {
        $OldVersion = [System.IO.File]::ReadAllText($AwfVersionFile, [System.Text.Encoding]::UTF8).Trim()
        Write-Host "📦 Phiên bản hiện tại: $OldVersion" -ForegroundColor Yellow
        Write-Host "📦 Phiên bản mới: $CurrentVersion" -ForegroundColor Green
        Write-Host ""
    } catch {
        # Bỏ qua nếu lỗi đọc
    }
}

$success = 0

foreach ($Target in $Targets) {
    Write-Host "📂 Đang cài đặt vào mục tiêu: $Target" -ForegroundColor Cyan
    
    $AntigravityGlobal = "$Target\global_workflows"
    $SchemasDir = "$Target\schemas"
    $TemplatesDir = "$Target\templates"
    $SkillsDir = "$Target\skills"

    # 1. Cài Global Workflows (Cho bản 1.0 hoặc both)
    if ($Version -eq "1.0" -or $Version -eq "both") {
        if (-not (Test-Path $AntigravityGlobal)) {
            New-Item -ItemType Directory -Force -Path $AntigravityGlobal | Out-Null
            Write-Host "📂 Đã tạo thư mục Global: $AntigravityGlobal" -ForegroundColor Green
        } else {
            Write-Host "✅ Tìm thấy Antigravity Global: $AntigravityGlobal" -ForegroundColor Green
        }
    }

    Write-Host "⏳ Đang tải workflows..." -ForegroundColor Cyan
    foreach ($wf in $Workflows) {
        try {
            $wfDest = $wf
            if ($wf -eq "README.md") {
                $wfDest = "README.txt" # Đổi tên README.md để không làm crash parser của Antigravity
            }
            
            # 1. Nếu cài bản 1.0 hoặc both: Tải về global_workflows
            if ($Version -eq "1.0" -or $Version -eq "both") {
                $destPath = "$AntigravityGlobal\$wfDest"
                Invoke-WebRequest -Uri "$RepoUrl/$wf" -OutFile $destPath -ErrorAction Stop
                Write-Host "   ✅ $wfDest (Bản 1.0)" -ForegroundColor Green
                $success++
            }

            # 2. Nếu cài bản 2.0 hoặc both: Chuyển đổi/Đăng ký dưới dạng Skill
            if ($Version -eq "2.0" -or $Version -eq "both") {
                if ($wf -ne "README.md") {
                    $wfName = $wf.Replace(".md", "")
                    $skillName = "awf-$wfName"
                    $skillDir = "$SkillsDir\$skillName"
                    if (-not (Test-Path $skillDir)) {
                        New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
                    }
                    
                    # Nếu đã tải về local rồi (ở bước Version 1.0 hoặc both), copy sang cho nhanh
                    if ($Version -eq "both") {
                        Copy-Item -Path "$AntigravityGlobal\$wfDest" -Destination "$skillDir\SKILL.md" -Force
                    } else {
                        # Tải trực tiếp từ Github về SKILL.md
                        Invoke-WebRequest -Uri "$RepoUrl/$wf" -OutFile "$skillDir\SKILL.md" -ErrorAction Stop
                    }
                    Write-Host "      ➔ Đã đăng ký skill 2.0: $skillName" -ForegroundColor DarkGray
                    if ($Version -eq "2.0") {
                        $success++
                    }
                }
            }
        } catch {
            Write-Host "   ❌ $wf (Lỗi: $_)" -ForegroundColor Red
        }
    }

    # 2. Download Schemas
    if (-not (Test-Path $SchemasDir)) {
        New-Item -ItemType Directory -Force -Path $SchemasDir | Out-Null
    }
    Write-Host "⏳ Đang tải schemas..." -ForegroundColor Cyan
    foreach ($schema in $Schemas) {
        try {
            Invoke-WebRequest -Uri "$RepoBase/schemas/$schema" -OutFile "$SchemasDir\$schema" -ErrorAction Stop
            Write-Host "   ✅ $schema" -ForegroundColor Green
            $success++
        } catch {
            Write-Host "   ❌ $schema (Lỗi: $_)" -ForegroundColor Red
        }
    }

    # 3. Download Templates
    if (-not (Test-Path $TemplatesDir)) {
        New-Item -ItemType Directory -Force -Path $TemplatesDir | Out-Null
    }
    Write-Host "⏳ Đang tải templates..." -ForegroundColor Cyan
    foreach ($template in $Templates) {
        try {
            Invoke-WebRequest -Uri "$RepoBase/templates/$template" -OutFile "$TemplatesDir\$template" -ErrorAction Stop
            Write-Host "   ✅ $template" -ForegroundColor Green
            $success++
        } catch {
            Write-Host "   ❌ $template (Lỗi: $_)" -ForegroundColor Red
        }
    }

    # 4. Download AWF Skills mặc định
    if (-not (Test-Path $SkillsDir)) {
        New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
    }
    Write-Host "⏳ Đang tải skills mặc định..." -ForegroundColor Cyan
    foreach ($skill in $AwfSkills) {
        $skillDir = "$SkillsDir\$skill"
        if (-not (Test-Path $skillDir)) {
            New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
        }
        try {
            Invoke-WebRequest -Uri "$RepoBase/awf_skills/$skill/SKILL.md" -OutFile "$skillDir\SKILL.md" -ErrorAction Stop
            Write-Host "   ✅ $skill" -ForegroundColor Green
            $success++
        } catch {
            Write-Host "   ❌ $skill (Lỗi: $_)" -ForegroundColor Red
        }
    }
}

# 5. Save version (Global)
if (-not (Test-Path "$env:USERPROFILE\.gemini")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini" | Out-Null
}
[System.IO.File]::WriteAllText($AwfVersionFile, $CurrentVersion, $utf8NoBom)
Write-Host "✅ Đã lưu version: $CurrentVersion" -ForegroundColor Green

# 6. Update Global Rules (GEMINI.md)
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"
$AwfInstructions = @"

# AWF - Antigravity Workflow Framework

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng `/` dưới đây, đây là AWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (v4.0.2 - Full Flow):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| `/init` | init.md | ✨ Khởi tạo dự án mới |
| `/brainstorm` | brainstorm.md | 💡 Bàn ý tưởng, research |
| `/plan` | plan.md | 📋 Lên kế hoạch tính năng |
| `/design` | design.md | 🎨 Thiết kế kỹ thuật (DB, API, Flow) |
| `/visualize` | visualize.md | 🖼️ Thiết kế UI/UX mockup |
| `/code` | code.md | 💻 Viết code |
| `/run` | run.md | ▶️ Chạy ứng dụng |
| `/debug` | debug.md | 🐛 Sửa lỗi |
| `/test` | test.md | 🧪 Kiểm thử |
| `/audit` | audit.md | 🔒 Kiểm tra bảo mật |
| `/deploy` | deploy.md | 🚀 Deploy production |
| `/next` | next.md | ➡️ Gợi ý bước tiếp theo |
| `/recap` | recap.md | 📖 Khôi phục ngữ cảnh |
| `/help` | help.md | ❓ Trợ giúp & Hướng dẫn |
| `/customize` | customize.md | ⚙️ Cá nhân hóa AI |
| `/refactor` | refactor.md | 🔧 Tái cấu trúc code |
| `/review` | review.md | 👀 Review code |
| `/save-brain` | save_brain.md | 🧠 Lưu kiến thức |
| `/rollback` | rollback.md | ⏪ Rollback deployment |
| `/awf-update` | awf-update.md | 📦 Cập nhật AWF |
| `/cloudflare-tunnel` | cloudflare-tunnel.md | 🌐 Quản lý tunnel |

## Flow Chuẩn (v4.0.2):
`/init` → `/plan` → `/design` → `/code` → `/run` → `/test` → `/deploy`

## Resource Locations (v4.0+):
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/
- Skills: ~/.gemini/antigravity/skills/

## AWF Skills (v4.0 - Auto-activate):
Skills là helper ẩn, tự động kích hoạt khi cần. User KHÔNG cần gọi trực tiếp.

| Skill | Trigger | Chức năng |
|-------|---------|-----------|
| awf-session-restore | Đầu mỗi session | Tự động khôi phục context (lazy loading) |
| awf-auto-save | Workflow end, user leaving, decisions | Eternal Context - auto-save để không mất data |
| awf-adaptive-language | Đầu mỗi session | Điều chỉnh ngôn ngữ theo trình độ user |
| awf-error-translator | Khi có lỗi | Dịch lỗi kỹ thuật sang tiếng đời thường |
| awf-onboarding | /init lần đầu | Hướng dẫn user mới |
| awf-context-help | /help hoặc ? | Trợ giúp thông minh theo context |

**Cách hoạt động:**
1. Đọc ~/.brain/preferences.json để lấy technical_level (newbie/basic/technical)
2. Điều chỉnh ngôn ngữ trong workflows theo level
3. Skills tự động trigger, user không cần biết

## Hướng dẫn thực hiện:
1. Khi user gõ một trong các commands trên, ĐỌC FILE WORKFLOW tương ứng
2. Thực hiện TỪNG GIAI ĐOẠN trong workflow
3. KHÔNG tự ý bỏ qua bước nào
4. Kết thúc bằng NEXT STEPS menu như trong workflow

## Update Check:
- AWF version được lưu tại: ~/.gemini/awf_version
- Để kiểm tra và cập nhật AWF, user gõ: /awf-update
- Thỉnh thoảng (1 lần/tuần) nhắc user kiểm tra update nếu họ dùng AWF thường xuyên
"@

if (-not (Test-Path $GeminiMd)) {
    [System.IO.File]::WriteAllText($GeminiMd, $AwfInstructions, $utf8NoBom)
    Write-Host "✅ Đã tạo Global Rules (GEMINI.md)" -ForegroundColor Green
} else {
    $content = ""
    try {
        $content = [System.IO.File]::ReadAllText($GeminiMd, [System.Text.Encoding]::UTF8)
    } catch {}
    
    $awfMarker = "# AWF - Antigravity Workflow Framework"
    $markerIndex = $content.IndexOf($awfMarker)
    if ($markerIndex -ge 0) {
        $content = $content.Substring(0, $markerIndex)
    }
    $content = $content.TrimEnd() + "`r`n`r`n" + $AwfInstructions
    [System.IO.File]::WriteAllText($GeminiMd, $content, $utf8NoBom)
    Write-Host "✅ Đã cập nhật Global Rules (GEMINI.md)" -ForegroundColor Green
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 HOÀN TẤT! Đã cài $success files vào hệ thống." -ForegroundColor Yellow
Write-Host "📦 Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 Cài đặt thành công phiên bản $Version của AWF!" -ForegroundColor Green
Write-Host "👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!" -ForegroundColor Cyan
Write-Host "👉 Thử gõ '/plan' để kiểm tra." -ForegroundColor White
Write-Host "👉 Kiểm tra update: '/awf-update'" -ForegroundColor White
Write-Host ""
