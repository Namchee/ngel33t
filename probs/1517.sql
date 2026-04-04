SELECT
    user_id,
    name,
    mail
FROM
    Users
WHERE
    REGEXP_LIKE(mail, '(?-i)^[a-zA-Z][0-9a-zA-Z_.\-]*@leetcode\\.com$')
