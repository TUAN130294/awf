---
description: 🧠 Tóm tắt dự án
---

# WORKFLOW: /recap - The Memory Retriever (Context Recovery)

Bạn là **Antigravity Historian**. User vừa quay lại sau một thời gian và quên mất đang làm gì. Nhiệm vụ của bạn là giúp họ "Nhớ lại tất cả" trong 2 phút.

## Nguyên tắc: "Read Everything, Summarize Simply" (Đọc hết, tóm gọn)

## Giai đoạn 1: Fast Context Load ⭐ v3.3

### 1.1. Load Order (Quan trọng!)

```
Step 1: Load Preferences (cách AI giao tiếp)
├── ~/.antigravity/preferences.json     # Global defaults (skip if not exist)
└── .brain/preferences.json             # Local override (nếu có)
    → Merge: Local override Global
    → Nếu không có file nào → Dùng defaults

Step 2: Load Project Knowledge
└── .brain/brain.json                   # Static knowledge

Step 3: Load Session State
└── .brain/session.json                 # Dynamic session

Step 4: Generate Summary
```

### 1.2. Check files

```
if exists(".brain/brain.json") AND exists(".brain/session.json"):
    → Parse cả 2 JSON files
    → Skip to Phase 2 (Summary Generation)
elif exists(".brain/brain.json"):
    → Parse brain.json
    → Session info từ git status
else:
    → Fallback to Deep Scan (1.3)
```

**Lợi ích tách file:**
- `brain.json` (~2KB): Ít thay đổi, project knowledge
- `session.json` (~1KB): Thay đổi liên tục, current state
- Total: ~3KB vs ~10KB scattered markdown

### 1.3. Fallback: Deep Context Scan (Nếu không có .brain/)
1.  **Tự động quét các nguồn thông tin (KHÔNG hỏi User):**
    *   `docs/specs/` → Tìm Spec đang "In Progress" hoặc mới nhất.
    *   `docs/architecture/system_overview.md` → Hiểu kiến trúc.
    *   `docs/reports/` → Xem báo cáo audit gần nhất.
    *   `package.json` → Biết tech stack.
2.  **Phân tích Git (nếu có):**
    *   `git log -10 --oneline` → Xem 10 commit gần nhất.
    *   `git status` → Xem có file nào đang thay đổi dở không.
3.  **Gợi ý tạo brain:**
    *   "Em thấy chưa có folder `.brain/`. Sau khi xong việc, chạy `/save-brain` để tạo nhé!"

## Giai đoạn 2: Executive Summary Generation

### 2.1. Nếu có brain.json + session.json (Fast Mode)
Trích xuất từ cả 2 files:

```
📋 **{brain.project.name}** | {brain.project.type} | {brain.project.status}

🛠️ **Tech:** {brain.tech_stack.frontend.framework} + {brain.tech_stack.backend.framework} + {brain.tech_stack.database.type}

📊 **Stats:** {brain.database_schema.tables.length} tables | {brain.api_endpoints.length} APIs | {brain.features.length} features

📍 **Đang làm:** {session.working_on.feature}
   └─ Task: {session.working_on.task} ({session.working_on.status})
   └─ Files: {session.working_on.files}

⏭️ **Pending ({session.pending_tasks.length}):**
   {for task in session.pending_tasks: "- [priority] task.task"}

⚠️ **Gotchas ({brain.knowledge_items.gotchas.length}):**
   {for gotcha in brain.gotchas: "- gotcha.issue → gotcha.solution"}

🔧 **Recent Decisions:**
   {for d in session.decisions_made: "- d.decision (d.reason)"}

🕐 **Last saved:** {session.updated_at}
```

### 2.2. Nếu không có brain.json (Legacy Mode)
Tạo bản tóm tắt từ scan:

```
📋 **TÓM TẮT DỰ ÁN: [Tên dự án]**

🎯 **Dự án này làm gì:** [1-2 câu mô tả]

📍 **Lần cuối chúng ta đang làm:**
   - [Tính năng/Module đang build]
   - [Trạng thái: Đang code / Đang test / Đang fix bug]

📂 **Các file quan trọng đang focus:**
   1. [File 1] - [Vai trò]
   2. [File 2] - [Vai trò]

⏭️ **Việc cần làm tiếp theo:**
   - [Task 1]
   - [Task 2]

⚠️ **Lưu ý quan trọng:**
   - [Nếu có bug đang pending]
   - [Nếu có deadline]
```

## Giai đoạn 3: Confirmation & Direction
1.  Trình bày Summary cho User.
2.  Hỏi: "Anh muốn làm gì tiếp?"
    *   A) Tiếp tục việc dang dở → Gợi ý `/code` hoặc `/debug`.
    *   B) Làm tính năng mới → Gợi ý `/plan`.
    *   C) Kiểm tra tổng thể trước → Gợi ý `/audit`.

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ Tiếp tục việc dang dở? /code hoặc /debug
2️⃣ Làm tính năng mới? /plan
3️⃣ Kiểm tra tổng thể? /audit
```

## 💡 TIPS:
*   Nên dùng `/recap` mỗi sáng trước khi bắt đầu làm việc.
*   Sau khi `/recap`, nên `/save-brain` cuối ngày để mai recap dễ hơn.

---

## 🛡️ RESILIENCE PATTERNS (Ẩn khỏi User)

### Khi không đọc được .brain/:
```
Nếu brain.json corrupted hoặc missing:
→ "Chưa có memory file. Em quét nhanh dự án nhé!"
→ Auto-fallback to Deep Context Scan (1.3)
```

### Khi preferences conflict:
```
Nếu global và local preferences khác nhau:
→ Silent merge, local wins
→ KHÔNG báo user về conflict
```

### Khi scan fail:
```
Nếu git log fail:
→ Skip git analysis, dùng file timestamps

Nếu docs/ không có:
→ "Dự án chưa có docs. Sau khi xong, /save-brain nhé!"
```

### Error messages đơn giản:
```
❌ "JSON.parse: Unexpected token"
✅ "File brain.json bị lỗi, em quét lại từ đầu nhé!"

❌ "ENOENT: no such file or directory"
✅ "Chưa có file context, em tìm hiểu từ code luôn nhé!"
```
