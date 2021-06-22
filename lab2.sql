[Skopiuj tabele Job_grades od uzytkownika HR]

CREATE TABLE job_grades AS SELECT * 
FROM HR.job_grades;
-------------------------

[Z tabeli employees wypisz w jednej kolumnie nazwisko i zarobki – nazwij kolumne wynagrodzenie, dla osób z departamentów 20 i 50 z zarobkami pomiedzy 2000 a 7000, uporzadkuj kolumny wedlug nazwiska]

SELECT last_name || ' ' || salary AS wynagrodzenie 
FROM employees WHERE department_id IN (20, 50) AND salary BETWEEN 2000 AND 5000 
ORDER BY last_name;
-------------------------

[Dla kazdego dzialów w których minimalna placa jest wyzsza niz 5000 wypisz sume oraz srednia zarobków zaokraglony do calosci nazwij odpowiednio kolumny]

SELECT department_name, SUM(salary) as suma, round(avg(salary), 0) AS srednia 
FROM departments JOIN employees ON department_id = department_id 
GROUP BY department_name HAVING AVG(salary) > 5000;
-------------------------

[Wypisac nazwisko, numer departamentu, nazwe departamentu, id pracy, dla osób z pracujacych w Toronto]

SELECT last_name, department_id, department_name, job_id 
FROM departments JOIN employees ON department_id = department_id JOIN locations ON location_id = location_id 
WHERE city = 'Toronto';
-------------------------

[Dla pracowników o imieniu „Jennifer” wypisz imie i nazwisko tego pracownika oraz osoby które z nim wspólpracuja]

SELECT first_name, last_name 
FROM employees JOIN jobs ON job_id = job_id 
WHERE first_name = 'Jennifer' OR job_id IN (SELECT job_id FROM employees WHERE first_name = 'Jennifer');
-------------------------

[Wypisac wszystkie departamenty w których nie ma pracowników]

SELECT * 
FROM departments 
WHERE department_id NOT IN (SELECT DISTINCT department_id FROM employees WHERE department_id IS NOT NULL);
-------------------------

[Wypisz imie nazwisko oraz zarobki dla osób które zarabiaja wiwcej niz srednia wszystkich, uporzadkuj malejaco wedlug zarobków]

SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees) 
ORDER BY salary DESC;
-------------------------

SELECT hier_date, last_name
FROM employees
WHERE manager_ID IS NOT NULL AND hier_date BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY hier_date;
-------------------------

SELECT months, salary,
(CASE WHEN months > 200 then 0.3
      WHEN months > 150 then 0.2
      ELSE 0.1
 END * salary) AS dodatek
FROM (SELECT first_name, last_name, salary, ROUND(MONTHS_BETWEEN(CURRENT_DATE, hier_date)) AS months FROM employees)
ORDER BY months;

