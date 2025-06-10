SELECT id, username, created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;
SELECT u.id, u.username, u.created_at
FROM users u
LEFT JOIN photos p ON u.id = p.user_id
WHERE p.id IS NULL;
SELECT u.id AS user_id, u.username, p.id AS photo_id, p.image_url
FROM photos p
JOIN users u ON p.user_id = u.id
WHERE p.id = (  
    SELECT photo_id  
    FROM likes  
    GROUP BY photo_id  
    ORDER BY COUNT(*) DESC  
    LIMIT 1  
);
SELECT t.tag_name, COUNT(pt.tag_id) AS tag_usage
FROM photo_tags pt
JOIN tags t ON pt.tag_id = t.id
GROUP BY t.tag_name
ORDER BY tag_usage DESC
LIMIT 5;
SELECT DAYNAME(created_at) AS registration_day, COUNT(*) AS user_count
FROM users
GROUP BY registration_day
ORDER BY user_count DESC
LIMIT 1;
SELECT 
    (COUNT(p.id) / COUNT(DISTINCT u.id)) AS avg_posts_per_user,
    COUNT(p.id) AS total_photos,
    COUNT(DISTINCT u.id) AS total_users
FROM users u
LEFT JOIN photos p ON u.id = p.user_id;
SELECT l.user_id, u.username, COUNT(l.photo_id) AS total_likes
FROM likes l
JOIN users u ON l.user_id = u.id
GROUP BY l.user_id, u.username
HAVING total_likes = (SELECT COUNT(id) FROM photos);
