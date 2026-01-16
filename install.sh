#!/bin/bash
# AWF Installer for Mac/Linux
# Tự động detect Antigravity Global Workflows

REPO_BASE="https://raw.githubusercontent.com/TUAN130294/awf/main"
REPO_URL="$REPO_BASE/workflows"
WORKFLOWS=(
    "plan.md" "code.md" "visualize.md" "deploy.md"
    "debug.md" "refactor.md" "test.md" "run.md"
    "init.md" "recap.md" "rollback.md" "save_brain.md"
    "audit.md" "cloudflare-tunnel.md" "awf-update.md" "README.md"
)

# Detect paths
ANTIGRAVITY_GLOBAL="$HOME/.gemini/antigravity/global_workflows"
GEMINI_MD="$HOME/.gemini/GEMINI.md"
AWF_VERSION_FILE="$HOME/.gemini/awf_version"

# Get version from repo
CURRENT_VERSION=$(curl -s "$REPO_BASE/VERSION" 2>/dev/null || echo "3.1.0")

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     🚀 AWF - Antigravity Workflow Framework v$CURRENT_VERSION        ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Check if updating
if [ -f "$AWF_VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$AWF_VERSION_FILE")
    echo "📦 Phiên bản hiện tại: $OLD_VERSION"
    echo "📦 Phiên bản mới: $CURRENT_VERSION"
    echo ""
fi

# 1. Cài Global Workflows
mkdir -p "$ANTIGRAVITY_GLOBAL"
echo "✅ Antigravity Global Path: $ANTIGRAVITY_GLOBAL"

echo "⏳ Đang tải workflows..."
success=0
for wf in "${WORKFLOWS[@]}"; do
    if curl -f -s -o "$ANTIGRAVITY_GLOBAL/$wf" "$REPO_URL/$wf"; then
        echo "   ✅ $wf"
        ((success++))
    else
        echo "   ❌ $wf"
    fi
done

# 2. Save version
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$AWF_VERSION_FILE"
echo "✅ Đã lưu version: $CURRENT_VERSION"

# 3. Update Global Rules
AWF_INSTRUCTIONS='
# AWF - Antigravity Workflow Framework

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng `/` dưới đây, đây là AWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (QUAN TRỌNG):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | Thiết kế tính năng |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Sửa lỗi sâu |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục ngữ cảnh |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md | Lưu kiến thức |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| `/cloudflare-tunnel` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Quản lý tunnel |
| `/awf-update` | ~/.gemini/antigravity/global_workflows/awf-update.md | Cập nhật AWF |

## Hướng dẫn thực hiện:
1. Khi user gõ một trong các commands trên, ĐỌC FILE WORKFLOW tương ứng
2. Thực hiện TỪNG GIAI ĐOẠN trong workflow
3. KHÔNG tự ý bỏ qua bước nào
4. Kết thúc bằng NEXT STEPS menu như trong workflow

## Update Check:
- AWF version được lưu tại: ~/.gemini/awf_version
- Để kiểm tra và cập nhật AWF, user gõ: /awf-update
- Thỉnh thoảng (1 lần/tuần) nhắc user kiểm tra update nếu họ dùng AWF thường xuyên
'

if [ ! -f "$GEMINI_MD" ]; then
    echo "$AWF_INSTRUCTIONS" > "$GEMINI_MD"
    echo "✅ Đã tạo Global Rules (GEMINI.md)"
else
    # Always update GEMINI.md to latest version
    # Remove old AWF section and add new one
    if grep -q "AWF - Antigravity Workflow Framework" "$GEMINI_MD"; then
        # Create temp file without AWF section
        sed '/# AWF - Antigravity Workflow Framework/,/^# [^A]/{ /^# [^A]/!d; }' "$GEMINI_MD" > "$GEMINI_MD.tmp"
        mv "$GEMINI_MD.tmp" "$GEMINI_MD"
    fi
    echo "$AWF_INSTRUCTIONS" >> "$GEMINI_MD"
    echo "✅ Đã cập nhật Global Rules (GEMINI.md)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 HOÀN TẤT! Đã cài $success workflows vào hệ thống."
echo "📦 Version: $CURRENT_VERSION"
echo ""
echo "👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!"
echo "👉 Thử gõ '/plan' để kiểm tra."
echo "👉 Kiểm tra update: '/awf-update'"
echo ""
