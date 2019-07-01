# 1.查询同时存在1课程和2课程的情况
SELECT
student_course.studentId
FROM
student_course
WHERE
student_course.courseId = 2 AND
student_course.studentId in (select studentId from student_course where courseId = 1)
# 2.查询同时存在1课程和2课程的情况
SELECT 
studentId
FROM
(SELECT
*
FROM
student_course
WHERE
student_course.courseId = 1 OR
student_course.courseId = 2) as student
GROUP BY student.studentId
HAVING count(courseId)=2
# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
SELECT
student_course.studentId,
student_course.courseId,
Avg(student_course.score)
FROM
student_course
GROUP BY
student_course.studentId
# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
SELECT
student.id,
student.`name`,
student.age,
student.sex
FROM
student
WHERE
student.id NOT IN
(SELECT DISTINCT
student_course.studentId
FROM
student_course)
# 5.查询所有有成绩的SQL
SELECT
student.id,
student.`name`,
student.age,
student.sex
FROM
student
WHERE
student.id IN
(SELECT DISTINCT
student_course.studentId
FROM
student_course)
# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
SELECT
student.id,
student.`name`,
student.age,
student.sex
FROM
student
WHERE
student.id in (SELECT
student_course.studentId
FROM
student_course
WHERE
student_course.courseId = 2 AND
student_course.studentId in (select studentId from student_course where courseId = 1))
# 7.检索1课程分数小于60，按分数降序排列的学生信息
SELECT
student_course.studentId,
student_course.courseId,
student_course.score,
student.`name`,
student.age,
student.sex
FROM
student_course ,
student
WHERE
student_course.score < 60 AND
student_course.courseId = 1 AND
student_course.studentId = student.id
ORDER BY
student_course.score ASC
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT
student_course.courseId,
Avg(student_course.score) AS avg_score
FROM
student_course
GROUP BY
student_course.courseId
ORDER BY
avg_score ASC
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT
student_course.score,
student.`name`
FROM
student_course ,
student
WHERE
student_course.courseId IN (SELECT
course.id
FROM
course
WHERE
course.`name` = "数学") AND
student_course.score < 60 AND
student_course.studentId = student.id

