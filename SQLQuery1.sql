--Write a SQL query to display customer firstname, gender, corresponding zipcode, fullname column concatenated,
--longitude and latitude for all male customers whose firstname is more than 5 letters.  

select * from Customers
select * from ZipCensus

select cu.Firstname as CustomerName , cu.Gender, z.zcta5 as zipcode, z.Longitude, z.Latitude
from Customers cu
join Zipcensus z on Cu.CustomerId = z.esriid
WHERE (Z.latitude BETWEEN 20 AND 50) and (Z.longitude BETWEEN -130 AND -65)
and len(FirstName) > 5 and Gender = 'M'



SELECT DISTINCT(C.FirstName) AS Customer_name, C.Gender, z.zcta5 AS Zipcode, Z.Longitude, Z.Latitude
FROM Customers C JOIN ZipCensus Z  ON C.CustomerId = Z.esriid
WHERE (Z.latitude BETWEEN 20 AND 50) AND (Z.longitude BETWEEN -130 AND -65) AND LEN(firstname) > 5 AND Gender='m';

--Write a query for displaying the zipcode, longitude, latitude and 
--populations of top 10 zipcode areas that has the lowest population in ascending order. 
--Your query should consider only those zip codes whose population is more than 5 times the average population of all the zipcodes.  


select * from ZipCensus

select top 10 z.zcta5 as zipcode, z.Longitude, z.Latitude , z.TotPop as TotalPopulation
from ZipCensus z
WHERE TotPop > (5 * (SELECT AVG(TotPop) FROM ZipCensus))
ORDER BY TotPop



SELECT TOP 10 Z.zcta5 AS Zipcode, Z.Latitude, Z.Longitude, Z.TotPop AS Total_Populaton
FROM ZipCensus Z
WHERE TotPop > (10 * (SELECT AVG(TotPop) FROM ZipCensus))
ORDER BY TotPop;


--Write a SQL query to display the yearly distribution of number of orders, sum of total price, 
--sum of number, average price and average units of units between year 2012 and 2016. 
--Use of appropriate group by and order by are needed. The output should be in the following format. 
--Year 	NumOfOrders 	SumTotPrice 	SumNumUnits 

select * from Orders

select year(OrderDate) as 'Year', Count(OrderId) as NumofOrders, sum(TotalPrice) as SumTotPrice, sum(NumUnits) as SumNumUnits
from Orders
where (year(OrderDate) between 2012 and 2016)
group by year(OrderDate)
order by year(OrderDate)


SELECT YEAR(OrderDate) AS 'Year',  COUNT(OrderId) AS NumOfOrders, SUM(TotalPrice) AS SumTotPrice, SUM(NumUnits) AS SumNumUnits
FROM Orders
GROUP BY YEAR(OrderDate) 
ORDER BY YEAR(OrderDate) ;

--Considering continental USA, write a SQL query that shows the zipcode and population of 
--those areas that have population of at least 110,000 
--but at most two orders placed, i.e., the zipcodes appear maximum two times in the Orders table.  
 		
select * from ZipCensus
select * from orders

select z.zcta5 as Zipcode, z.TotPop as TotalPopulation
from ZipCensus z
join
(select Zipcode from Orders 
group by ZipCode
having count(OrderId) <=2) as o on z.zcta5 = o.ZipCode
where (Z.latitude BETWEEN 20 AND 50) AND (Z.longitude BETWEEN -130 AND -65)
AND Z.TotPop >= 100000
ORDER BY Z.TotPop DESC


SELECT Z.zcta5 AS Zipcode, Z.TotPop AS TotalPop
FROM ZipCensus Z JOIN (SELECT ZipCode FROM Orders 
GROUP BY ZipCode
HAVING COUNT(OrderId) <= 2) AS O ON Z.zcta5 = O.ZipCode
WHERE (Z.latitude BETWEEN 20 AND 50) AND (Z.longitude BETWEEN -130 AND -65)
AND Z.TotPop >= 100000
ORDER BY Z.TotPop DESC;



--Write a SQL query to show the tenure (in terms of days) and sum of monthly fee for subscribers who are active.
--The cut-off date should be the current database date minus day(s) that is equal to the last digit of your student number. 
--Use appropriate SQL date functions. The query should consider data with start date from 2004-01-01. 

select * from Subscribers

select datediff(day,StartDate,getdate() - 3) AS Tenure, 
sum(MonthlyFee) as TotalMonthlyFee
from Subscribers
where IsActive = 1 and StartDate >= '2004-01-01'
group by DATEDIFF(DAY,StartDate,GETDATE() - 3)
order by Tenure

SELECT DATEDIFF(DAY,StartDate,GETDATE() - 8) AS Tenures, 
SUM(MonthlyFee) AS SumOfMonthlyFee
FROM Subscribers 
WHERE IsActive=1 and StopDate is null and StartDate>='2004-01-01'
GROUP BY DATEDIFF(DAY,StartDate,GETDATE() - 8)
ORDER BY Tenures;





--Write a SQL query for Recency calculation based on Orders and Customers Table. 
--The cut-off date should be 2016-01-01 minus day(s) that is equal to the last digit of your student number. 
--Use appropriate SQL date functions.  


select Recency, count(*) as "Number of HH"                                                     
from (select HouseholdId, datediff(day, max(OrderDate), cast(datediff(day,3,'2016-01-01') as datetime)) as Recency                                                 
      from Orders o JOIN Customers c ON o.CustomerId = c.CustomerId                                                 
      where OrderDate < cast(datediff(day,3,'2016-01-01') as datetime)                                           
      group by HouseholdId
         --order by recency desc
         ) h                                                 
group by Recency                                                    
order by Recency;


