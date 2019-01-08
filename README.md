# Library--Management-1901

Members: Lê Quang Tây B

Redmine: https://edu-redmine.framgia.vn/projects/library-management-1901

Redmine flow
1. Tất cả công việc cần làm (Bug/Task/Feature/Support) phải được tạo ticket trước rồi mới thực hiện. Lưu ý ticket cần có description rõ ràng.

2. Trainee update ticket
- Update đầy đủ thông tin Start date, Due date, Estimated time, 
- Chuyển trạng thái sang "In Progress"
- Assign cho chính mình.

3.  Trainee làm xong tạo pull request
- Comment link pull request đó vào ticket
- Chuyển % Done thành 90 %
- Update Spent time 
- Chuyển trạng thái ticket sang Reviewing

4. Trainee gửi pull cho trainer để review
- Nếu pull được merged thì chuyển tới bước 5
- Nếu pull có comment cần sửa thì quay lại bước 2
5. Sau khi pull được merged
 - Trainee update % Done của ticket thành 100 %, chuyển status thành Resolved.
6. Trainee thực hiện test lại task của mình
 - Nếu test pass, chuyển status của task thành close.
 - Nếu test fail, quay lại bước 2
