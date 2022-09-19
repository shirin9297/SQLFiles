--1. Örnek: companies tablosundan en yüksek ikinci number_of_employees değeri olan company ve number_of_employees değerlerini çağırın.

--1. yol OFFSET ve FETCH NEXT kullanarak
SELECT company, number_of_employees
from companies
order by number_of_employees desc
offset 1 row 
fetch next 1 row only -- fetch getir demek

SELECT company, number_of_employees
FROM companies
WHERE number_of_employees = (SELECT MAX(number_of_employees)
                             FROM companies
                             WHERE number_of_employees < (SELECT MAX(number_of_employees)
                             FROM companies))

--1. Örnek: number_of_employees değeri ortalama çalışan sayısından az olan number_of_employees değerlerini 16000 olarak UPDATE edin.
update companies
set number_of_employees = 16000
where number_of_employees < (select avg(number_of_employees)
                             from companies)


select * from companies




