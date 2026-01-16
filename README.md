# 🚀 AWF - Antigravity Workflow Framework v3.0

**The Operating System for AI Engineers.**  
*Hệ điều hành dành cho Kỹ sư AI.*

*Turn your Antigravity Agent/Cursor into a Senior Engineer with disciplined workflows.*  
*Biến AI Agent thành Senior Engineer với quy trình làm việc kỷ luật thép.*

[![Website](https://img.shields.io/badge/Website-Live_Demo-cyan?style=for-the-badge)](https://awfweb.pages.dev/)
[![Install Global](https://img.shields.io/badge/Install-Global-blue?style=for-the-badge)](#-installation-global)

---

## 🛑 The Problem (Vấn đề)

**Have you ever experienced this with AI Coding?**  
*Bạn có từng gặp cảnh này khi code với AI?*

1.  **Memory Loss / Mất trí nhớ:**  
    AI forgets your database schema after 20 messages. It creates duplicate tables or conflicts.  
    *AI quên cấu trúc Database sau 20 tin nhắn. Tự ý tạo bảng trùng lặp.*
    
2.  **Lazy Coding / Code ẩu:**  
    AI gives "just works" code without `try-catch`, hard-coded API keys, and ignores edge cases.  
    *AI đưa code thiếu an toàn, hard-code API Key, bỏ qua các trường hợp lỗi.*

3.  **Loop Debugging / Vòng lặp Debug:**  
    Fixing bug A creates bug B. AI fixes blindly without finding the Root Cause.  
    *Sửa lỗi này đẻ ra lỗi khác. AI sửa mò mà không tìm nguyên nhân gốc rễ.*

👉 **You are treating AI as a "Junior Developer". You need to MANAGE it.**  
*Bạn đang dùng AI như thực tập sinh. Bạn cần phải QUẢN LÝ nó.*

---

## ✅ The Solution: AWF 3.0

**AWF is a suite of 14 Global Workflows that enforces "Iron Discipline".**  
*AWF là bộ 14 lệnh Global thiết lập "Kỷ luật thép" cho AI.*

*   **Plan First**: No coding allowed without a Spec (`/plan`).  
    *Cấm code khi chưa có kế hoạch.*
*   **Safety First**: Auto-check security before coding (`/code`).  
    *Tự động kiểm tra bảo mật.*
*   **Infinite Memory**: Save context to `.brain` file (`/save-brain`).  
    *Lưu ngữ cảnh vào file não bộ vĩnh cửu.*

---

## 📦 Installation (Global)

**Install once. Works on every project.**  
*Cài 1 lần. Dùng cho mọi dự án.*

### 🪟 Windows (PowerShell)
Open Terminal in Antigravity/Cursor (Ctrl + `) and paste:  
*Mở Terminal và dán lệnh sau:*

```powershell
iex "& { $(irm https://raw.githubusercontent.com/TUAN130294/awf/main/install.ps1) }"
```

### 🍎 Mac / Linux (Terminal)
```bash
curl -fsSL https://raw.githubusercontent.com/TUAN130294/awf/main/install.sh | sh
```

> **Restart your IDE after installation.**  
> *Khởi động lại Antigravity/Cursor sau khi cài.*

---

## 🎮 How to Use (Hướng dẫn)

**Follow this 3-step process:**  
*Tuân thủ quy trình 3 bước:*

### 1. Planning Phase (Lập kế hoạch)
*   **`/init`**:  
    **EN**: Setup new project structure & git.  
    **VI**: Khởi tạo dự án mới.
*   **`/recap`**:  
    **EN**: Start day. AI reads `.brain` to restore context.  
    **VI**: Đầu ngày làm việc. AI đọc `.brain` để nhớ lại ngữ cảnh.
*   **`/plan` (CRITICAL)**:  
    *Input:* `/plan Add Stripe Payment`  
    *Action:* Read DB & Docs -> Write `docs/specs/payment.md`.  
    *Benefit:* **Approve logic BEFORE coding.** (Duyệt logic trước khi code).

### 2. Construction Phase (Xây dựng)
*   **`/visualize`**:  
    **EN**: Designer Mode. Generate UI/Components.  
    **VI**: Tạo giao diện UI/UX.
*   **`/code` (CRITICAL)**:  
    *Input:* `/code Implement payment based on spec`  
    *Action:* Write Code + Unit Test + Security Check.  
    *Benefit:* **Clean & Safe Code.** (Code sạch và an toàn).

### 3. Operations Phase (Vận hành)
*   **`/debug`**: "Sherlock Holmes Mode". Find Root Cause.  
    *Tìm nguyên nhân gốc rễ.*
*   **`/audit`**: Health check & Security scan.  
    *Kiểm tra sức khỏe dự án.*
*   **`/deploy`**: Dockerize & Production setup.  
    *Đóng gói lên Production.*

### 4. Memory (Bộ nhớ)
*   **`/save-brain`**:  
    **EN**: Save comprehensive context to `.brain`.  
    **VI**: Lưu toàn bộ kiến thức vào file `.brain`.  
    *Tip: You can clear chat history after saving! (Có thể xoá chat sau khi lưu)*

---

## 📚 Command List (Danh sách lệnh)

| Command | Role | Description |
| :--- | :--- | :--- |
| **`/plan`** | Architect | Thiết kế tính năng / Design Feature |
| **`/code`** | Senior Dev | Viết code an toàn / Secure Coding |
| **`/visualize`** | Designer | Tạo UI/UX / Generate UI |
| **`/debug`** | Detective | Sửa lỗi sâu / Deep Debugging |
| **`/save-brain`** | Librarian | Lưu kiến thức / Save Context |
| **`/recap`** | Historian | Khôi phục kiến thức / Restore Context |
| **`/init`** | Founder | Khởi tạo dự án / Data Setup |
| **`/test`** | QA Engineer | Kiểm thử / Testing |
| **`/audit`** | Security | Kiểm tra bảo mật / Security Check |
| **`/deploy`** | DevOps | Deploy & Docker |
| **`/cloudflare-tunnel`** | Admin | Quản lý Tunnel |
| **`/awf-update`** | Updater | Kiểm tra & cập nhật AWF |

---

*Built by Antigravity in Vibe Coding Mode.*
