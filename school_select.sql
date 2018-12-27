show tables;
SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM course;
SELECT * FROM score;

-- 1、查询"1"课程比"2"课程成绩高的学生的信息及课程分数 
-- 2、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
-- 3、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩
-- 4、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
-- 5、查询学过"张三"老师授课的同学的信息 
-- 6、查询没学过"张三"老师授课的同学的信息
-- 7、查询和"01"号的同学学习的课程完全相同的其他同学的信息
-- 8、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
-- 9.查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率。及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
-- 10、按各科成绩进行排序，并显示排名
-- 11、查询学生的总成绩并进行排名
-- 12、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩(考虑并列情况)
-- 13、查询各学生的年龄
-- 14、查询本周过生日的学生
-- 15、查询下周过生日的学生
-- 16、查询本月过生日的学生
-- 17、查询下月过生日的学生



-- 1、查询"1"课程比"2"课程成绩高的学生的信息及课程分数 
/*
1、涉及的表有student，score
2、关系 student.s_id=score.s_id
*/
SELECT * FROM student s1 LEFT JOIN score g1 ON s1.s_id=g1.s_id AND g1.c_id=1 LEFT JOIN score g2 ON s1.s_id=g2.s_id AND g2.c_id=2 WHERE g1.s_score > g2.s_score;


-- 2、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
/*
1、涉及的表有student，score
2、关系 student.s_id=score.s_id
*/
SELECT s1.s_id,s1.s_name,ROUND(AVG(g1.s_score),2) FROM score g1 RIGHT JOIN student s1 ON g1.s_id=s1.s_id GROUP BY s1.s_id HAVING ROUND(AVG(g1.s_score),2)>60;


-- 3、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩
        -- (包括有成绩的和无成绩的)
/*
1、涉及的表有student，score
2、关系 student.s_id=score.s_id
*/
-- 方法1：mysql的特有函数 ifnull
SELECT s1.s_id,s1.s_name,IFNULL(ROUND(AVG(g1.s_score),2),0.00) avg FROM score g1 RIGHT JOIN student s1 ON g1.s_id=s1.s_id GROUP BY s1.s_id HAVING IFNULL(ROUND(AVG(g1.s_score),2),0.00)<60;
-- 方法2：不用 mysql的特有函数 ifnull
SELECT s1.s_id,s1.s_name,ROUND(AVG(g1.s_score),2) avg FROM score g1 RIGHT JOIN student s1 ON g1.s_id=s1.s_id GROUP BY s1.s_id HAVING ROUND(AVG(g1.s_score),2)<60
UNION
SELECT s2.s_id,s2.s_name,0 avg FROM student s2 WHERE s2.s_id NOT IN (SELECT DISTINCT g2.s_id FROM score g2);

 
-- 4、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
/*
1、涉及的表有student，score
2、关系 student.s_id=score.s_id
*/
-- 方法1：mysql的特有函数 ifnull
SELECT s1.s_id,s1.s_name,COUNT(g1.s_id) course_count,IFNULL(SUM(g1.s_score),0) course_score FROM student s1 LEFT JOIN score g1 ON s1.s_id=g1.s_id GROUP BY s1.s_id;


-- 5、查询学过"张三"老师授课的同学的信息 
/*
1、涉及的表有student,teacher,course,score
2、关系 student.s_id=score.s_id,teacher.t_id=course.t_id,
*/
SELECT s1.* FROM teacher t1 JOIN course c1 ON t1.t_id=c1.t_id AND t1.t_name="张三" JOIN score g1 ON c1.c_id=g1.c_id JOIN student s1 ON g1.s_id=s1.s_id GROUP BY g1.s_id;


-- 6、查询没学过"张三"老师授课的同学的信息
SELECT * FROM student s2 WHERE s2.s_id NOT IN
(SELECT s1.s_id FROM teacher t1 JOIN course c1 ON t1.t_id=c1.t_id AND t1.t_name="张三" JOIN score g1 ON c1.c_id=g1.c_id JOIN student s1 ON g1.s_id=s1.s_id GROUP BY g1.s_id); 


-- 7、查询和"01"号的同学学习的课程完全相同的其他同学的信息
/*
1、涉及的表有student,score
2、关系 student.s_id=score.s_id,
*/
SELECT s2.* FROM student s2 INNER JOIN score g2 ON s2.s_id=g2.s_id AND s2.s_id<>1 WHERE g2.c_id IN(
SELECT g1.c_id FROM score g1 WHERE g1.s_id=1
)GROUP BY g2.s_id HAVING COUNT(g2.c_id)=(SELECT COUNT(g1.c_id) FROM score g1 WHERE g1.s_id=1);


