---
name: awf-error-translator
description: >-
  Translate technical errors to human-friendly language. Keywords: error,
  translate, explain, help, fix, fail, broken, crash, bug.
  Activates on /debug, /code, /test when errors detected.
version: 1.0.0
---

# AWF Error Translator

Dịch lỗi kỹ thuật sang ngôn ngữ đời thường cho non-tech users.

## Trigger Conditions

**Post-hook for:** `/debug`, `/code`, `/test`

**When:** Error message detected in output

## Execution Logic

### Step 1: Detect Error

```
if output contains error patterns:
    → Activate translation
else:
    → Skip (no error)
```

### Step 2: Match & Translate

Match error against database, return human message + action.

### Step 3: Display

```
❌ Lỗi: [human message]
💡 Gợi ý: [action]
```

## Error Translation Database

### Database Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `ECONNREFUSED` | Database chưa chạy | Khởi động PostgreSQL/MySQL |
| `ETIMEDOUT` | Database phản hồi chậm quá | Kiểm tra kết nối mạng |
| `ER_ACCESS_DENIED` | Sai mật khẩu database | Kiểm tra file .env |
| `relation .* does not exist` | Bảng chưa tồn tại | Chạy migration: `/run migrate` |
| `duplicate key` | Dữ liệu bị trùng | Kiểm tra unique constraint |

### JavaScript/TypeScript Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `TypeError: Cannot read` | Đang đọc biến chưa có giá trị | Kiểm tra null/undefined |
| `ReferenceError` | Dùng biến chưa khai báo | Kiểm tra tên biến |
| `SyntaxError` | Code viết sai cú pháp | Kiểm tra dấu ngoặc, chấm phẩy |
| `Maximum call stack` | Vòng lặp vô hạn | Kiểm tra điều kiện dừng |
| `Cannot find module` | Thiếu package | Chạy `npm install` |

### Network Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `fetch failed` | Không kết nối được server | Kiểm tra URL và internet |
| `CORS` | Website chặn request | Cấu hình CORS trên server |
| `ERR_CERT` | Chứng chỉ SSL lỗi | Dùng HTTP thay HTTPS (dev only) |
| `timeout` | Request quá lâu | Tăng timeout hoặc kiểm tra server |
| `ENOTFOUND` | Domain không tồn tại | Kiểm tra lại URL |

### Package Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `npm ERR!` | Cài package bị lỗi | Xóa node_modules, cài lại |
| `peer dep` | Phiên bản không tương thích | Cập nhật package.json |
| `EACCES` | Không có quyền truy cập | Chạy với sudo hoặc sửa quyền |
| `ENOSPC` | Hết dung lượng ổ đĩa | Dọn dẹp disk |
| `gyp ERR!` | Lỗi build native module | Cài build tools |

### Test Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `Expected .* but received` | Test thất bại - kết quả sai | Sửa code hoặc update test |
| `Timeout` | Test chạy quá lâu | Tăng timeout hoặc optimize |
| `before each hook` | Setup test bị lỗi | Kiểm tra beforeEach |
| `snapshot` | UI thay đổi | Update snapshot nếu đúng |
| `coverage` | Thiếu test coverage | Viết thêm test |

### Build Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `tsc.*error` | Lỗi TypeScript | Sửa type errors |
| `ESLint` | Code không đúng style | Chạy lint fix |
| `Build failed` | Build thất bại | Đọc log chi tiết |
| `Out of memory` | Hết RAM | Tăng memory limit |
| `FATAL ERROR` | Lỗi nghiêm trọng | Restart và thử lại |

### Git Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `conflict` | Code bị xung đột | Merge conflict manually |
| `rejected` | Push bị từ chối | Pull trước khi push |
| `detached HEAD` | Không ở branch nào | Checkout về branch |
| `not a git repo` | Chưa init git | Chạy `git init` |

### Deploy Errors

| Pattern | Human Message | Action |
|---------|---------------|--------|
| `502 Bad Gateway` | Server không phản hồi | Restart server |
| `503 Service` | Server quá tải | Scale up resources |
| `permission denied` | Không có quyền deploy | Kiểm tra credentials |
| `quota exceeded` | Hết quota | Nâng cấp plan |

## Output Format

```
🔍 Translating error...

❌ Lỗi: [human_message]
   └─ Gốc: [original_error_snippet]

💡 Gợi ý: [action]
   └─ Hoặc chạy: /debug để tìm hiểu thêm

────────────────────────────────
```

## Fallback

If no pattern matches:
```
❌ Lỗi: Có vấn đề xảy ra
💡 Gợi ý: Chạy /debug để em phân tích chi tiết
```

## Performance

- Translation: < 100ms
- Pattern matching: Simple regex
- No external API calls

## Security

- Sanitize error messages (remove credentials, paths)
- Never expose sensitive info in translations
