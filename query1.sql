USE labwork_1;

 
-- 1 Получить полную информацию обо всех преподавателях.
SELECT * FROM teachers;

-- 2 Получить полную информацию обо всех студенческих группах на специальности ЭВМ.
SELECT * FROM studentgroup WHERE Specialty='ECM';

-- 3 Получить личный номер преподавателя и номера аудиторий, в которых они преподают предмет с кодовым номером 18П.
SELECT PrivateNumber, roomNumber  FROM teacherpreorderedgroups WHERE CodeDisciplineNumber='18P';

-- 4 Получить  номера предметов и названия предметов, которые ведет преподаватель Костин.
SELECT DISTINCT discipline.CodeDisciplineNumber, discipline.DisciplineName FROM discipline 
	JOIN teacherpreorderedgroups ON teacherpreorderedgroups.CodeDisciplineNumber = discipline.CodeDisciplineNumber 
		JOIN teachers ON teachers.privateNumber = teacherpreorderedgroups.PrivateNumber
    WHERE teachers.firstname= 'Kostin';
    
-- 5 Получить номер группы, в которой ведутся предметы преподавателем Фроловым.
SELECT  teacherpreorderedgroups.CodeGroupNumber FROM teacherpreorderedgroups
	JOIN teachers ON teacherpreorderedgroups.PrivateNumber = teachers.privateNumber
    WHERE teachers.firstname= 'Frolov';
   
-- 6 Получить информацию о предметах, которые ведутся на специальности АСОИ.  
SELECT * FROM discipline WHERE Specialty='ACOI';

-- 7  Получить информацию о преподавателях, которые ведут предметы на специальности АСОИ.
SELECT * FROM TEACHERS WHERE TEACHERS.firstname IN(
	SELECT DISTINCT TEACHERS.firstname FROM TEACHERS 
		JOIN teacherpreorderedgroups ON teacherpreorderedgroups.PrivateNumber = teachers.privateNumber
			JOIN studentgroup ON studentgroup.CodeGroupNumber =  teacherpreorderedgroups.CodeGroupNumber
        WHERE studentgroup.Specialty='ACOI');
        
-- 8 Получить фамилии преподавателей, которые ведут предметы в 210 аудитории.       
SELECT DISTINCT TEACHERS.firstname FROM TEACHERS 
	JOIN  teacherpreorderedgroups ON teacherpreorderedgroups.PrivateNumber = teachers.privateNumber
WHERE teacherpreorderedgroups.roomNumber = 210;

-- 9 Получить названия предметов и названия групп, которые ведут занятия в аудиториях с 100 по 200.
SELECT DISTINCT  discipline.DisciplineName, studentgroup.GroupName FROM discipline
	JOIN teacherpreorderedgroups ON teacherpreorderedgroups.CodeDisciplineNumber = discipline.CodeDisciplineNumber
		JOIN studentgroup ON teacherpreorderedgroups.CodeGroupNumber = studentgroup.CodeGroupNumber
    WHERE  teacherpreorderedgroups.roomNumber > 100 AND teacherpreorderedgroups.roomNumber < 200;
    
-- 10 Получить пары номеров групп с одной специальности.	
SELECT studentgroup_1.CodeGroupNumber, studentgroup_2.CodeGroupNumber FROM studentgroup AS studentgroup_1
	JOIN studentgroup AS studentgroup_2  ON studentgroup_1.Specialty = studentgroup_2.Specialty 
WHERE studentgroup_1.CodeGroupNumber < studentgroup_2.CodeGroupNumber;

-- 11 Получить общее количество студентов, обучающихся на специальности ЭВМ.
 SELECT SUM(studentgroup.QuantityPerson) FROM  studentgroup    
 WHERE Specialty = 'ECM';
 
 -- 12 Получить номера преподавателей, обучающих студентов по специальности ЭВМ.
 SELECT DISTINCT teacherpreorderedgroups.PrivateNumber FROM teacherpreorderedgroups
	JOIN  studentgroup ON studentgroup.CodeGroupNumber = teacherpreorderedgroups.CodeGroupNumber
    WHERE studentgroup.Specialty = 'ECM';

