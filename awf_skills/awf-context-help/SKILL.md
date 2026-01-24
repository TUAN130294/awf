---
name: awf-context-help
description: >-
  Context-aware help based on current workflow state. Keywords: help, what,
  how, confused, stuck, lost, guide, tutorial, explain.
  Activates on /help or when user asks questions.
version: 1.0.0
---

# AWF Context Help

Trợ giúp thông minh dựa trên context hiện tại.

## Trigger Conditions

**Activates when:**
- User runs `/help`
- User types "?", "giúp", "help", "làm sao"
- User seems confused (repeated errors, long pause)

## Execution Logic

### Step 1: Read Context

```
context = {}

if exists(".brain/session.json"):
    context.workflow = session.working_on.feature
    context.task = session.working_on.task
    context.status = session.working_on.status
    context.pending = session.pending_tasks

if exists(".brain/brain.json"):
    context.project = brain.project.name
    context.tech = brain.tech_stack
```

### Step 2: Detect State

| State | Detection | Response |
|-------|-----------|----------|
| `no_project` | No .brain/ folder | Show onboarding |
| `planning` | workflow contains "plan" | Planning help |
| `coding` | workflow contains "code" | Coding help |
| `debugging` | workflow contains "debug" | Debug help |
| `deploying` | workflow contains "deploy" | Deploy help |
| `stuck` | status = "blocked" or pending > 5 | Stuck help |
| `idle` | No active workflow | General help |

### Step 3: Show Contextual Help

## Help Templates

### No Project State
```
🆕 Chưa có dự án

Bạn có thể:
1. /brainstorm - Bàn ý tưởng trước
2. /init - Tạo dự án mới
3. Mô tả ý tưởng cho em nghe

Em sẽ hướng dẫn từng bước!
```

### Planning State
```
📋 Đang lập kế hoạch: {context.workflow}

Bạn có thể:
1. Tiếp tục plan hiện tại
2. /code - Bắt đầu code phase đầu tiên
3. Hỏi em về cách thiết kế

💡 Mẹo: Plan tốt = Code nhanh hơn!
```

### Coding State
```
💻 Đang code: {context.task}
   Status: {context.status}

Bạn có thể:
1. Tiếp tục code
2. /test - Kiểm tra code vừa viết
3. /debug - Nếu gặp lỗi
4. /save-brain - Lưu tiến độ

💡 Pending tasks: {context.pending.length}
```

### Debugging State
```
🔧 Đang debug: {context.task}

Bạn có thể:
1. Mô tả lỗi chi tiết hơn
2. Paste error message
3. /code - Quay lại code sau khi fix

💡 Mẹo: Copy paste lỗi giúp em hiểu nhanh hơn!
```

### Deploying State
```
🚀 Đang deploy: {context.workflow}

Bạn có thể:
1. Tiếp tục deploy process
2. /rollback - Quay về bản trước nếu lỗi
3. Kiểm tra logs sau deploy

⚠️ Nhớ test kỹ trước khi deploy production!
```

### Stuck State
```
😅 Có vẻ bạn đang bị kẹt

Thử những cách này:
1. /recap - Xem lại đang làm gì
2. /debug - Nếu có lỗi
3. Nghỉ 5 phút rồi quay lại
4. Hỏi em cụ thể vấn đề

💡 {context.pending.length} tasks đang chờ.
   Có thể tạm skip task khó, làm cái khác trước?
```

### Idle/General State
```
👋 Em có thể giúp gì?

Lệnh phổ biến:
┌─────────────────────────────────────┐
│ /next       │ Gợi ý việc tiếp theo  │
│ /recap      │ Nhớ lại context       │
│ /brainstorm │ Bàn ý tưởng mới       │
│ /plan       │ Lập kế hoạch          │
│ /code       │ Viết code             │
└─────────────────────────────────────┘

Hoặc hỏi em bất cứ điều gì!
```

## Adaptive Language

Help responses adapt to `technical_level`:

**newbie:**
- Dùng tiếng Việt thuần
- Giải thích mọi khái niệm
- Bước nhỏ, chi tiết

**basic:**
- Mix Việt-Anh
- Giải thích term lần đầu
- Bước vừa phải

**technical:**
- Dùng thuật ngữ chuẩn
- Không cần giải thích
- Tập trung action

## Fallback

If context unreadable:
```
👋 Em ở đây giúp bạn!

Gõ /next để em gợi ý việc cần làm,
hoặc mô tả vấn đề cho em nghe.
```

## Performance

- Context read: < 200ms
- Response generation: Instant
- No external API calls
