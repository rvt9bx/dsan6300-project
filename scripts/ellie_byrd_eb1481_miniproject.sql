-- Ellie Byrd
-- Mini Project Queries 

-- 1
-- Find maximal departure delay in minutes for each airline. Sort results from smallest to largest maximum delay. 
-- Output airline names and values of the delay.
select Name as name, max(DepDelay) as maximum_delay
from al_perf 
join airline_id
on al_perf.DOT_ID_Reporting_Airline = airline_id.ID
group by DOT_ID_Reporting_Airline
order by maximum_delay;
-- 15 rows returned 

-- 2
-- Find maximal early departures in minutes for each airline. Sort results from largest to smallest.
-- Output airline names.
select Name as name, -1 * min(DepDelay) as maximum_early_departure
from al_perf 
join airline_id
on al_perf.DOT_ID_Reporting_Airline = airline_id.ID
group by DOT_ID_Reporting_Airline
order by maximum_early_departure desc;
-- 15 rows returned

-- 3
-- Rank days of the week by the number of flights performed by all airlines on that day (1 is the busiest).
-- Output the day of the week names, number of flights and ranks in the rank increasing order.
select rank() over (order by count(*) desc) as 'rank', Day as weekday, count(*) as num_flights
from al_perf
join weekdays 
on DayOfWeek = Code
group by Day;
-- 7 rows returned 

-- 4
-- Find the airport that has the highest average departure delay among all airports. 
-- Consider 0 minutes delay for flights that departed early. 
-- Output one line of results: the airport name, code, and average delay.
select Name as name, Origin as code, avg(DepDelayMinutes) as avg_delay
from al_perf 
join airport_id 
on OriginAirportID = ID
group by Origin
order by avg_delay desc
limit 1;
-- 1 row returned 

-- 5
-- For each airline find an airport where it has the highest average departure delay. 
-- Output an airline name, a name of the airport that has the highest average delay, and the value of that average delay.
select line.Name as airline_name, 
	port.Name as airport_name, 
    avg_delay
from (select 
	DOT_ID_Reporting_Airline as airline_id, 
    OriginAirportID as airport_id, 
    avg(DepDelayMinutes) as avg_delay, 
    row_number() over (
            partition by DOT_ID_Reporting_Airline
            order by avg(DepDelayMinutes) desc
        ) AS row_num
from al_perf 
group by DOT_ID_Reporting_Airline, OriginAirportID) as t
join airline_id as line
on airline_id = line.ID
join airport_id as port
on airport_id = port.ID
where row_num = 1;
-- 15 rows returned 

-- 6
-- a) Check if your dataset has any canceled flights.
select count(*) as num_cancelled from al_perf 
where Cancelled = 1;
-- 1 row returned = 2629 cancelled flights 

-- b) If it does, what was the most frequent reason for each departure airport? 
-- Output airport name, the most frequent reason, and the number of cancelations for that reason.
select airport_name, cancellation_reason, num_cancellations
from (select 
    port.Name as airport_name, 
    c.Reason as cancellation_reason,
    count(*) as num_cancellations,
    row_number() over (partition by port.ID order by count(*) desc) AS row_num
from al_perf 
join airport_id as port
on OriginAirportID = port.ID
join cancellation as c
on CancellationCode = c.Code
group by port.ID, c.Code) as t
where row_num = 1;
-- 241 rows returned 

-- 7
-- Build a report that for each day output average number of flights over the preceding 3 days.
select FlightDate, avg(num_flights)
over (order by FlightDate rows between 3 preceding and 1 preceding)
as avg_num_flights
from (
	select FlightDate, count(*) as num_flights 
    from al_perf
    group by FlightDate)
    as count
;
-- 30 rows returned