-- 13 Получить номера предметов, изучаемых всеми студенческими группами.
SELECT teacherpreorderedgroups.CodeDisciplineNumber  FROM teacherpreorderedgroups
GROUP BY teacherpreorderedgroups.CodeDisciplineNumber 
HAVING COUNT(teacherpreorderedgroups.CodeDisciplineNumber) = (SELECT COUNT(*) FROM studentgroup);

-- 14 Получить фамилии преподавателей, преподающих те же предметы, что и преподаватель преподающий предмет с номером 14П.
WITH queryCodeDisciplineNumber AS (
    SELECT DISTINCT teacherpreorderedgroups.CodeDisciplineNumber FROM teacherpreorderedgroups
	WHERE teacherpreorderedgroups.PrivateNumber IN (
		SELECT  DISTINCT teacherpreorderedgroups.PrivateNumber FROM teacherpreorderedgroups 
		WHERE teacherpreorderedgroups.CodeDisciplineNumber = '14P')
)
SELECT  DISTINCT teachers.firstname FROM teachers 
JOIN  teacherpreorderedgroups ON teacherpreorderedgroups.PrivateNumber = teachers.privateNumber
WHERE teacherpreorderedgroups.CodeDisciplineNumber  IN (
	SELECT queryCodeDisciplineNumber.CodeDisciplineNumber 
    FROM queryCodeDisciplineNumber);
    
 -- 15 Получить информацию о предметах, которые не ведет преподаватель с личным номером 221П.
 SELECT DISTINCT discipline.*
 FROM discipline
 JOIN teacherpreorderedgroups ON discipline.CodeDisciplineNumber = teacherpreorderedgroups.CodeDisciplineNumber
 WHERE teacherpreorderedgroups.CodeDisciplineNumber NOT IN (
	SELECT teacherpreorderedgroups.CodeDisciplineNumber 
	FROM teacherpreorderedgroups 
    WHERE teacherpreorderedgroups.PrivateNumber = '221L'
 );
 
 -- 16 Получить информацию о предметах, которые не изучаются в группе М-6.
 SELECT DISTINCT  discipline.* 
 FROM discipline 
 WHERE discipline.CodeDisciplineNumber NOT IN (
	SELECT teacherpreorderedgroups.CodeDisciplineNumber 
	FROM teacherpreorderedgroups
	JOIN studentgroup ON  teacherpreorderedgroups.CodeGroupNumber = studentgroup.CodeGroupNumber
	WHERE studentgroup.GroupName = 'M-6'
 );
 
-- 17 Получить информацию о доцентах, преподающих в группах 3Г и 8Г.
SELECT DISTINCT  teachers.* FROM teachers
JOIN teacherpreorderedgroups ON teacherpreorderedgroups.PrivateNumber = teachers.privateNumber
WHERE  teacherpreorderedgroups.CodeGroupNumber IN ('3G','4G') AND teachers.post = 'DOCENT';

-- 18  Получить номера предметов, номера преподавателей, номера групп, в которых ведут занятия преподаватели с кафедры ЭВМ, имеющих специальность АСОИ.
SELECT  DISTINCT teacherpreorderedgroups.CodeDisciplineNumber, teacherpreorderedgroups.PrivateNumber, teacherpreorderedgroups.CodeGroupNumber
FROM teacherpreorderedgroups
JOIN teachers ON teachers.PrivateNumber = teacherpreorderedgroups.PrivateNumber
WHERE department = 'ECM' AND specialty LIKE '%ACOI%';

-- 19 Получить номера групп с такой же специальностью, что и специальность преподавателей.
SELECT  DISTINCT studentgroup.CodeGroupNumber
FROM studentgroup 
JOIN teacherpreorderedgroups ON teacherpreorderedgroups.CodeGroupNumber = studentgroup.CodeGroupNumber
JOIN teachers ON teacherpreorderedgroups.PrivateNumber = teachers.PrivateNumber 
WHERE teachers.specialty LIKE studentgroup.Specialty;
 
