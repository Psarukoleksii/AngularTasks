# 1. Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.

SELECT *
FROM client
WHERE LENGTH(FirstName) < 6;

# 2. Вибрати львівські відділення банку.

select *
from department
where DepartmentCity = 'Lviv';

# 3. Вибрати клієнтів з вищою освітою та посортувати по прізвищу.

select *
from client
where Education = 'high'
order by LastName;

# 4. Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.

select *
from application
order by idApplication desc
limit 5;

# 5. Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.

select *
from client
where LastName like '%iv'
   or LastName like '%iva';

# 6. Вивести клієнтів банку, які обслуговуються київськими відділеннями.

select client.FirstName,
       client.LastName,
       department.DepartmentCity
from department
         join client on department.idDepartment = client.Department_idDepartment
where department.DepartmentCity = 'Kyiv';

# 7. Вивести імена клієнтів та їхні номера телефону;

select client.FirstName, client.LastName, client.Passport
from client;

# 8. Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.

select client.FirstName,
       client.LastName,
       a.Sum
from client
         join application a on client.idClient = a.Client_idClient
where a.Sum > 5000;

# 9. Порахувати кількість клієнтів усіх відділень та лише львівських відділень.

select Count(FirstName)
from client
         join department d on client.Department_idDepartment = d.idDepartment
where DepartmentCity = 'Lviv';

# 10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.

select Max(Sum), FirstName, LastName
from application
         join client c on c.idClient = application.Client_idClient
group by FirstName, LastName;

# 11. Визначити кількість заявок на крдеит для кожного клієнта.

select Count(Sum) as CountOfCredits, FirstName, LastName
from application
         join client c on c.idClient = application.Client_idClient
group by FirstName, LastName;

# 12. Визначити найбільший та найменший кредити.

select Max(Sum) as maxCredit, Min(Sum) as minCredit
from application;

# 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.

select Count(Sum) as CountOfCredits
from application
         join client c on c.idClient = application.Client_idClient
where Education = 'high';

# 14. Вивести дані про клієнта, в якого середня сума кредитів найвища.

select FirstName, LastName, AVG(Sum) as Sum
from application
         join client c on c.idClient = application.Client_idClient
group by FirstName, LastName
order by Sum desc
limit 1;

# 15. Вивести відділення, яке видало в кредити найбільше грошей

select Department_idDepartment, Sum(Sum) as AllMoney
from client
         join application a on client.idClient = a.Client_idClient
group by Department_idDepartment
limit 1;

# 16. Вивести відділення, яке видало найбільший кредит.

select Department_idDepartment, Max(Sum)
from application
         join client c on c.idClient = application.Client_idClient
group by Department_idDepartment
limit 1;

# 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.

update application
    join client c on c.idClient = application.Client_idClient
set Sum = 6000
where Education = 'high';

# 18. Усіх клієнтів київських відділень пересилити до Києва.

update client
    join department d on client.Department_idDepartment = d.idDepartment
set City = 'Kyiv'
where DepartmentCity = 'Kyiv';

# 19. Видалити усі кредити, які є повернені.

delete
from application
where CreditState = 'Returned';

# 20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.

delete
from client
where LastName like '_o%'
   or LastName like '_a%'
   or LastName like '_y%'
   or LastName like '_e%'
   or LastName like '_i%';

# 21. Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000

# ??

# 22. Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000

select FirstName, LastName
from application
         join client c on c.idClient = application.Client_idClient
where Sum > 5000
  and CreditState = 'Returned';

# 23. Знайти максимальний неповернений кредит

select Max(Sum)
from application
where CreditState = 'Not returned';

# 24. Знайти клієнта, сума кредиту якого найменша

select FirstName, LastName, Min(Sum)
from client
         join application a on client.idClient = a.Client_idClient;

# 25. Знайти кредити, сума яких більша за середнє значення усіх кредитів;

select Sum
from application
where Sum > (select AVG(Sum) from application);

# 26. Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів;

# ???

# 27. Знайти місто клієнта, який взяв найбільшу суму кредитів

select City, MAX(SUM)
from client
         join application a on client.idClient = a.Client_idClient;


