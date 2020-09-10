USE labwork_12;
-- 5 9 10 15 20 21 23 27 29 33 

-- 5	Получить все сочетания "цвета деталей-города деталей". 
SELECT DISTINCT detail.color, detail.city FROM detail;

-- 9 9.	Получить номера деталей, поставляемых поставщиком в Таллин.
 SELECT DISTINCT provider_project_detail_number.detail_id FROM provider_project_detail_number
 JOIN provider ON provider.id = provider_project_detail_number.provider_id
 WHERE provider.city = 'Tallin';
 
 -- 10 Получить номера деталей, поставляемых поставщиком в Таллин для проекта в Таллин.
 SELECT DISTINCT provider_project_detail_number.detail_id FROM provider_project_detail_number
 JOIN provider ON provider.id = provider_project_detail_number.provider_id
 JOIN  project ON provider_project_detail_number.project_id = project.id
 WHERE provider.city = 'Tallin' AND project.city = 'Tallin';
 
 -- 15 	Получить общее число проектов, обеспечиваемых поставщиком П1.
SELECT COUNT(*) FROM provider_project_detail_number
WHERE provider_project_detail_number.provider_id = 'P1';

-- 20	Получить цвета деталей, поставляемых поставщиком П1
SELECT DISTINCT  detail.color FROM detail
JOIN provider_project_detail_number ON detail.id = provider_project_detail_number.detail_id
WHERE provider_project_detail_number.provider_id = 'P1';

-- 21 	Получить номера деталей, поставляемых для какого-либо проекта в Москву.
SELECT DISTINCT provider_project_detail_number.detail_id FROM provider_project_detail_number
JOIN project ON provider_project_detail_number.project_id = project.id
WHERE project.city = 'Moscow';

 -- 23.	Получить номера поставщиков, поставляющих по крайней мере одну деталь, поставляемую по крайней мере одним поставщиком, 
 -- который поставляет по крайней мере одну красную деталь. 
 SELECT DISTINCT provider_project_detail_number.provider_id 
 FROM provider_project_detail_number
 WHERE provider_project_detail_number.detail_id IN(
	SELECT DISTINCT  provider_project_detail_number.detail_id 
	FROM provider_project_detail_number
    WHERE provider_project_detail_number.provider_id IN (
		SELECT DISTINCT  provider_project_detail_number.provider_id FROM provider_project_detail_number
        JOIN detail ON provider_project_detail_number.detail_id = detail.id 
        WHERE detail.color = 'red'
    )
 );
 
 -- 27.	Получить номера поставщиков, поставляющих деталь Д1 для некоторого проекта в количестве, большем среднего количества деталей Д1 в поставках для этого проекта.
 SELECT provider_project_detail_number.provider_id FROM provider_project_detail_number
  WHERE provider_project_detail_number.detail_id = 'D1' 
 GROUP BY provider_project_detail_number.project_id 
 HAVING SUM(provider_project_detail_number.quantity) > (
	SELECT AVG (prdn.quantity)
	FROM provider_project_detail_number AS prdn
	WHERE prdn.detail_id = 'D1' AND provider_project_detail_number.project_id = prdn.project_id
	GROUP BY provider_project_detail_number.project_id);
 
 -- 29.	Получить номера проектов, полностью обеспечиваемых поставщиком П1.
 SELECT provider_project_detail_number.project_id FROM provider_project_detail_number
 WHERE provider_project_detail_number.provider_id = 'P1'  AND provider_project_detail_number.project_id  NOT IN (
 SELECT provider_project_detail_number.project_id 
 FROM provider_project_detail_number  
 WHERE provider_project_detail_number.provider_id <> 'P1') ;
 
 -- 33	Получить все города, в которых расположен по крайней мере один поставщик, одна деталь или один проект.
 SELECT provider.city FROM provider
 UNION 
 SELECT project.city FROM project
 UNION
 SELECT detail.city FROM detail;
 
 
 
 