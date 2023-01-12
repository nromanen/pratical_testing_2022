--Вивести користувача з найбільшою кількістю публікацій

select username, count(username) as count_number
from "user" join post on "user".id = post.user_id
Group by username
having count(username)=(select count(title)
from post
group by user_id
order by count(title) desc
limit 1)

--Delete users which didn't have any comments under posts
delete from public."user"
where id not in (select user_id
from post_user
where comment is NOT NULL)









