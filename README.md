# 🚀 AWF - Antigravity Workflow Framework v3.3

**The Operating System for Vibe Coders & AI Engineers.**
*Hệ điều hành dành cho Vibe Coder và Kỹ sư AI.*

*Turn your ideas into apps without coding knowledge. AI handles everything.*
*Biến ý tưởng thành App mà không cần biết code. AI lo trọn gói.*

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

## ✅ The Solution: AWF 3.3

**AWF is a suite of 17 Global Workflows for everyone - from beginners to pros.**
*AWF là bộ 17 lệnh Global cho mọi người - từ người mới đến chuyên gia.*

### For Beginners (Dành cho người mới):
*   **Brainstorm First**: Discuss ideas, research market, clarify vision (`/brainstorm`).
    *Bàn ý tưởng, research thị trường, làm rõ tầm nhìn.*
*   **No Tech Knowledge Needed**: AI handles all technical decisions.
    *Không cần biết kỹ thuật. AI lo hết.*
*   **Step-by-Step Guidance**: `/next` tells you what to do next.
    *Hướng dẫn từng bước. `/next` cho biết làm gì tiếp.*

### For Professionals (Dành cho chuyên gia):
*   **Plan First**: No coding allowed without a Spec (`/plan`).
    *Cấm code khi chưa có kế hoạch.*
*   **Safety First**: Auto-check security before coding (`/code`).
    *Tự động kiểm tra bảo mật.*
*   **Infinite Memory**: Save context to `.brain/brain.json` (`/save-brain`).
    *Lưu ngữ cảnh vào file JSON có cấu trúc - AI parse nhanh, tiết kiệm token.*

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

### 🆕 For Beginners / Vibe Coders (Người mới bắt đầu)

**Just have an idea? Start here:**
*Chỉ có ý tưởng? Bắt đầu từ đây:*

```
/brainstorm → /init → /plan → /visualize → /code → /run → /deploy
```

*   **`/brainstorm`** (START HERE!):
    *Input:* "Em muốn làm app quản lý tiệm cà phê"
    *AI will:*
    - Ask questions to understand your idea / *Hỏi để hiểu ý tưởng*
    - Research competitors if needed / *Tìm hiểu đối thủ nếu cần*
    - Help prioritize features (MVP) / *Giúp chọn tính năng quan trọng*
    - Output: `BRIEF.md` - Clear summary of your app / *Tóm tắt rõ ràng*

*   **`/next`** (When stuck):
    *Don't know what to do next? Just type `/next`*
    *Không biết làm gì tiếp? Gõ `/next`*

---

### 💼 For Professionals (Dành cho chuyên gia)

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

### 🌟 Discovery & Start (Khám phá & Bắt đầu)
| Command | Role | Description |
| :--- | :--- | :--- |
| **`/brainstorm`** | Partner | 💡 Bàn ý tưởng, research thị trường / Discuss ideas, market research |
| **`/init`** | Founder | Khởi tạo dự án / Setup new project |
| **`/recap`** | Historian | Nhớ lại context / Restore context |
| **`/next`** | Navigator | Gợi ý bước tiếp theo / What to do next |

### 🎯 Design & Build (Thiết kế & Xây dựng)
| Command | Role | Description |
| :--- | :--- | :--- |
| **`/plan`** | Architect | Thiết kế tính năng / Design Feature |
| **`/visualize`** | Designer | Tạo UI/UX / Generate UI |
| **`/code`** | Senior Dev | Viết code an toàn / Secure Coding |

### ⚙️ Run & Test (Chạy & Kiểm tra)
| Command | Role | Description |
| :--- | :--- | :--- |
| **`/run`** | Operator | Chạy ứng dụng / Run App |
| **`/test`** | QA Engineer | Kiểm thử / Testing |
| **`/debug`** | Detective | Sửa lỗi sâu / Deep Debugging |

### 🚀 Deploy & Maintain (Triển khai & Bảo trì)
| Command | Role | Description |
| :--- | :--- | :--- |
| **`/deploy`** | DevOps | Deploy lên server |
| **`/audit`** | Security | Kiểm tra bảo mật / Security Check |
| **`/refactor`** | Clean Coder | Tối ưu code / Code Refactoring |
| **`/rollback`** | Time Traveler | Khôi phục code cũ / Revert Changes |

### 💾 Memory & Utils (Bộ nhớ & Tiện ích)
| Command | Role | Description |
| :--- | :--- | :--- |
| **`/save-brain`** | Librarian | Lưu kiến thức / Save Context |
| **`/cloudflare-tunnel`** | Admin | Quản lý Tunnel |
| **`/awf-update`** | Updater | Kiểm tra & cập nhật AWF |

---

## 💡 Why /brainstorm? (Tại sao cần /brainstorm?)

**The #1 problem with Vibe Coding:**
*Vấn đề lớn nhất của Vibe Coding:*

> "I have an idea but I don't know where to start"
> *"Em có ý tưởng nhưng không biết bắt đầu từ đâu"*

### /brainstorm solves this by:

| Problem | Solution |
| :--- | :--- |
| Vague idea | AI asks questions to clarify / *AI hỏi để làm rõ* |
| Don't know competitors | AI researches market for you / *AI tìm hiểu thị trường* |
| Too many features | AI helps prioritize MVP / *AI giúp chọn tính năng quan trọng* |
| Technical confusion | AI explains in simple terms / *AI giải thích đơn giản* |

### Example conversation:

```
You: /brainstorm
You: Em muốn làm app quản lý tiệm cà phê

AI: "App giải quyết vấn đề gì cho anh?"
You: Quản lý order, nhân viên, doanh thu

AI: "Có muốn em tìm xem thị trường có app tương tự không?"
You: Có

AI: [Researches and shows competitors]
AI: "App của anh sẽ khác họ ở điểm nào?"
...

AI: "Em tổng hợp lại:
    - MVP: Order + Menu + Doanh thu cơ bản
    - Phase 2: Quản lý nhân viên, inventory

    Lưu vào BRIEF.md. Gõ /plan để tiếp tục!"
```

---

## 📖 Documentation

- [User Guide (Hướng dẫn chi tiết)](docs/USER_GUIDE.md)
- [Interactive Visualization](docs/visualization/index.html)

---

*Built by Antigravity in Vibe Coding Mode.*
*AWF v3.3 - For everyone, from beginners to pros.*
