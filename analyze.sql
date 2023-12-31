# CASE 1: We want to reward our users who have been around the longest.
# 			Find the 5 oldest users. 

SELECT * FROM users ORDER BY created_at LIMIT 5;


# CASE 2: what day of the week do most users regiser on?
# We need to figure out when to schedule an ad campain

SELECT DATE_FORMAT(created_at, '%W') AS day, COUNT(*) AS user_number
FROM users
GROUP BY day
ORDER BY user_number DESC
;



# CASE 3 We want to target our inactive users with an email campaign
#     Find ther users who have never posted a photo

SELECT DISTINCT id, username FROM users
WHERE id NOT IN
(
	SELECT DISTINCT user_id FROM photos
)
ORDER BY username
;



# Case 4: We're running a new contest to see who can get the most likes on a single photo.
# Who won?

SELECT 
    users.username,
    Likes.photo_id, 
    photos.image_url,
    COUNT(Likes.user_id) AS likes
FROM Likes
JOIN photos
ON Likes.photo_id = photos.id
JOIN users
ON users.id = photos.user_id
GROUP BY photo_id
ORDER BY likes DESC
LIMIT 1
;


# Case 5: Our Investors want to know...
# 		How many times does the average user post?

DESC photos;

SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 


# Case 6: A brand wants to know which hashtags to use in a post
#  What are the top 5 most commonly used hashtags?

SHOW TABLES;
DESC tags;
DESC photo_tags;

SELECT tag_id, tag_name, COUNT(*) total
FROM tags
JOIN photo_tags
ON tags.id = photo_tags.tag_id
GROUP BY tag_id
ORDER BY total DESC 
LIMIT 5
;


# Case 7: We have a small problem with bots on our site..
# Find users who have liked every single photo on the site

DESC likes;
DESC photos;
DESC users;

SELECT id, username FROM users
WHERE id IN 
(
SELECT likes.user_id
FROM likes, photos
GROUP BY likes.user_id
HAVING COUNT(DISTINCT photo_id) = COUNT(DISTINCT photos.id)
)
ORDER BY username
;








