-- Question 1: Display the aircraft ID and the name of all aircraft where the pilot certified to operate them earn more than $85,000. --

select distinct(a.aname)
from dbo.Certified as c
join dbo.Employee as e
on c.eid = e.eid
join dbo.Aircraft as a
on c.aid = a.aid
where e.salary > 85000

-- Question 2: Display the employee id and the maximum cruising range of the certified aircraft for each pilot certified 
--			   for three or more aircraft.

select c.eid as 'Employee_ID', MAX(a.crusingrange) as 'Cruising_Range'
from dbo.Certified as c
join dbo.Aircraft as a
on c.aid = a.aid
group by c.eid
having count(*) > 3

-- Question 3: Find the aircraft name and the average salary of all pilots certified for the aircraft, 
--			   for all aircraft with cruising range over 2000 miles.

select a.aname as 'Aircraft_Name', ROUND(AVG(e.salary), 2) as 'Average_Salary'
from dbo.Employee as e
join dbo.Certified as c
on e.eid = c.eid
join dbo.Aircraft as a
on c.aid = a.aid
where crusingrange > 2000
Group by a.aname

-- Question 4: Display the aircraft id, aircraft name, flight number, and flight origin and destination for the routes that
--			   can be piloted by every pilot whose salary is more than $250,000

select b2.Employee_ID, b1.Aircraft_ID, a.aname as 'Aircraft_Name', b1.Flight_Number, b1.Flight_Origin, b1.Flight_Destination
from dbo.aircraft as a
join(
		select fa.flno as 'Flight_Number', fa.aid as 'Aircraft_ID', f.origin as 'Flight_Origin', f.destination as 'Flight_Destination'
		from dbo.flightallocation as fa
		join dbo.flight as f
		on fa.flno = f.flno) as b1
on a.aid = b1.Aircraft_ID
join( 
		select a.aid as 'AircraftID', e.eid as 'Employee_ID'
		from dbo.Aircraft as a
		join dbo.certified as c
		on a.aid = c.aid
		join dbo.Employee as e
		on c.eid = e.eid
		where salary > 250000) as b2
on b1.Aircraft_ID = b2.AircraftID



-- Question 5: Display the details of pilots who can operate planes with cruising range greater than 4000 miles but are not 
--			   certified on any Boeing aircraft. --

select distinct(e.eid), e.ename, e.salary, e.jobdescription, a.aname
from dbo.Employee as e
join dbo.Certified as c
on e.eid = c.eid
join dbo.Aircraft as a
on c.aid = a.aid
where crusingrange > 4000 and a.aname not like '%Boeing%'

-- Question 6: Find the difference between the average salary of a pilot and the average salary of all employees (including the pilots). 
--			   Name your output column 'Difference in Average'.
		
select round(p.Pilot - e.Employee,2) as 'Difference in Average'
from ( select avg(salary) as Pilot
		from dbo.employee
		where jobdescription like 'Pilot') as p,
		(Select avg(salary) as 'Employee'
		from dbo.Employee) as e


-- Question 7: A passenger wants to travel from Dubai to Auckland either on a direct flight or with no more than 1 change of flight. 
--			   List the choice of departure times from Dubai if the customer wants to arrive in Auckland by 8 p.m.

SELECT cast(f3.departs as time) as 'Depart'
FROM dbo.Flight as f3
WHERE f3.flno IN ( ( SELECT f1.flno
					FROM dbo.Flight f1
					WHERE f1.origin = 'Dubai' AND F1.destination = 'Auckland' 
					AND cast(f1.arrives as time) < '18:00:00' )
Union					( SELECT f1.flno
					FROM dbo.Flight as f1
					cross join dbo.Flight as f2
					WHERE f1.origin = 'Dubai' AND f1.destination <> 'Auckland'
					AND f1.destination = f2.origin AND f2.destination = 'Auckland'
					AND f2.departs > f1.arrives AND
					cast(f2.arrives as time) < '18:00:00' ))

-- Question 8: Find the employee who manages the greatest number of employees while also being managed himself/ herself by someone else. 
--			   Display 3 columns: Manager, Is Managed By and empCount. The column Manager should display the name of the manager who manages
--			   the most employees, and the column Is Managed By should display the name of that person’s manager.
--	           The column empCount should display the count of employees this manager who has the most employees reporting to him/her is managing. --

select top 1 p1.Manager, p2.ename as 'Is Managed By', count(p1.Manager_ID) as 'empCount'
from	(select 
			sup.eid as 'Manager_ID', 
			sup.ename as 'Manager',
			sup.managerid
				from dbo.Employee as sub
				join dbo.Employee as sup
				on sub.managerid = sup.eid) p1
join dbo.Employee p2
on p1.ManagerID = p2.eid
group by p1.Manager, p2.ename
Order by 'empCount' desc

-- Question 9: Write a SQL statement to output four columns: EmployeeID, Employee Name, the id of the aircraft they are certified to fly, 
--			   and Duration since certified. Duration indicates exactly how long the employee has been certified in years and months.

select 
	c.eid as 'EmployeeID', 
	e.ename as 'Employee Name', 
	c.aid as 'Aircraft ID', 
	concat
			((cast((Datediff(DAY, certdate, getdate())) as int) / 365),' ', 'Year(s)',' ', 
			cast((Datediff(DAY, certdate, getdate())) as int) % 365/30,' ', 'Month(s)') 
			as 'Duration Since Certified'
from dbo.Certified as c
left join dbo.employee as e
on c.eid = e.eid


-- Question 10: Write a SQL statement to output two columns, PassengerID and Total Price. 
--			    The PassengerID is the identifier for a passenger who has booked one or many seats. 
--				The Total Price is the cumulated price that each passenger must pay for the seat/s they have booked. 
--				When calculating the Total Price, you must take into consideration any percentage increase or decrease to the base seat price based on fare rules which have been applied to a seat. 
--				You must also take into consideration the price of the addons which have been applied to a seat. --


select b.pid as 'PassengerID', 
		sum(isnull(ao.Total_Addon_Price, 0) + (isnull(isnull(s.basefare * (100 - fr.pdecrease)/100, s.basefare + (s.basefare * fr.pincrease/100)), s.basefare))) as [Total Price]
from dbo.booking as b
left join dbo.seat as s
on b.seatNo = s.seatNo
left join (	select ba.bid, sum(a1.price) as 'Total_Addon_Price'
			from dbo.BookingAddOn as ba
			join dbo.AddOn as a1
			on ba.AdID = a1.AdID
			group by ba.BID) as ao
on b.bid = ao.BID
left join dbo.Farerule as fr
on b.rid = fr.rID
group by b.pid
