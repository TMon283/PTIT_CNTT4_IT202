CREATE DATABASE Mini_Social_Network;
USE Mini_Social_Network;

CREATE TABLE Users(
	user_id int primary key auto_increment,
    username varchar(50) unique not null,
    password varchar(255) not null,
    email varchar(100) unique not null,
    created_at datetime default current_timestamp
);

CREATE TABLE Posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references Users(user_id) on delete cascade
);

CREATE TABLE Comments(
	comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
	foreign key (user_id) references Users(user_id) on delete cascade,
    foreign key (post_id) references Posts(post_id) on delete cascade
);

CREATE TABLE Friends(
	user_id int not null,
    friend_id int not null,
    status varchar(20) not null check(status IN ('pending', 'accepted')),
	created_at datetime default current_timestamp,
	primary key (user_id, friend_id),
    foreign key (user_id) references Users(user_id) on delete cascade,
	foreign key (friend_id) references Users(user_id) on delete cascade
);

CREATE TABLE Likes(
	like_id int primary key auto_increment,
    user_id int not null,
    post_id int not null,
	created_at datetime default current_timestamp,
	unique key(post_id, user_id),
	foreign key (user_id) references Users(user_id) on delete cascade,
    foreign key (post_id) references Posts(post_id) on delete cascade
);
