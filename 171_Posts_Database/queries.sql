--Show the user/users with the most publications

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

--Select posts which were created at the same date as today, but at other years.

select id, title from post
where extract(day from created_at) = '12' and extract(month from created_at) = '01' and extract(year from created_at) !=  extract(year from current_date)
order by created_at

--Set publication date with interval 1 month after post creation.

UPDATE public.post
	SET published_at=created_at + interval '1 month'
	WHERE published_at is null;









