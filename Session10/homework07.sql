use social_network_mini;

-- Tạo một view với tên view_user_activity_status hiển thị các cột:  user_id , username, gender, created_at, status. Trong đó status được xác định như sau: 
-- "Active" nếu người dùng có ít nhất 1 bài viết hoặc 1 bình luận.
-- "Inactive" nếu người dùng không có bài viết và không có bình luận.
create or replace view view_user_activity_status as 
select us.user_id , us.username, us.gender, us.created_at, 
case
        when count(distinct p.post_id) > 0 
		or count(distinct c.comment_id) > 0
        then 'Active'
        else 'Inactive'
    end as status from users us
left join posts p on us.user_id = p.user_id
left join comments c on us.user_id = c.user_id
group by us.user_id, us.username, us.gender, us.created_at;

-- Truy vấn view view_user_activity_status và kiểm tra kết quả thu được
select * from view_user_activity_status;

-- Truy vấn view view_user_activity_status để thống kê số lượng người dùng theo từng trạng thái (Active, Inactive).
-- Thông tin bao gồm: Tên trạng thái (status) và Số lượng người dùng (user_count), sắp xếp theo số lượng người dùng giảm dần
select status,count(user_id) as user_count
from view_user_activity_status
group by status
order by user_count DESC;