# Flight Information SQL Analysis

This project aims to develop essential skills while applying structured query language (SQL) for data-based problem-solving. SQL statements are crafted to extract information from a flight information dataset and solve data related challenges.

The following project aims to answer the following questions through SQL statements:
1. Display the aircraft ID and the name of all aircraft where the pilot certified to operate them
earn more than $85,000.
2. Display the employee id and the maximum cruising range of the certified aircraft for each
pilot certified for three or more aircraft.
3. Find the aircraft name and the average salary of all pilots certified for the aircraft, for all
aircraft with cruising range over 2000 miles.
4. Display the aircraft id, aircraft name, flight number, and flight origin and destination for the
routes that can be piloted by every pilot whose salary is more than $250,000.
5. Display the details of pilots who can operate planes with cruising range greater than 4000
miles but are not certified on any Boeing aircraft.
6. Find the difference between the average salary of a pilot and the average salary of all
employees (including the pilots). Name your output column 'Difference in Average'.
7. A passenger wants to travel from Dubai to Auckland either on a direct flight or with no more
than 1 change of flight. List the choice of departure times from Dubai if the customer wants to arrive in
Auckland by 8 p.m.
8. Find the employee who manages the greatest number of employees while also being managed
himself/ herself by someone else. Display 3 columns: Manager, Is Managed By and empCount. The
column Manager should display the name of the manager who manages the most employees, and the
column Is Managed By should display the name of that person’s manager. The column empCount should
display the count of employees this manager who has the most employees reporting to him/her is
managing.
9. Write a SQL statement to output four columns: EmployeeID, Employee Name, the id of the
aircraft they are certified to fly, and Duration since certified. Duration indicates exactly how long the
employee has been certified in years and months. Your output should be formatted like the example
output table below.
NOTE: This incomplete output has been generated using some of the sample data in the test database
provided to you.
EmployeeID Employee Name Aircraft ID Duration Since Certified
11564812 John Williams 1 20 Year(s) 8 Month(s)
11564812 John Williams 2 11 Year(s) 6 Month(s)
90873519 Elizabeth Taylor 10 11 Year(s) 6 Month(s)
141582651 Mary Johnson 11 7 Year(s) 4 Month(s)
141582651 Mary Johnson 15 7 Year(s) 3 Month(s)
142519864 Betty Adams 1 19 Year(s) 7 Month(s)
142519864 Betty Adams 12 6 Year(s) 11 Month(s)
10. Write a SQL statement to output two columns, PassengerID and Total Price. The PassengerID
is the identifier for a passenger who has booked one or many seats. The Total Price is the cumulated
price that each passenger must pay for the seat/s they have booked. When calculating the Total Price,
you must take into consideration any percentage increase or decrease to the base seat price based on fare
rules which have been applied to a seat. You must also take into consideration the price of the addons
which have been applied to a seat
