Select * from Trips


Select 
       MAX(T.tripduration)
FROM Trips as T


SELECT T.tripduration
FROM Trips as T
WHERE T.tripduration = MAX(T.tripduration)




--Which trip record corresponds to the longest trip duration? 

SELECT 
       T.startstationname,
	   T.endstationname,
	   T.tripduration
FROM Trips as T
WHERE T.tripduration in (SELECT MAX(T.tripduration) 
                         from Trips as T)


Select 
      T.startstationname,
	   T.endstationname,
	   T.tripduration
From Trips as T
Where T.tripduration  in (Max(T.tripduration))



--How many trips were taken by 'subscriber' users?

Select *
 FROM Trips as T
 WHERE (T.usertype = 'Subscriber')


--Q3. What is the average trip duration for each usertype?

Select *
FROM Trips as T
WHERE T.tripduration in (SELECT AVG(T.tripduration) 
                         from Trips as T)
GROUP BY T.usertype
ORDER BY T.usertype



Select AVG(T.tripduration) as avg_trip_duration,
       T.usertype
FROM Trips as T
GROUP BY T.usertype




--Q4. Which bike was used for the most trips? [The result should show the bike id and the number of
trips.]

Select T.bikeid,
      Count(T.bikeid) as Number_of_Trips
From Trips as T
Group By T.bikeid 
Order By Count(T.bikeid) DESC



--Q5. What is the average duration of trips by users over the age of 30?

Select AVG(T.tripduration) as Avg_Trip_Duration
From Trips as T
Where (2021-T.birthyear) > 30



--What is the municipality name under which the most frequent starting station belongs? [Use SubQuery only]


Select S.station, count(*) as "count",
       S.municipality
From Trips as T
     inner join Stations as S  
On (S.station = T.startstationname)
Where T.startstationname in (SELECT MAX(T.startstationname) 
                         from Trips as T)
Group by S.station, S.municipality 
Order by S.station,  S.municipality 


-------------------

Select S.station,count(*) as "count",
       S.municipality
From Stations as S 
inner join 
Trips as T  On (S.id = T.startstationid)
Where T.startstationname in (SELECT MAX(S.station) 
                         from Stations as S )
Group by S.station, S.municipality 
Order by count(*) desc


SELECT stations.station AS "Station", COUNT(*) AS "Count"
FROM trips INNER JOIN stations
ON trips.start_station = stations.idGROUP BY stations.stationORDER BY COUNT(*) DESC
LIMIT 5




select * from Stations
Select * from Trips

SELECT S.station, COUNT(*) AS "Count",
       S.municipality
FROM Trips as T INNER JOIN Stations as S
ON (T.startstationid = S.id)
Where S.Station in (SELECT MAX(T.startstationname) 
                         from Trips as T )
GROUP BY S.station, S.municipality
ORDER BY COUNT(*) DESC




--Q7. Which 5 stations are most frequently used for round trips? [i.e., starting and ending station same]

SELECT TOP 5 S.station, COUNT(*) AS "Count"
FROM Trips as T INNER JOIN Stations as S
ON (T.startstationid = S.id)
WHERE T.startstationname = T.endstationname 
GROUP BY S.station
ORDER BY COUNT(*) DESC



--How many trips start and end in different municipalities?
select * from Stations
Select * from Trips


SELECT COUNT(trips.id) AS "Count"
FROM trips INNER JOIN stations AS start
ON trips.start_station = start.id
INNER JOIN stations AS end
ON trips.end_station = end.id
WHERE start.municipality <> end.municipality;


--------------------------------------------

SELECT COUNT(*) AS "Count"
FROM Trips as T INNER JOIN Stations as St
ON (T.startstationid = St.id)
INNER JOIN Stations as En
ON (T.endstationid = En.id)
WHERE St.municipality <> En.municipality

