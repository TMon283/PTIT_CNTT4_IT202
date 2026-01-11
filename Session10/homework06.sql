use social_network_mini;

-- Tạo một view tên view_users_summary để thống kê số lượng bài viết của từng người dùng.user_id (Mã người dùng), username (Tên người dùng), 
-- total_posts (Tổng số lượng bài viết của người dùng)
create or replace view view_users_summary as 
select us.user_id, us.username,count(p.post_id) as total_posts from users us
left join posts p on us.user_id = p.user_id
group by us.user_id, us.username;

--  Truy vấn từ view_users_summary để hiển thị các thông tin về user_id, username và total_posts của các người dùng có total_posts lớn hơn 5
select user_id, username,total_posts from view_users_summary
where total_posts > 5;