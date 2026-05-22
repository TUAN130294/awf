#!/bin/bash
# AWF Installer for macOS/Linux
# Tự động detect Antigravity Global Workflows và tương thích cả Antigravity 1.0 & 2.0+

# Default version is both
VERSION="both"

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -v|--version|-version) VERSION="$2"; shift ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Ensure valid version
if [[ "$VERSION" != "1.0" && "$VERSION" != "2.0" && "$VERSION" != "both" ]]; then
    VERSION="both"
fi

REPO_BASE="https://raw.githubusercontent.com/TUAN130294/awf/main"
REPO_URL="$REPO_BASE/workflows"

# Full workflow list (v4.0.2) - Ordered by flow
WORKFLOWS=(
    # Core Flow: init → brainstorm → plan → design → visualize → code → run
    "init.md" "brainstorm.md" "plan.md" "design.md"
    "visualize.md" "code.md" "run.md"
    # Quality: debug → test → audit
    "debug.md" "test.md" "audit.md"
    # Deploy & Maintain
    "deploy.md" "refactor.md" "rollback.md"
    # Support workflows
    "next.md" "recap.md" "help.md" "customize.md"
    "save_brain.md" "review.md"
    # System
    "awf-update.md" "cloudflare-tunnel.md" "README.md"
)

# Schemas and Templates (v3.3+)
SCHEMAS=(
    "brain.schema.json" "session.schema.json" "preferences.schema.json"
)
TEMPLATES=(
    "brain.example.json" "session.example.json" "preferences.example.json"
)

# AWF Skills (v4.1+)
AWF_SKILLS=(
    "awf-session-restore"
    "awf-auto-save"
    "awf-adaptive-language"
    "awf-error-translator"
    "awf-context-help"
    "awf-onboarding"
)

# Detect Antigravity target paths
TARGETS=()
if [ -d "$HOME/.gemini/antigravity" ]; then
    TARGETS+=("$HOME/.gemini/antigravity")
fi
if [ -d "$HOME/.gemini/antigravity-ide" ]; then
    TARGETS+=("$HOME/.gemini/antigravity-ide")
