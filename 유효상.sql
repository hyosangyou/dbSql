join 8
SELECT r.region_id, r.region_name, c.country_name
FROM countries c, regions r
WHERE c.region_id = r.region_id AND region_name = 'Europe';

join 9
SELECT  r.region_id, r.region_name, c.country_name, l.city
FROM countries c, regions r, locations l
WHERE c.region_id = r.region_id AND c.country_id = l.country_id AND region_name = 'Europe';

join 10
SELECT c.region_id, r.region_name, c.country_name, l.city, d.department_name
FROM countries c, regions r, locations l, departments d
WHERE c.country_id = l.country_id AND c.region_id = r.region_id AND d.location_id = l.location_id AND r.region_name = 'Europe';

join 11
SELECT c.region_id, r.region_name, c.country_name, l.city, d.department_name, CONCAT(e.first_name, e.last_name) name
FROM countries c, regions r, locations l, departments d, employees e
WHERE c.country_id = l.country_id AND c.region_id = r.region_id AND d.location_id = l.location_id AND d.department_id = e.department_id AND r.region_name = 'Europe';

join 12 
SELECT e.employee_id, CONCAT(e.first_name, e.last_name) name, j.job_id, j.job_title
FROM employees e, jobs j
WHERE j.job_id = e.job_id;

join 13
SELECT  e.manager_id,CONCAT(m.FIRST_NAME,m.LAST_NAME) MGR_NAME, e.employee_id, CONCAT(e.first_name, e.last_name) name, j.job_id, j.job_title
FROM employees e, jobs j, employees m
WHERE j.job_id = e.job_id AND e.manager_id = m.employee_id;








