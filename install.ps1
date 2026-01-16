# AWF Installer for Windows (PowerShell)
# Tự động detect Antigravity Global Workflows

$RepoUrl = "https://raw.githubusercontent.com/TUAN130294/awf/main/workflows"
$Workflows = @(
    "plan.md", "code.md", "visualize.md", "deploy.md", 
    "debug.md", "refactor.md", "test.md", "run.md", 
    "init.md", "recap.md", "rollback.md", "save_brain.md", 
    "audit.md", "cloudflare-tunnel.md", "README.md"
)

# Detect Antigravity Global Path
$AntigravityGlobal = "$env:USERPROFILE\.gemini\antigravity\global_workflows"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     🚀 AWF - Antigravity Workflow Framework v3.0         ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

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

# 2. Update Global Rules (GEMINI.md)
$AwfInstructions = @"

# AWF - Antigravity Workflow Framework v3.0

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng ``/`` dưới đây, đây là AWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (QUAN TRỌNG):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| ``/plan`` | ~/.gemini/antigravity/global_workflows/plan.md | Thiết kế tính năng |
| ``/code`` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| ``/visualize`` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| ``/debug`` | ~/.gemini/antigravity/global_workflows/debug.md | Sửa lỗi sâu |
| ``/test`` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| ``/run`` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| ``/deploy`` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| ``/init`` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| ``/recap`` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục ngữ cảnh |
| ``/save-brain`` | ~/.gemini/antigravity/global_workflows/save_brain.md | Lưu kiến thức |
| ``/audit`` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| ``/refactor`` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| ``/rollback`` | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| ``/cloudflare-tunnel`` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Quản lý tunnel |

## Hướng dẫn thực hiện:
1. Khi user gõ một trong các commands trên, ĐỌC FILE WORKFLOW tương ứng
2. Thực hiện TỪNG GIAI ĐOẠN trong workflow
3. KHÔNG tự ý bỏ qua bước nào
4. Kết thúc bằng NEXT STEPS menu như trong workflow
"@

if (-not (Test-Path $GeminiMd)) {
    # Nếu chưa có file, tạo mới
    if (-not (Test-Path "$env:USERPROFILE\.gemini")) { New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini" | Out-Null }
    Set-Content -Path $GeminiMd -Value $AwfInstructions -Encoding UTF8
    Write-Host "✅ Đã tạo Global Rules (GEMINI.md)" -ForegroundColor Green
} else {
    # Nếu có rồi, check xem đã có AWF chưa
    $content = Get-Content $GeminiMd -Raw
    if (-not $content.Contains("AWF - Antigravity Workflow Framework")) {
        Add-Content -Path $GeminiMd -Value $AwfInstructions -Encoding UTF8
        Write-Host "✅ Đã cập nhật Global Rules (GEMINI.md)" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "🎉 HOÀN TẤT! Đã cài $success workflows vào hệ thống." -ForegroundColor Yellow
Write-Host ""
Write-Host "👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!" -ForegroundColor Cyan
Write-Host "👉 Thử gõ '/plan' để kiểm tra." -ForegroundColor White
Write-Host ""