-- 8、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
/*
1、涉及的表有student,score
2、关系 student.s_id=score.s_id,
*/
-- 方法1：行列转换 CASE value WHEN [compare-value] THEN result [WHEN [compare-value] THEN result ...] [ELSE result] END CASE WHEN [condition] THEN result [WHEN [condition] THEN result ...] [ELSE result] END 
SELECT g1.s_id,
MAX(CASE g1.c_id WHEN 1 THEN g1.s_score ELSE 0 END ) 语文,
MAX(CASE g1.c_id WHEN 2 THEN g1.s_score ELSE 0 END) 数学,
MAX(CASE g1.c_id WHEN 3 THEN g1.s_score ELSE 0 END) 英语,
ROUND(AVG( g1.s_score),2) 平均成绩
FROM score g1 GROUP BY g1.s_id ORDER BY 平均成绩 DESC;
-- 方法2： 
select a.s_id,
(select s_score from score where s_id=a.s_id and c_id='01') as 语文,
(select s_score from score where s_id=a.s_id and c_id='02') as 数学,
(select s_score from score where s_id=a.s_id and c_id='03') as 英语,
round(avg(s_score),2) as 平均分
from score a  GROUP BY a.s_id ORDER BY 平均分 DESC;



-- 9.查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
-- 及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
/*
1、涉及的表有：course,score
2、表间关系：course.c_id=score.c_id
*/
-- 方法1：CASE value WHEN [compare-value] THEN result [WHEN [compare-value] THEN result ...] [ELSE result] END CASE WHEN [condition] THEN result [WHEN [condition] THEN result ...] [ELSE result] END 
SELECT c1.c_id 课程编号,c1.c_name 课程名称, MAX(g1.s_score)  最高分,MIN(g1.s_score) 最低分,ROUND(AVG(g1.s_score),2) 平均分,
ROUND(SUM(CASE when g1.s_score>=60 THEN 1 ELSE 0 END)/SUM(CASE when g1.s_score THEN 1 ELSE 0 END)*100,2) 及格率,
ROUND(SUM(CASE when g1.s_score>=70 AND g1.s_score<80 THEN 1 ELSE 0 END)/SUM(CASE when g1.s_score THEN 1 ELSE 0 END)*100,2) 中等率,
ROUND(SUM(CASE when g1.s_score>=80 AND g1.s_score<90 THEN 1 ELSE 0 END)/SUM(CASE when g1.s_score THEN 1 ELSE 0 END)*100,2) 优良率,
ROUND(SUM(CASE when g1.s_score>=90 THEN 1 ELSE 0 END)/SUM(CASE when g1.s_score THEN 1 ELSE 0 END)*100,2) 优秀率
FROM course c1 LEFT JOIN score g1 ON c1.c_id=g1.c_id GROUP BY c1.c_id;



-- 自定义变量，5.7版本的only_full_group_by及关于sql_mode报错详细解决方案
SET @var1='hjekjfw'
SELECT @var1;
-- 解决办法(自定义变量，5.7版本的only_full_group_by及关于sql_mode报错详细解决方案)如下：
SELECT VERSION();
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
SET GLOBAL sql_mode ='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode ='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- 10、按各科成绩进行排序，并显示排名
-- mysql没有rank函数
SELECT @r:=@r+1 非并列排名, tb1.* FROM(
SELECT  g1.* FROM score g1 WHERE g1.c_id=1 ORDER BY g1.s_score DESC
) tb1,(SELECT @r:=0,@m:=0,@er:=0) r
UNION ALL
SELECT @m:=@m+1 非并列排名, tb2.* FROM(
SELECT  g2.* FROM score g2 WHERE g2.c_id=2 ORDER BY g2.s_score DESC
)tb2 ,(SELECT @r:=0,@m:=0,@er:=0) m
UNION ALL
SELECT @er:=@er+1 非并列排名, tb2.* FROM(
SELECT  g2.* FROM score g2 WHERE g2.c_id=2 ORDER BY g2.s_score DESC
)tb2 ,(SELECT @r:=0,@m:=0,@er:=0) f

-- 11、查询学生的总成绩并进行排名
SELECT @rank:=@rank+1 排名,g1.s_id 学生编号,SUM(g1.s_score) 总成绩 FROM score g1,(SELECT @rank:=0) tb1 GROUP BY g1.s_id ORDER BY 总成绩 DESC;

