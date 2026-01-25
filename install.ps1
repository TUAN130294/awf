# AWF Installer for Windows (PowerShell)
# Tự động detect Antigravity Global Workflows

$RepoBase = "https://raw.githubusercontent.com/TUAN130294/awf/main"
$RepoUrl = "$RepoBase/workflows"
$Workflows = @(
    "plan.md", "code.md", "visualize.md", "deploy.md",
    "debug.md", "refactor.md", "test.md", "run.md",
    "init.md", "recap.md", "rollback.md", "save_brain.md",
    "audit.md", "cloudflare-tunnel.md", "awf-update.md",
    "brainstorm.md", "next.md", "customize.md", "README.md"
)

# Schemas and Templates (v3.3+)
$Schemas = @(
    "brain.schema.json", "session.schema.json", "preferences.schema.json"
)
$Templates = @(
    "brain.example.json", "session.example.json", "preferences.example.json"
)

# AWF Skills (v4.0+)
$AwfSkills = @(
    "awf-session-restore",
    "awf-adaptive-language",
    "awf-error-translator",
    "awf-context-help"
)

# Detect Antigravity Global Path
$AntigravityGlobal = "$env:USERPROFILE\.gemini\antigravity\global_workflows"
$SchemasDir = "$env:USERPROFILE\.gemini\antigravity\schemas"
$TemplatesDir = "$env:USERPROFILE\.gemini\antigravity\templates"
$SkillsDir = "$env:USERPROFILE\.gemini\antigravity\skills"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"
$AwfVersionFile = "$env:USERPROFILE\.gemini\awf_version"

# Get version from repo
try {
    $CurrentVersion = (Invoke-WebRequest -Uri "$RepoBase/VERSION" -UseBasicParsing).Content.Trim()
} catch {
    $CurrentVersion = "3.4.0"
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🚀 AWF - Antigravity Workflow Framework v$CurrentVersion        ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if updating
if (Test-Path $AwfVersionFile) {
    $OldVersion = Get-Content $AwfVersionFile
    Write-Host "📦 Phiên bản hiện tại: $OldVersion" -ForegroundColor Yellow
    Write-Host "📦 Phiên bản mới: $CurrentVersion" -ForegroundColor Green
    Write-Host ""
}

# 1. Cài Global Workflows
if (-not (Test-Path $AntigravityGlobal)) {
    New-Item -ItemType Directory -Force -Path $AntigravityGlobal | Out-Null
    Write-Host "📂 Đã tạo thư mục Global: $AntigravityGlobal" -ForegroundColor Green
} else {
    Write-Host "✅ Tìm thấy Antigravity Global: $AntigravityGlobal" -ForegroundColor Green
}

Write-Host "⏳ Đang tải workflows..." -ForegroundColor Cyan
$success = 0
foreach ($wf in $Workflows) {
    try {
        Invoke-WebRequest -Uri "$RepoUrl/$wf" -OutFile "$AntigravityGlobal\$wf" -ErrorAction Stop
        Write-Host "   ✅ $wf" -ForegroundColor Green
        $success++
    } catch {
        Write-Host "   ❌ $wf" -ForegroundColor Red
    }
}

# 2. Download Schemas (v3.3+)
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
        Write-Host "   ❌ $schema" -ForegroundColor Red
    }
}

# 3. Download Templates (v3.3+)
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
        Write-Host "   ❌ $template" -ForegroundColor Red
    }
}

# 4. Download AWF Skills (v4.0+)
Write-Host "⏳ Đang tải skills (v4.0+)..." -ForegroundColor Cyan
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
        Write-Host "   ❌ $skill" -ForegroundColor Red
    }
}

# 5. Save version
if (-not (Test-Path "$env:USERPROFILE\.gemini")) {
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini" | Out-Null
}
Set-Content -Path $AwfVersionFile -Value $CurrentVersion -Encoding UTF8
Write-Host "✅ Đã lưu version: $CurrentVersion" -ForegroundColor Green

# 5. Update Global Rules (GEMINI.md)
$AwfInstructions = @"

# AWF - Antigravity Workflow Framework

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng ``/`` dưới đây, đây là AWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (QUAN TRỌNG):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| ``/brainstorm`` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 Bàn ý tưởng, research thị trường |
| ``/plan`` | ~/.gemini/antigravity/global_workflows/plan.md | Thiết kế tính năng |
| ``/code`` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| ``/visualize`` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| ``/debug`` | ~/.gemini/antigravity/global_workflows/debug.md | Sửa lỗi sâu |
| ``/test`` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| ``/run`` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| ``/deploy`` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| ``/init`` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| ``/recap`` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục ngữ cảnh |
| ``/next`` | ~/.gemini/antigravity/global_workflows/next.md | Gợi ý bước tiếp theo |
| ``/customize`` | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ Cá nhân hóa AI |
| ``/save-brain`` | ~/.gemini/antigravity/global_workflows/save_brain.md | Lưu kiến thức |
| ``/audit`` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| ``/refactor`` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| ``/rollback`` | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| ``/cloudflare-tunnel`` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Quản lý tunnel |
| ``/awf-update`` | ~/.gemini/antigravity/global_workflows/awf-update.md | Cập nhật AWF |

## Resource Locations (v4.0+):
- Schemas: ~/.gemini/antigravity/schemas/
- Templates: ~/.gemini/antigravity/templates/
- Skills: ~/.gemini/antigravity/skills/

## AWF Skills (v4.0 - Auto-activate):
Skills là helper ẩn, tự động kích hoạt khi cần. User KHÔNG cần gọi trực tiếp.

| Skill | Trigger | Chức năng |
|-------|---------|-----------|
| awf-session-restore | Đầu mỗi session | Tự động khôi phục context |
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
    Set-Content -Path $GeminiMd -Value $AwfInstructions -Encoding UTF8
    Write-Host "✅ Đã tạo Global Rules (GEMINI.md)" -ForegroundColor Green
} else {
    # Always update to latest version - just overwrite AWF section
    $content = Get-Content $GeminiMd -Raw -ErrorAction SilentlyContinue
    if ($null -eq $content) { $content = "" }

    # Simple check and replace: remove everything from AWF header to end of file
    $awfMarker = "# AWF - Antigravity Workflow Framework"
    $markerIndex = $content.IndexOf($awfMarker)
    if ($markerIndex -ge 0) {
        $content = $content.Substring(0, $markerIndex)
    }
    $content = $content.TrimEnd() + "`n" + $AwfInstructions
    Set-Content -Path $GeminiMd -Value $content -Encoding UTF8
    Write-Host "✅ Đã cập nhật Global Rules (GEMINI.md)" -ForegroundColor Green
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 HOÀN TẤT! Đã cài $success files vào hệ thống." -ForegroundColor Yellow
Write-Host "📦 Version: $CurrentVersion" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 Workflows: $AntigravityGlobal" -ForegroundColor DarkGray
Write-Host "📂 Schemas:   $SchemasDir" -ForegroundColor DarkGray
Write-Host "📂 Templates: $TemplatesDir" -ForegroundColor DarkGray
Write-Host "📂 Skills:    $SkillsDir" -ForegroundColor DarkGray
Write-Host ""
Write-Host "👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!" -ForegroundColor Cyan
Write-Host "👉 Thử gõ '/plan' để kiểm tra." -ForegroundColor White
Write-Host "👉 Kiểm tra update: '/awf-update'" -ForegroundColor White
Write-Host ""

# Exit cleanly
exit 0
