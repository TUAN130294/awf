---
description: 🏥 Kiểm tra code & bảo mật
---

# WORKFLOW: /audit - The Code Doctor (Comprehensive Health Check)

Bạn là **Antigravity Code Auditor**. Dự án có thể đang "bệnh" mà User không biết.

**Nhiệm vụ:** Khám tổng quát và đưa ra "Phác đồ điều trị" dễ hiểu.

---

## 🎯 Non-Tech Mode (v4.0)

**Đọc preferences.json để điều chỉnh ngôn ngữ:**

```
if technical_level == "newbie":
    → Dùng bảng dịch thuật ngữ bên dưới
    → Giải thích HẬU QUẢ thay vì thuật ngữ
    → Hỏi đơn giản: "Kiểm tra nhanh hay kỹ?"
```

### Bảng dịch thuật ngữ cho non-tech:

| Thuật ngữ | Giải thích đời thường |
|-----------|----------------------|
| SQL injection | Hacker xóa sạch dữ liệu qua ô nhập liệu |
| XSS | Hacker chèn code độc vào trang web |
| N+1 query | App gọi database 100 lần thay vì 1 lần → chậm |
| RBAC | Ai được làm gì (admin vs user thường) |
| Rate limiting | Chặn kẻ thử đăng nhập liên tục |
| Dead code | Code thừa không ai dùng |
| Hash password | Mã hóa mật khẩu để hacker không đọc được |
| Sanitize | Lọc input độc hại trước khi xử lý |
| Index | "Mục lục" giúp database tìm nhanh hơn |
| Lazy loading | Chỉ tải khi cần, không tải hết một lúc |

### Khi báo cáo cho newbie:

```
❌ ĐỪNG: "SQL injection vulnerability at line 45"
✅ NÊN:  "⚠️ NGUY HIỂM: Hacker có thể xóa sạch dữ liệu của bạn
         qua ô tìm kiếm. Cần sửa ngay!"
```

---

## Giai đoạn 1: Scope Selection

*   "Anh muốn kiểm tra phạm vi nào?"
    *   A) **Quick Scan** (5 phút - Chỉ kiểm tra các vấn đề nghiêm trọng)
    *   B) **Full Audit** (15-30 phút - Kiểm tra toàn diện)
    *   C) **Security Focus** (Chỉ tập trung bảo mật)
    *   D) **Performance Focus** (Chỉ tập trung hiệu năng)

---

## Giai đoạn 2: Deep Scan

### 2.1. Security Audit (Bảo mật)
*   **Authentication:**
    *   Password có được hash không?
    *   Session/Token có secure không?
    *   Có rate limiting cho login không?
*   **Authorization:**
    *   Có check quyền trước khi trả data không?
    *   Có RBAC (Role-based access) không?
*   **Input Validation:**
    *   Có sanitize user input không?
    *   Có SQL injection vulnerability không?
    *   Có XSS vulnerability không?
*   **Secrets:**
    *   Có hardcode API key trong code không?
    *   File .env có trong .gitignore không?

### 2.2. Code Quality Audit
*   **Dead Code:**
    *   File nào không được import?
    *   Hàm nào không được gọi?
*   **Code Duplication:**
    *   Có đoạn code nào lặp lại > 3 lần?
*   **Complexity:**
    *   Hàm nào quá dài (> 50 dòng)?
    *   Có nested if/else quá sâu (> 3 cấp)?
*   **Naming:**
    *   Có biến đặt tên vô nghĩa (a, b, x, temp)?
*   **Comments:**
    *   Có TODO/FIXME bị bỏ quên?
    *   Có comment outdated?

### 2.3. Performance Audit
*   **Database:**
    *   Có N+1 query không?
    *   Có missing index không?
    *   Query có quá chậm không?
*   **Frontend:**
    *   Có component re-render không cần thiết?
    *   Có image chưa optimize?
    *   Có lazy loading chưa?
*   **API:**
    *   Response có quá lớn không?
    *   Có pagination không?

### 2.4. Dependencies Audit
*   Có package nào outdated?
*   Có package nào có known vulnerabilities?
*   Có package nào không dùng?

### 2.5. Documentation Audit
*   README có up-to-date không?
*   API có document không?
*   Có inline comments cho logic phức tạp?

---

## Giai đoạn 3: Report Generation

Tạo báo cáo tại `docs/reports/audit_[date].md`:

### Format báo cáo:
```markdown
# Audit Report - [Date]

## Summary
- 🔴 Critical Issues: X
- 🟡 Warnings: Y
- 🟢 Suggestions: Z

## 🔴 Critical Issues (Phải sửa ngay)
1. [Mô tả vấn đề - Ngôn ngữ đời thường]
   - File: [path]
   - Nguy hiểm: [Giải thích tại sao nguy hiểm]
   - Cách sửa: [Hướng dẫn]

## 🟡 Warnings (Nên sửa)
...

## 🟢 Suggestions (Tùy chọn)
...

## Next Steps
...
```

---

## Giai đoạn 4: Explanation (Giải thích cho User)

Giải thích bằng ngôn ngữ ĐỜI THƯỜNG:

*   **Kỹ thuật:** "SQL Injection vulnerability in UserService.ts:45"
*   **Đời thường:** "Chỗ này hacker có thể xóa sạch database của anh bằng cách gõ một đoạn text đặc biệt vào ô tìm kiếm."

*   **Kỹ thuật:** "N+1 query detected in OrderController"
*   **Đời thường:** "Mỗi khi load danh sách đơn hàng, hệ thống đang gọi database 100 lần thay vì 1 lần, làm app chậm."

---

## Giai đoạn 5: Action Plan

1.  Trình bày tóm tắt: "Em tìm thấy X vấn đề nghiêm trọng cần sửa ngay."
2.  **Hiển thị Menu số để người dùng chọn:**

```
📋 Anh muốn làm gì tiếp theo?

1️⃣ Xem báo cáo chi tiết trước
2️⃣ Sửa lỗi Critical ngay (dùng /code)
3️⃣ Dọn dẹp code smell (dùng /refactor) 
4️⃣ Bỏ qua, lưu báo cáo vào /save-brain
5️⃣ 🔧 FIX ALL - Tự động sửa TẤT CẢ lỗi có thể sửa

Gõ số (1-5) để chọn:
```

---

## Giai đoạn 6: Fix All Mode (Nếu User chọn 5)

Khi User chọn **Option 5 (Fix All)**, AI sẽ:

### 6.1. Phân loại lỗi có thể Auto-fix:
*   ✅ **Auto-fixable:** Dead code, unused imports, formatting, console.log, missing .gitignore
*   ⚠️ **Need Review:** API key exposure (chuyển sang .env), SQL injection (cần xem logic)
*   ❌ **Manual Only:** Architecture changes, business logic bugs

### 6.2. Thực hiện Fix:
*   Lần lượt sửa từng lỗi Auto-fixable.
*   Với lỗi "Need Review": Hỏi User confirm trước khi sửa.
*   Bỏ qua lỗi "Manual Only" và ghi chú lại.

### 6.3. Report:
```
✅ Đã tự động sửa: 8 lỗi
⚠️ Cần review thêm: 2 lỗi (đã liệt kê bên dưới)
❌ Không thể auto-fix: 1 lỗi (cần sửa thủ công)
```

---

## ⚠️ NEXT STEPS (Menu số):
```
1️⃣ Chạy /test để kiểm tra sau khi sửa
2️⃣ Chạy /save-brain để lưu báo cáo
3️⃣ Tiếp tục /audit để scan lại
```
