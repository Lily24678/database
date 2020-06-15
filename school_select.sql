show tables;
SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM course;
SELECT * FROM score;

-- 10、按各科成绩进行排序，并显示排名
-- 11、查询学生的总成绩并进行排名
-- 12、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩(考虑并列情况)
-- 13、查询各学生的年龄

-- 14、查询本周过生日的学生
-- 15、查询下周过生日的学生
-- 16、查询本月过生日的学生
-- 17、查询下月过生日的学生


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
















