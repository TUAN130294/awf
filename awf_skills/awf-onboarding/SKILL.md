---
name: awf-onboarding
description: >-
  First-time user wizard for AWF setup. Keywords: first time, new user,
  setup, getting started, tutorial, beginner, how to start.
  Activates on /init when no .brain/ folder exists.
version: 1.0.0
---

# AWF Onboarding

Hướng dẫn người dùng mới trong 3 bước đơn giản.

## Trigger Conditions

**Activates when:**
- User runs `/init` AND no `.brain/` folder exists
- User says "getting started", "làm sao bắt đầu", "hướng dẫn"
- First interaction detected (no session history)

## Onboarding Flow (3 Steps)

### Step 1: Welcome & Assess

```
🎉 Chào mừng bạn đến với AWF!

Em là trợ lý AI giúp bạn xây dựng ứng dụng.
Trước tiên, cho em biết bạn thuộc nhóm nào:

1️⃣ Mới hoàn toàn - Chưa biết code, chỉ có ý tưởng
2️⃣ Biết cơ bản - Đã dùng máy tính, biết chút code
3️⃣ Developer - Đã code nhiều, muốn nhanh gọn

Chọn số (1/2/3):
```

**On selection:**
- 1 → Set `technical_level: newbie`
- 2 → Set `technical_level: basic`
- 3 → Set `technical_level: technical`

### Step 2: Project Setup

```
📂 Bước 2: Về dự án của bạn

Bạn muốn làm gì?

1️⃣ Tạo dự án mới từ đầu
2️⃣ Tiếp tục dự án có sẵn
3️⃣ Chỉ hỏi đáp, chưa có dự án

Chọn số (1/2/3):
```

**On selection:**
- 1 → Run `/init` workflow
- 2 → Run `/recap` workflow
- 3 → Show command cheatsheet

### Step 3: Quick Tutorial

```
🎓 Bước 3: Hướng dẫn nhanh

Bạn chỉ cần nhớ 5 lệnh chính:

┌─────────────────────────────────────┐
│ /brainstorm  │ Bàn ý tưởng         │
│ /plan        │ Lập kế hoạch        │
│ /code        │ Viết code           │
│ /debug       │ Sửa lỗi             │
│ /deploy      │ Đưa lên mạng        │
└─────────────────────────────────────┘

💡 Mẹo: Gõ /next bất cứ lúc nào để em gợi ý bước tiếp theo!

✅ Sẵn sàng chưa? Bắt đầu với /brainstorm hoặc /plan nhé!
```

## Preferences Setup

After Step 1, create `.brain/preferences.json`:

```json
{
  "updated_at": "[timestamp]",
  "technical": {
    "technical_level": "[selected_level]",
    "detail_level": "simple",
    "autonomy": "ask_often"
  },
  "communication": {
    "tone": "friendly",
    "persona": "mentor"
  }
}
```

## Cheatsheet (for Step 3 option 3)

```
📋 AWF Quick Reference

🚀 BẮT ĐẦU:
   /brainstorm  - Có ý tưởng? Bàn với em
   /plan        - Vạch kế hoạch chi tiết
   /init        - Khởi tạo dự án mới

💻 XÂY DỰNG:
   /code        - Viết code theo plan
   /visualize   - Thiết kế giao diện
   /test        - Kiểm tra hoạt động

🔧 SỬA LỖI:
   /debug       - Tìm và sửa lỗi
   /refactor    - Cải thiện code

🚀 TRIỂN KHAI:
   /deploy      - Đưa lên production
   /rollback    - Quay về bản trước

📝 QUẢN LÝ:
   /recap       - Nhớ lại đang làm gì
   /save-brain  - Lưu kiến thức dự án
   /next        - Gợi ý bước tiếp theo

❓ Bất cứ lúc nào: Gõ /help hoặc hỏi "giúp em"
```

## Skip Onboarding

If `.brain/` already exists OR user is returning:
```
if exists(".brain/preferences.json"):
    → Skip onboarding
    → Run normal /init workflow
```

## Success Criteria

- Onboarding completes in < 2 minutes
- User understands 5 core commands
- Preferences file created
- User feels confident to start

## Error Handling

```
If user input invalid:
→ "Em không hiểu. Chọn số 1, 2, hoặc 3 nhé!"

If file creation fails:
→ Continue without preferences
→ Use defaults (basic level)
```