-- 12、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩(考虑并列情况)
SELECT s1.*,tb1.并列排名,tb1.语文,tb1.成绩 FROM student s1 RIGHT JOIN  (
SELECT  @i:= @i+1 非并列排名, @k:=(CASE WHEN @score=g1.s_score THEN @k ELSE @k+1 END) 并列排名,g1.s_id,g1.c_id,'语文', @score:=g1.s_score 成绩 FROM (SELECT @i:=0,@k:=0) var, score g1 LEFT JOIN course c1 ON g1.c_id=c1.c_id WHERE g1.c_id=1 ORDER BY g1.s_score DESC
) tb1 ON s1.s_id = tb1.s_id WHERE tb1.并列排名 BETWEEN 2 AND 3
UNION ALL
SELECT s1.*,tb1.并列排名,tb1.数学,tb1.成绩 FROM student s1 RIGHT JOIN  (
SELECT  @m:= @m+1 非并列排名, @mk:=(CASE WHEN @score=g1.s_score THEN @mk ELSE @mk+1 END) 并列排名, g1.s_id,g1.c_id,'数学',@score:=g1.s_score 成绩 FROM (SELECT @m:=0,@mk:=0) var, score g1 LEFT JOIN course c1 ON g1.c_id=c1.c_id WHERE g1.c_id=2 ORDER BY g1.s_score DESC
) tb1 ON s1.s_id = tb1.s_id WHERE tb1.并列排名 BETWEEN 2 AND 3
UNION ALL
SELECT s1.*,tb1.并列排名,tb1.英语,tb1.成绩 FROM student s1 RIGHT JOIN  (
SELECT  @e:= @e+1 非并列排名, @ek:=(CASE WHEN @score=g1.s_score THEN @ek ELSE @ek+1 END) 并列排名, g1.s_id,g1.c_id,'英语',@score:=g1.s_score 成绩 FROM (SELECT @e:=0,@ek:=0) var, score g1 LEFT JOIN course c1 ON g1.c_id=c1.c_id WHERE g1.c_id=3 ORDER BY g1.s_score DESC
) tb1 ON s1.s_id = tb1.s_id WHERE tb1.并列排名 BETWEEN 2 AND 3


-- 13、查询各学生的年龄
SELECT s_id,s_birth,DATE_FORMAT(NOW(),"%Y")-DATE_FORMAT(s_birth,"%Y")-(CASE WHEN DATE_FORMAT(NOW(),"%m%d")>DATE_FORMAT(s_birth,"%m%d") THEN 0 ELSE 1 END) FROM student
SELECT DATE_FORMAT(NOW(),"%Y%m%d")

-- 14、查询本周过生日的学生
-- 15、查询下周过生日的学生
-- 16、查询本月过生日的学生
-- 17、查询下月过生日的学生
SELECT YEARWEEK(NOW())
UNION ALL
SELECT WEEK(NOW())
UNION ALL
SELECT WEEK(DATE_FORMAT(NOW(),'%Y%m%d'))

SELECT WEEK(DATE("1991-12-29")) 属于一年中的第几个星期
UNION ALL
SELECT WEEK(DATE("2018-12-29")) 属于一年中的第几个星期

select subdate(curdate(),date_format(curdate(),'%w')-1) 星期一的日期,subdate(curdate(),date_format(curdate(),'%w')-7) 星期日的日期
select subdate(curdate(),date_format(curdate(),'%w')-8) 下周星期一的日期,subdate(curdate(),date_format(curdate(),'%w')-14) 下周星期日的日期

SELECT date_add(curdate(), interval - day(curdate()) DAY)
select last_day(curdate()) 获取本月最后一天,day(last_day(curdate())) 获取本月天数

select date_add(curdate(), interval - day(curdate()) + 1 day); #获取本月第一天

select date_add(curdate() - day(curdate()) + 1, interval 1 month); #获取下个月第一天

select date_sub(curdate(), interval 1 month); #获取一个月前那一天

select datediff(curdate(), date_sub(curdate(), interval 1 month)); #获取当前时间与一个月之间的天数
-- 47、查询本周过生日的学生
-- 48、查询下周过生日的学生
-- 49、查询本月过生日的学生
-- 50、查询下月过生日的学生
SELECT s_id,s_birth FROM student WHERE DATE_FORMAT(s_birth,"%m%d")>=DATE_FORMAT(subdate(curdate(),date_format(curdate(),'%w')-1),"%m%d") AND DATE_FORMAT(s_birth,"%m%d")<=DATE_FORMAT(subdate(curdate(),date_format(curdate(),'%w')-7),"%m%d");
















