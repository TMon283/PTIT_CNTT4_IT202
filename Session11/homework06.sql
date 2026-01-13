use social_network_pro;

-- Viết stored procedure tên NotifyFriendsOnNewPost nhận hai tham số IN:
-- p_user_id (INT) – ID của người đăng bài
-- p_content (TEXT) – Nội dung bài viết
-- Procedure sẽ thực hiện hai việc:
-- Thêm một bài viết mới vào bảng posts với user_id và content được truyền vào.
-- Tự động gửi thông báo loại 'new_post' vào bảng notifications cho tất cả bạn bè đã accepted (cả hai chiều trong bảng friends).
-- Nội dung thông báo: “[full_name của người đăng] đã đăng một bài viết mới”.
-- Không gửi thông báo cho chính người đăng bài.

DELIMITER $$ 
create procedure NotifyFriendsOnNewPost(in p_user_id int,in p_content text)
begin 
	declare v_post_id int;
    declare v_full_name varchar(255);
    declare v_friend_id int;
    declare done int default 0;
    -- Cursor lấy danh sách bạn bè accepted (2 chiều)
    declare friend_cursor cursor for
        select
            case
                when user_id = p_user_id then friend_id
                else user_id
            end as friend_id
        from friends
        where status = 'accepted'
          and (user_id = p_user_id or friend_id = p_user_id);

    declare continue handler for not found set done = 1;

    -- Kiểm tra user có tồn tại hay không
    if not exists (select 1 from users where user_id = p_user_id) then
        signal sqlstate '45000'
        set message_text = 'User không tồn tại';
    end if;

    -- Lấy full_name của người đăng
    select full_name into v_full_name from users
    where user_id = p_user_id;

    -- Thêm bài viết mới
    insert into posts(user_id, content, created_at) values (p_user_id, p_content, NOW());

    set v_post_id = LAST_INSERT_ID();

    -- Duyệt danh sách bạn bè
    open friend_cursor;

    read_loop: loop
        fetch friend_cursor into v_friend_id;

        if done = 1 then
            leave read_loop;
        end if;

        -- Không gửi cho chính mình
        if v_friend_id <> p_user_id then
            insert into notifications(user_id, type, content, created_at)
            values (
                v_friend_id,
                'new_post',
                CONCAT(v_full_name, ' đã đăng một bài viết mới'),
                NOW()
            );
        end if;

    end loop;

    close friend_cursor;

    -- Trả kết quả để dễ kiểm tra
   select 
        v_post_id as new_post_id,
        'Đăng bài và gửi thông báo thành công' as message;

end $$
DELIMITER $$ ;

-- Gọi procedue trên và thêm bài viết mới 
call NotifyFriendsOnNewPost(1,'Hôm nay tôi vừa học xong Stored Procedure với Cursor');

-- Select ra những thông báo của bài viết vừa đăng
select n.notification_id,
       n.user_id,
       n.type,
       n.content,
       n.created_at
from notifications n
where n.type = 'new_post'
order by n.created_at desc;

-- Xóa thủ tục vừa khởi tạo trên
drop procedure NotifyFriendsOnNewPost;