fi
if [ ${#TARGETS[@]} -eq 0 ]; then
    TARGETS+=("$HOME/.gemini/antigravity")
fi

AWF_VERSION_FILE="$HOME/.gemini/awf_version"
GEMINI_MD="$HOME/.gemini/GEMINI.md"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Get version from repo
CURRENT_VERSION=$(curl -fsSL "$REPO_BASE/VERSION" 2>/dev/null || echo "4.1.2")
CURRENT_VERSION=$(echo "$CURRENT_VERSION" | tr -d '\r\n ')

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     🚀 AWF - Antigravity Workflow Framework v$CURRENT_VERSION        ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}⚙️ Cài đặt phiên bản: $VERSION${NC}"
echo ""

# Check if updating
if [ -f "$AWF_VERSION_FILE" ]; then
    OLD_VERSION=$(cat "$AWF_VERSION_FILE")
    echo -e "${YELLOW}📦 Phiên bản hiện tại: $OLD_VERSION${NC}"
    echo -e "${GREEN}📦 Phiên bản mới: $CURRENT_VERSION${NC}"
    echo ""
fi

success=0

for TARGET in "${TARGETS[@]}"; do
    echo -e "${CYAN}📂 Đang cài đặt vào mục tiêu: $TARGET${NC}"
    
    ANTIGRAVITY_GLOBAL="$TARGET/global_workflows"
    SCHEMAS_DIR="$TARGET/schemas"
    TEMPLATES_DIR="$TARGET/templates"
    SKILLS_DIR="$TARGET/skills"

    # 1. Cài Global Workflows (Cho bản 1.0 hoặc both)
    if [[ "$VERSION" == "1.0" || "$VERSION" == "both" ]]; then
        if [ ! -d "$ANTIGRAVITY_GLOBAL" ]; then
            mkdir -p "$ANTIGRAVITY_GLOBAL"
            echo -e "   ${GREEN}📂 Đã tạo thư mục Global: $ANTIGRAVITY_GLOBAL${NC}"
        else
            echo -e "   ${GREEN}✅ Tìm thấy Antigravity Global: $ANTIGRAVITY_GLOBAL${NC}"
        fi
    fi

    echo -e "   ${CYAN}⏳ Đang tải workflows...${NC}"
    for wf in "${WORKFLOWS[@]}"; do
        wf_dest="$wf"
        if [ "$wf" = "README.md" ]; then
            wf_dest="README.txt" # Đổi tên README.md để không làm crash parser
        fi

        # 1. Nếu cài bản 1.0 hoặc both: Tải về global_workflows
        if [[ "$VERSION" == "1.0" || "$VERSION" == "both" ]]; then
            if curl -fsSL "$REPO_URL/$wf" -o "$ANTIGRAVITY_GLOBAL/$wf_dest" 2>/dev/null; then
                echo -e "      ${GREEN}✅ $wf_dest (Bản 1.0)${NC}"
                ((success++))
            else
                echo -e "      ${RED}❌ $wf_dest${NC}"
            fi
        fi

        # 2. Nếu cài bản 2.0 hoặc both: Chuyển đổi/Đăng ký dưới dạng Skill
        if [[ "$VERSION" == "2.0" || "$VERSION" == "both" ]]; then
            if [ "$wf" != "README.md" ]; then
                wf_name="${wf%.md}"
                skill_name="awf-$wf_name"
                skill_dir="$SKILLS_DIR/$skill_name"
                mkdir -p "$skill_dir"
                
                # Nếu đã tải về local rồi (ở bước Version 1.0 hoặc both), copy sang cho nhanh
                if [ "$VERSION" = "both" ]; then
                    cp -f "$ANTIGRAVITY_GLOBAL/$wf_dest" "$skill_dir/SKILL.md"
                else
                    # Tải trực tiếp từ Github về SKILL.md
                    if curl -fsSL "$REPO_URL/$wf" -o "$skill_dir/SKILL.md" 2>/dev/null; then
                        ((success++))
                    fi
                fi
                echo -e "      ${GRAY}➔ Đã đăng ký skill 2.0: $skill_name${NC}"
            fi
        fi
    done

    # 2. Download Schemas
    mkdir -p "$SCHEMAS_DIR"
    echo -e "   ${CYAN}⏳ Đang tải schemas...${NC}"
    for schema in "${SCHEMAS[@]}"; do
        if curl -fsSL "$REPO_BASE/schemas/$schema" -o "$SCHEMAS_DIR/$schema" 2>/dev/null; then
            echo -e "      ${GREEN}✅ $schema${NC}"
            ((success++))
        else
            echo -e "      ${RED}❌ $schema${NC}"
        fi
    done

    # 3. Download Templates
    mkdir -p "$TEMPLATES_DIR"
    echo -e "   ${CYAN}⏳ Đang tải templates...${NC}"
    for template in "${TEMPLATES[@]}"; do
        if curl -fsSL "$REPO_BASE/templates/$template" -o "$TEMPLATES_DIR/$template" 2>/dev/null; then
            echo -e "      ${GREEN}✅ $template${NC}"
            ((success++))
        else
            echo -e "      ${RED}❌ $template${NC}"
        fi
    done

    # 4. Download AWF Skills mặc định
    mkdir -p "$SKILLS_DIR"
    echo -e "   ${CYAN}⏳ Đang tải skills mặc định...${NC}"
    for skill in "${AWF_SKILLS[@]}"; do
        skill_dir="$SKILLS_DIR/$skill"
        mkdir -p "$skill_dir"
        if curl -fsSL "$REPO_BASE/awf_skills/$skill/SKILL.md" -o "$skill_dir/SKILL.md" 2>/dev/null; then
            echo -e "      ${GREEN}✅ $skill${NC}"
            ((success++))
        else
            echo -e "      ${RED}❌ $skill${NC}"
        fi
    done
done

# 5. Save version
mkdir -p "$HOME/.gemini"
echo "$CURRENT_VERSION" > "$AWF_VERSION_FILE"
echo -e "${GREEN}✅ Đã lưu version: $CURRENT_VERSION${NC}"

# 6. Update Global Rules (GEMINI.md)
AWF_INSTRUCTIONS='
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
'

if [ ! -f "$GEMINI_MD" ]; then
    echo "$AWF_INSTRUCTIONS" > "$GEMINI_MD"
    echo -e "${GREEN}✅ Đã tạo Global Rules (GEMINI.md)${NC}"
else
    # Remove old AWF section and append new one
    AWF_MARKER="# AWF - Antigravity Workflow Framework"
    if grep -q "$AWF_MARKER" "$GEMINI_MD" 2>/dev/null; then
        # Remove from marker to end of file
        sed -i.bak "/$AWF_MARKER/,\$d" "$GEMINI_MD" 2>/dev/null || sed -i '' "/$AWF_MARKER/,\$d" "$GEMINI_MD"
        rm -f "$GEMINI_MD.bak"
    fi
    echo "$AWF_INSTRUCTIONS" >> "$GEMINI_MD"
    echo -e "${GREEN}✅ Đã cập nhật Global Rules (GEMINI.md)${NC}"
fi

echo ""
echo -e "${GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}🎉 HOÀN TẤT! Đã cài $success files vào hệ thống.${NC}"
echo -e "${CYAN}📦 Version: $CURRENT_VERSION${NC}"
echo ""
echo -e "${GREEN}📂 Workflows & Skills đã được đồng bộ hóa thành công cho Antigravity 2.0+!${NC}"
echo -e "${CYAN}👉 Bạn có thể dùng AWF ở BẤT KỲ project nào ngay lập tức!${NC}"
echo -e "👉 Thử gõ '/plan' để kiểm tra."
echo -e "👉 Kiểm tra update: '/awf-update'"
echo ""
