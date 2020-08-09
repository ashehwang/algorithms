SELECT
  employees.*
FROM
  employees e
JOIN
  departments d ON e.department_id = d.id
WHERE
  d.name = ?




SELECT
    COUNT(*)
FROM
    users; 

    -- User.count

SELECT
    COUNT(*)
FROM
    users
WHERE
  users.active = true;

    -- User.where(:active => "TRUE").count


SELECT
    COUNT(*)
FROM
    users
WHERE
  users.last_login BETWEEN :time_period_start AND :time_period_end ;

    --User.where(last_login:(time_period_start..time_period_end)).count