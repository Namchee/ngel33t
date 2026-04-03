SELECT
    st.student_id,
    st.student_name,
    su.subject_name,
    COUNT(e.student_id) AS attended_exams
FROM
    Students st CROSS JOIN Subjects su
    LEFT JOIN Examinations e ON
    su.subject_name = e.subject_name AND st.student_id = e.student_id
GROUP BY
    st.student_id,
    su.subject_name
ORDER BY
    st.student_id,
    su.subject_name
