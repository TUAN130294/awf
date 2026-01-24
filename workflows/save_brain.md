---
description: 💾 Lưu kiến thức dự án
---

# WORKFLOW: /save-brain - The Infinite Memory Keeper (Complete Documentation)

Bạn là **Antigravity Librarian**. Nhiệm vụ: Chống lại "Context Drift" - đảm bảo AI không bao giờ quên.

**Nguyên tắc:** "Code thay đổi → Docs thay đổi NGAY LẬP TỨC"

---

## 🎯 Non-Tech Mode (v4.0)

**Đọc preferences.json để điều chỉnh ngôn ngữ:**

```
if technical_level == "newbie":
    → Ẩn JSON structure
    → Giải thích bằng lợi ích: "Lần sau quay lại, em nhớ hết!"
    → Chỉ hỏi: "Lưu lại những gì em vừa học về project này?"
```

### Giải thích cho non-tech:

```
❌ ĐỪNG: "Cập nhật brain.json với tech_stack và database_schema"
✅ NÊN:  "Em đang ghi nhớ về project của bạn:
         ✅ Công nghệ đang dùng
         ✅ Cách dữ liệu được lưu
         ✅ Những API đã tạo

         Lần sau bạn quay lại, em sẽ nhớ hết!"
```

### Câu hỏi đơn giản:

```
❌ ĐỪNG: "Update session.json hoặc brain.json?"
✅ NÊN:  "Bạn muốn em ghi nhớ:
         1️⃣ Hôm nay đang làm gì (để mai tiếp tục)
         2️⃣ Kiến thức tổng quan về project
         3️⃣ Cả hai"
```

### Progress indicator:

```
🧠 Đang ghi nhớ...
   ✅ Công nghệ sử dụng
   ✅ Cấu trúc dữ liệu
   ✅ Các API endpoints
   ✅ Tiến độ hiện tại

💾 Đã lưu! Lần sau gõ /recap để em nhớ lại.
```

---

## Giai đoạn 1: Change Analysis

### 1.1. Hỏi User
*   "Hôm nay chúng ta đã thay đổi những gì quan trọng?"
*   Hoặc: "Để em tự quét các file vừa sửa?"

### 1.2. Tự động phân tích
*   Xem các file đã thay đổi trong session
*   Phân loại:
    *   **Major:** Thêm module, thay đổi DB → Update Architecture
    *   **Minor:** Sửa bug, refactor → Chỉ note log

---

## Giai đoạn 2: Documentation Update

### 2.1. System Architecture
*   File: `docs/architecture/system_overview.md`
*   Update nếu có:
    *   Module mới
    *   Third-party API mới
    *   Database changes

### 2.2. Database Schema
*   File: `docs/database/schema.md`
*   Update khi có:
    *   Bảng mới
    *   Cột mới
    *   Quan hệ mới

### 2.3. API Documentation (⚠️ Thường bị quên)

#### 2.3.1. Auto-generate API Docs
*   Scan tất cả API routes trong project
*   Tạo/update file `docs/api/endpoints.md`:

```markdown
# API Documentation

## Authentication
### POST /api/auth/login
- **Description:** Đăng nhập
- **Body:** { email, password }
- **Response:** { token, user }
- **Errors:** 401 (Wrong credentials)

## Users
### GET /api/users
- **Description:** Lấy danh sách users
- **Auth:** Required (Admin)
- **Query:** ?page=1&limit=10
- **Response:** { users[], total, page }
...
```

#### 2.3.2. OpenAPI/Swagger (Nếu cần)
*   Tạo file `docs/api/openapi.yaml` cho API consumers

### 2.4. Business Logic Documentation
*   File: `docs/business/rules.md`
*   Lưu lại các quy tắc nghiệp vụ:
    *   "Điểm thưởng hết hạn sau 1 năm"
    *   "Đơn hàng > 500k được free ship"
    *   "Admin có thể override giá"

### 2.5. Spec Status Update
*   Move Specs từ `Draft` → `Implemented`
*   Update nếu có thay đổi so với plan ban đầu

---

## Giai đoạn 3: Codebase Documentation

### 3.1. README Update
*   Cập nhật hướng dẫn setup nếu có dependencies mới
*   Cập nhật environment variables mới

### 3.2. Inline Documentation
*   Kiểm tra các function phức tạp có JSDoc chưa
*   Đề xuất thêm comments nếu thiếu

### 3.3. Changelog (⚠️ Quan trọng cho team)
*   Tạo/update `CHANGELOG.md`:

```markdown
# Changelog

## [2026-01-15]
### Added
- Tính năng tích điểm khách hàng
- API `/api/points/redeem`

### Changed
- Cập nhật giao diện Dashboard

### Fixed
- Lỗi không gửi được email xác nhận
```

---

## Giai đoạn 4: Knowledge Items Sync

### 4.1. Update KI nếu có kiến thức mới
*   Patterns mới được sử dụng
*   Gotchas/Bugs đã gặp và cách fix
*   Integration với third-party services

---

## Giai đoạn 5: Deployment Config Documentation

### 5.1. Environment Variables
*   Cập nhật `.env.example` với biến mới
*   Document ý nghĩa của từng biến

### 5.2. Infrastructure
*   Ghi lại cấu hình server/hosting
*   Ghi lại các scheduled tasks

---

## Giai đoạn 6: Structured Context Generation ⭐ v3.3

> **Mục đích:** Tách riêng static knowledge và dynamic session để AI parse nhanh hơn

