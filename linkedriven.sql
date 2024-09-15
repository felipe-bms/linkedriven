-- Questão 01
SELECT * FROM public.companies
	LIMIT 5;

-- Questão 02
SELECT * FROM public.companies
	WHERE id=2;

-- Questão 03 INSERT INTO public.companies (name, image_url)
	VALUES ('Apple', 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg');

-- Questão 04
DELETE FROM public.companies
	WHERE id=10;

-- Questão 05
UPDATE public.companies
	SET name = 'Google'
	WHERE id=3;

-- Questão 06
UPDATE public.jobs
	SET salary = '1500'
	WHERE id=1;

-- Questão 07
INSERT INTO public.experiences (user_id, company_id, role_id, start_date)
	VALUES (3, 6, 5, CURRENT_DATE);

-- Questão 08
DELETE FROM public.applicants
	WHERE user_id = 3 AND job_id = 2;

-- Questão 09
SELECT id, description, salary FROM public.jobs
	ORDER BY salary DESC
	LIMIT 3;

-- Questão 10
SELECT j.id, c.name AS company_name, j.salary 
	FROM public.jobs j
	JOIN public.companies c ON j.company_id = c.id
	ORDER BY j.salary ASC
	LIMIT 1;

-- Questão 11
SELECT u.id, u.name, c.id AS city
FROM public.users u
JOIN public.cities c ON u.city_id = c.id
WHERE u.city_id = 3;


-- Questão 12
SELECT t.id, t.message, w.name AS writer, r.name AS recipient
	FROM public.testimonials t
	JOIN public.users w ON t.writer_id = w.id
	JOIN public.users r ON t.recipient_id = r.id;

-- Questão 13
SELECT e.course_id AS id, u.name, c.name AS course, s.name AS schools, e.end_date 
FROM public.educations e
JOIN public.users u ON e.user_id = u.id
JOIN public.courses c ON e.course_id = c.id
JOIN public.schools s ON e.school_id = s.id
WHERE user_id=5
AND e.status = 'finished';

-- Questão 14
SELECT e.user_id AS id, u.name, r.name AS role, c.name AS company, e.start_date 
FROM public.experiences e
JOIN public.users u ON e.user_id = u.id
JOIN public.roles r ON e.role_id = r.id
JOIN public.companies c ON e.company_id = c.id
WHERE e.user_id = 10
AND e.end_date IS NOT NULL;

-- Questão 15
SELECT s.id, s.name AS school, c.name AS course, comp.name AS company, r.name AS roles
FROM public.educations e
JOIN public.users u ON e.user_id = u.id
JOIN public.applicants a ON u.id = a.user_id
JOIN public.jobs j ON a.job_id = j.id
JOIN public.roles r ON j.role_id = r.id
JOIN public.companies comp ON j.company_id = comp.id
JOIN public.courses c ON e.course_id = c.id
JOIN public.schools s ON e.school_id = s.id
WHERE r.name = 'Engenheiro de Software Pleno'
  AND j.company_id = 1
  AND j.active = true;

-- Questão 16
SELECT COUNT(end_date) AS current_experiences
FROM public.experiences;

-- Questão 17
SELECT u.id, u.name, COUNT(e.id) AS educations
FROM public.users u
JOIN public.educations e ON u.id = e.user_id
GROUP BY u.id, u.name
ORDER BY educations DESC;

-- Questão 18
SELECT u.name AS writer, COUNT(t.id) AS testimonialCount
FROM public.users u
JOIN public.testimonials t ON u.id = t.writer_id
WHERE u.id = 9
GROUP BY u.name;

-- Questão 19
SELECT MAX(j.salary) AS maximum_salary, r.name AS role
FROM public.jobs j
JOIN public.roles r ON j.role_id = r.id
WHERE j.active = true
GROUP BY r.name
ORDER BY maximum_salary ASC;


-- Questão 20
SELECT s.name AS school, c.name AS course, COUNT(e.id) AS student_count 
FROM public.educations e
JOIN public.schools s ON e.school_id = s.id
JOIN public.courses c ON e.course_id = c.id
WHERE e.status = 'finished'
GROUP BY s.name, c.name
ORDER BY student_count DESC
LIMIT 3;