-- 20 Получить номера преподавателей с кафедры ЭВМ, преподающих предметы по специальности, совпадающей со специальностью студенческой группы. 
SELECT DISTINCT  teachers.privateNumber FROM teachers
JOIN teacherpreorderedgroups ON teacherpreorderedgroups.PrivateNumber = teachers.PrivateNumber 
JOIN studentgroup ON studentgroup.CodeGroupNumber = teacherpreorderedgroups.CodeGroupNumber
WHERE teachers.department = 'ECM' AND  studentgroup.Specialty LIKE teachers.specialty;

-- 21 Получить специальности студенческой группы, на которых работают преподаватели кафедры АСУ.
SELECT  DISTINCT studentgroup.Specialty FROM studentgroup
JOIN teacherpreorderedgroups teacherpreorderedgroups ON teacherpreorderedgroups.CodeGroupNumber = studentgroup.CodeGroupNumber
JOIN  teachers ON  teacherpreorderedgroups.PrivateNumber = teachers.PrivateNumber 
WHERE teachers.department = 'ASU';

-- 22 Получить номера предметов, изучаемых группой АС-8
SELECT discipline.CodeDisciplineNumber FROM discipline
JOIN teacherpreorderedgroups ON discipline.CodeDisciplineNumber = teacherpreorderedgroups.CodeDisciplineNumber
JOIN studentgroup ON studentgroup.CodeGroupNumber =  teacherpreorderedgroups.CodeGroupNumber
WHERE studentgroup.GroupName = 'AS-8';

-- 23 Получить номера студенческих групп, которые изучают те же предметы, что и студенческая группа АС-8.
SELECT DISTINCT studentgroup.CodeGroupNumber FROM studentgroup
JOIN teacherpreorderedgroups ON studentgroup.CodeGroupNumber =  teacherpreorderedgroups.CodeGroupNumber
WHERE teacherpreorderedgroups.CodeDisciplineNumber IN (
	SELECT DISTINCT discipline.CodeDisciplineNumber FROM discipline
	JOIN teacherpreorderedgroups ON discipline.CodeDisciplineNumber = teacherpreorderedgroups.CodeDisciplineNumber
	JOIN studentgroup ON studentgroup.CodeGroupNumber =  teacherpreorderedgroups.CodeGroupNumber
	WHERE studentgroup.GroupName = 'AS-8');
    
-- 24 Получить номера студенческих групп, которые не изучают предметы, преподаваемых в студенческой группе АС-8.
SELECT DISTINCT studentgroup.CodeGroupNumber FROM studentgroup
JOIN teacherpreorderedgroups ON studentgroup.CodeGroupNumber =  teacherpreorderedgroups.CodeGroupNumber
WHERE teacherpreorderedgroups.CodeDisciplineNumber  NOT IN (
	SELECT DISTINCT discipline.CodeDisciplineNumber FROM discipline
	JOIN teacherpreorderedgroups ON discipline.CodeDisciplineNumber = teacherpreorderedgroups.CodeDisciplineNumber
	JOIN studentgroup ON studentgroup.CodeGroupNumber =  teacherpreorderedgroups.CodeGroupNumber
	WHERE studentgroup.GroupName = 'AS-8');

-- 25 Получить номера студенческих групп, которые не изучают предметы, преподаваемых преподавателем 430Л.	
SELECT DISTINCT teacherpreorderedgroups.CodeGroupNumber FROM teacherpreorderedgroups
WHERE  teacherpreorderedgroups.CodeGroupNumber NOT IN (
	SELECT  teacherpreorderedgroups.CodeGroupNumber FROM teacherpreorderedgroups
	WHERE teacherpreorderedgroups.PrivateNumber = '430L');
    
 -- 26 Получить номера преподавателей, работающих с группой Э-15, но не преподающих предмет 12П.
 SELECT teacherpreorderedgroups.PrivateNumber FROM teacherpreorderedgroups
 JOIN studentgroup ON studentgroup.CodeGroupNumber = teacherpreorderedgroups.CodeGroupNumber
 WHERE  studentgroup.GroupName = 'E-15' AND teacherpreorderedgroups.PrivateNumber NOT IN (
 SELECT teacherpreorderedgroups.PrivateNumber FROM teacherpreorderedgroups
 WHERE teacherpreorderedgroups.CodeDisciplineNumber = '12P');
 









 


 

        