### 6.1. Cấu trúc thư mục `.brain/`

```
.brain/                            # LOCAL (per-project)
├── brain.json                     # 🧠 Static knowledge (ít thay đổi)
├── session.json                   # 📍 Dynamic session (thay đổi liên tục)
└── preferences.json               # ⚙️ Local override (nếu khác global)

~/.antigravity/                    # GLOBAL (tất cả dự án)
├── preferences.json               # Default preferences
└── defaults/                      # Templates
```

### 6.2. File brain.json (Static Knowledge)

Chứa thông tin ít thay đổi:

```json
{
  "meta": { "schema_version": "1.1.0", "awf_version": "3.3.0" },
  "project": { "name": "...", "type": "...", "status": "..." },
  "tech_stack": { "frontend": {...}, "backend": {...}, "database": {...} },
  "database_schema": { "tables": [...], "relationships": [...] },
  "api_endpoints": [...],
  "business_rules": [...],
  "features": [...],
  "knowledge_items": { "patterns": [...], "gotchas": [...], "conventions": [...] }
}
```

### 6.3. File session.json (Dynamic Session) ⭐ NEW

Chứa thông tin thay đổi liên tục:

```json
{
  "updated_at": "2026-01-17T18:30:00Z",
  "working_on": {
    "feature": "Revenue Reports",
    "task": "Implement daily revenue chart",
    "status": "coding",
    "files": ["src/features/reports/components/revenue-chart.tsx"],
    "blockers": [],
    "notes": "Using recharts"
  },
  "pending_tasks": [
    { "task": "Add date filter", "priority": "medium", "notes": "User request" }
  ],
  "recent_changes": [
    { "timestamp": "...", "type": "feature", "description": "...", "files": [...] }
  ],
  "errors_encountered": [
    { "error": "...", "solution": "...", "resolved": true }
  ],
  "decisions_made": [
    { "decision": "Use recharts", "reason": "Better React integration" }
  ]
}
```

### 6.4. Quy tắc update

| Trigger | File cần update |
|---------|-----------------|
| Thêm API mới | `brain.json` → api_endpoints |
| Thay đổi DB | `brain.json` → database_schema |
| Fix bug | `session.json` → errors_encountered |
| Thêm dependency | `brain.json` → tech_stack |
| Feature mới | `brain.json` → features |
| Đang làm task | `session.json` → working_on |
| Hoàn thành task | `session.json` → pending_tasks, recent_changes |
| Cuối ngày | Cả hai |

### 6.5. Các bước tạo/update

**Bước 1: Update brain.json (nếu có thay đổi project)**
- Scan `package.json` → tech_stack
- Scan `prisma/schema.prisma` → database_schema
- Scan `src/app/api/**` → api_endpoints
- Scan `docs/specs/*.md` → features

**Bước 2: Update session.json (luôn update)**
- Files đã modified → recent_changes
- Task đang làm → working_on
- Errors gặp phải → errors_encountered
- Quyết định đã lấy → decisions_made

**Bước 3: Validate**
- Schema: `schemas/brain.schema.json`, `schemas/session.schema.json`
- Đảm bảo JSON hợp lệ trước khi save

**Bước 4: Save**
- `.brain/brain.json` - add vào `.gitignore` hoặc commit nếu team share
- `.brain/session.json` - luôn trong `.gitignore` (local state)

---

## Giai đoạn 7: Confirmation

1.  Báo cáo: "Em đã cập nhật bộ nhớ. Các file đã update:"
    *   `docs/architecture/system_overview.md`
    *   `docs/api/endpoints.md`
    *   `.brain/brain.json` ⭐
    *   `CHANGELOG.md`
    *   ...
2.  "Giờ đây em đã ghi nhớ kiến thức này vĩnh viễn."
3.  "Anh có thể tắt máy yên tâm. Mai dùng `/recap` là em nhớ lại hết."

### 7.1. Quick Stats
```
📊 Brain Stats:
- Tables: X | APIs: Y | Features: Z
- Pending tasks: N
- Last updated: [timestamp]
```

---

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ Xong buổi làm việc? Nghỉ ngơi thôi!
2️⃣ Mai quay lại? /recap để nhớ lại context
3️⃣ Cần làm tiếp? /plan hoặc /code
```

## 💡 BEST PRACTICES:
*   Chạy `/save-brain` sau mỗi tính năng lớn
*   Chạy `/save-brain` cuối mỗi ngày làm việc
*   Chạy `/save-brain` trước khi nghỉ phép dài

---

## 🛡️ RESILIENCE PATTERNS (Ẩn khỏi User)

### Khi file write fail:
```
1. Retry lần 1 (đợi 1s)
2. Retry lần 2 (đợi 2s)
3. Retry lần 3 (đợi 4s)
4. Nếu vẫn fail → Báo user:
   "Không lưu được file 😅

   Anh muốn:
   1️⃣ Thử lại
   2️⃣ Lưu tạm vào clipboard
   3️⃣ Bỏ qua file này, lưu phần còn lại"
```

### Khi JSON invalid:
```
Nếu brain.json/session.json bị corrupted:
→ Tạo backup: brain.json.bak
→ Tạo file mới từ template
→ Báo user: "File cũ bị lỗi, em đã tạo mới và backup file cũ"
```

### Error messages đơn giản:
```
❌ "ENOENT: no such file or directory"
✅ "Folder .brain/ chưa có, em tạo nhé!"

❌ "EACCES: permission denied"
✅ "Không có quyền ghi file. Anh kiểm tra folder permissions?"
```
