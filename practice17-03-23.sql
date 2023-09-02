drop table companies

CREATE TABLE companies
(
  company_id SMALLINT,
  company VARCHAR(20),
  number_of_employees SMALLINT
);
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;
--1.Example: Find the company and number_of_employees
--whose number_of_employees is the second highest(1.Örnek: Şirketi bulun ve number_of_employees
--number_of_employees ikinci en yüksek olan)

	

SELECT company, number_of_employees FROM companies
WHERE number_of_employees = (SELECT MAX (number_of_employees)FROM companies        
WHERE number_of_employees < (SELECT MAX (number_of_employees)FROM companies));							

--2. WAY offset 
SELECT company, number_of_employees FROM companies
order by number_of_employees desc 
offset 1
limit 1

--2.Example: Find the company names and number of employees whose number of employees
--is less than the average number of employees(--2.Örnek: Şirket adlarını ve çalışan sayısı olan çalışan sayısını bulun
--ortalama çalışan sayısından daha az)

SELECT company, number_of_employees FROM companies
where  number_of_employees < (select avg(number_of_employees) from companies)

SELECT * FROM companies
--3.Example: Update the number of employees of the IBM to 9999

UPDATE companies set number_of_employees=9999 where company='IBM'

--4.Example: Update the number of employees to 16000 if the number of employees
--is less than the average number of employees

update companies set number_of_employees=16000
where number_of_employees < (select avg( number_of_employees) from companies)
