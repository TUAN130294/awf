#!/bin/bash
# AWF Installer for Mac/Linux
# Tự động detect Antigravity Global Workflows

REPO_BASE="https://raw.githubusercontent.com/TUAN130294/awf/main"
REPO_URL="$REPO_BASE/workflows"
WORKFLOWS=(
    "plan.md" "code.md" "visualize.md" "deploy.md"
    "debug.md" "refactor.md" "test.md" "run.md"
    "init.md" "recap.md" "rollback.md" "save_brain.md"
    "audit.md" "cloudflare-tunnel.md" "awf-update.md"
    "brainstorm.md" "next.md" "customize.md" "README.md"
)

# Schemas and Templates (v3.3+)
SCHEMAS=(
    "brain.schema.json" "session.schema.json" "preferences.schema.json"
)
TEMPLATES=(
    "brain.example.json" "session.example.json" "preferences.example.json"
)

# AWF Skills (v4.0+)
AWF_SKILLS=(
    "awf-session-restore"
    "awf-adaptive-language"
    "awf-error-translator"
    "awf-onboarding"
    "awf-context-help"
)

# Detect paths
ANTIGRAVITY_GLOBAL="$HOME/.gemini/antigravity/global_workflows"
SCHEMAS_DIR="$HOME/.gemini/antigravity/schemas"
TEMPLATES_DIR="$HOME/.gemini/antigravity/templates"
SKILLS_DIR="$HOME/.gemini/antigravity/skills"
GEMINI_MD="$HOME/.gemini/GEMINI.md"
AWF_VERSION_FILE="$HOME/.gemini/awf_version"

# Get version from repo
CURRENT_VERSION=$(curl -s "$REPO_BASE/VERSION" 2>/dev/null || echo "3.4.0")

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

# 2. Download Schemas (v3.3+)
mkdir -p "$SCHEMAS_DIR"
echo "⏳ Đang tải schemas..."
for schema in "${SCHEMAS[@]}"; do
    if curl -f -s -o "$SCHEMAS_DIR/$schema" "$REPO_BASE/schemas/$schema"; then
        echo "   ✅ $schema"
        ((success++))
    else
        echo "   ❌ $schema"
    fi
done

# 3. Download Templates (v3.3+)
mkdir -p "$TEMPLATES_DIR"
echo "⏳ Đang tải templates..."
for template in "${TEMPLATES[@]}"; do
    if curl -f -s -o "$TEMPLATES_DIR/$template" "$REPO_BASE/templates/$template"; then
        echo "   ✅ $template"
        ((success++))
    else
        echo "   ❌ $template"
    fi
done

# 4. Download AWF Skills (v4.0+)
echo "⏳ Đang tải skills (v4.0+)..."
for skill in "${AWF_SKILLS[@]}"; do
    mkdir -p "$SKILLS_DIR/$skill"
    if curl -f -s -o "$SKILLS_DIR/$skill/SKILL.md" "$REPO_BASE/awf_skills/$skill/SKILL.md"; then
        echo "   ✅ $skill"
        ((success++))
    else
        echo "   ❌ $skill"
    fi
done

# 5. Save version
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$AWF_VERSION_FILE"
echo "✅ Đã lưu version: $CURRENT_VERSION"

# 6. Update Global Rules
AWF_INSTRUCTIONS='
# AWF - Antigravity Workflow Framework

## CRITICAL: Command Recognition
Khi user gõ các lệnh bắt đầu bằng `/` dưới đây, đây là AWF WORKFLOW COMMANDS (không phải file path).
Bạn PHẢI đọc file workflow tương ứng và thực hiện theo hướng dẫn trong đó.

## Command Mapping (QUAN TRỌNG):
| Command | Workflow File | Mô tả |
|---------|--------------|-------|
| `/brainstorm` | ~/.gemini/antigravity/global_workflows/brainstorm.md | 💡 Bàn ý tưởng, research thị trường |
| `/plan` | ~/.gemini/antigravity/global_workflows/plan.md | Thiết kế tính năng |
| `/code` | ~/.gemini/antigravity/global_workflows/code.md | Viết code an toàn |
| `/visualize` | ~/.gemini/antigravity/global_workflows/visualize.md | Tạo UI/UX |
| `/debug` | ~/.gemini/antigravity/global_workflows/debug.md | Sửa lỗi sâu |
| `/test` | ~/.gemini/antigravity/global_workflows/test.md | Kiểm thử |
| `/run` | ~/.gemini/antigravity/global_workflows/run.md | Chạy ứng dụng |
| `/deploy` | ~/.gemini/antigravity/global_workflows/deploy.md | Deploy production |
| `/init` | ~/.gemini/antigravity/global_workflows/init.md | Khởi tạo dự án |
| `/recap` | ~/.gemini/antigravity/global_workflows/recap.md | Khôi phục ngữ cảnh |
| `/next` | ~/.gemini/antigravity/global_workflows/next.md | Gợi ý bước tiếp theo |
| `/customize` | ~/.gemini/antigravity/global_workflows/customize.md | ⚙️ Cá nhân hóa AI |
| `/save-brain` | ~/.gemini/antigravity/global_workflows/save_brain.md | Lưu kiến thức |
| `/audit` | ~/.gemini/antigravity/global_workflows/audit.md | Kiểm tra bảo mật |
| `/refactor` | ~/.gemini/antigravity/global_workflows/refactor.md | Tái cấu trúc code |
| `/rollback` | ~/.gemini/antigravity/global_workflows/rollback.md | Rollback deployment |
| `/cloudflare-tunnel` | ~/.gemini/antigravity/global_workflows/cloudflare-tunnel.md | Quản lý tunnel |
| `/awf-update` | ~/.gemini/antigravity/global_workflows/awf-update.md | Cập nhật AWF |

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
echo "🎉 HOÀN TẤT! Đã cài $success files vào hệ thống."
echo "📦 Version: $CURRENT_VERSION"
echo ""
echo "📂 Workflows: $ANTIGRAVITY_GLOBAL"
echo "📂 Schemas:   $SCHEMAS_DIR"
echo "📂 Templates: $TEMPLATES_DIR"
echo "📂 Skills:    $SKILLS_DIR"
echo ""
echo "👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!"
echo "👉 Thử gõ '/plan' để kiểm tra."
echo "👉 Kiểm tra update: '/awf-update'"
echo ""
