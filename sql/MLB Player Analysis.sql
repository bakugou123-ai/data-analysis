-- MLB PLAYER ANALYSIS PROJECT 

--  In each decade, how many schools were there that produced MLB players?
SELECT * FROM schools;
SELECT ROUND(yearID, -1) AS Years , COUNT(DISTINCT schoolID) as school_count
FROM schools
GROUP BY Years;

--  What are the names of the top 5 schools that produced the most players?

SELECT schoolID, COUNT(playerID) AS player_count
FROM schools
GROUP BY schoolID
ORDER BY player_count DESC LIMIT 5;

-- For each decade, what were the names of the top 3 schools that produced the most players?
with player_tab AS(SELECT ROUND(yearID,-1)as Years, schoolID, COUNT( distinct playerID) AS players
FROM schools 
GROUP BY Years, schoolID
ORDER BY players DESC),
ranking_table AS(SELECT *,
DENSE_RANK() OVER(partition by Years order by players DESC) AS ranking
FROM player_tab )

SELECT Years, schoolID FROM ranking_table 
WHERE ranking<4 
ORDER BY Years;

-- Return the top 20% of teams in terms of average annual spending
SELECT * FROM salaries ;

WITH avg_spend AS (SELECT yearID, teamID, round(AVG(salary),2) as avg_annual_spending 
FROM salaries 
GROUP BY yearID, teamID) ,

tp AS (SELECT * , NTILE(5) OVER(ORDER BY avg_annual_spending) as ranking FROM avg_spend) 

SELECT yearid,teamid, avg_annual_spending FROM tp WHERE ranking =1 ;


-- For each team, show the cumulative sum of spending over the years
WITH cum_sum_table AS (SELECT yearID, teamID, ROUND(SUM(salary)/1000000,2) AS salary_sum FROM salaries GROUP BY yearID, teamID)

SELECT yearid, teamid , SUM(salary_sum) OVER(PARTITION BY teamID order BY yearID) as cum_sum_in_millions FROM cum_sum_table;

-- Return the first year that each team's cumulative spending surpassed 1 billion
WITH cum_bil_table AS (SELECT yearID, teamID, SUM(salary) AS salary_sum FROM salaries GROUP BY yearID, teamID),
bt as (SELECT yearid, teamid , SUM(salary_sum) OVER(PARTITION BY teamID order BY yearID) as cum_sum_in_millions FROM cum_bil_table), 
nt AS (SELECT * FROM bt WHERE cum_sum_in_millions> 999999999), 
final_rank AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY teamID ORDER BY cum_sum_in_millions) AS ranks FROM nt)

select yearID, teamid, ROUND(cum_sum_in_millions /1000000000,2) as cum_spending_in_billions from final_rank where ranks =1;

-- For each player, calculate their age at their first (debut) game, their last game, and their career length (all in years). Sort from longest career to shortest career.
SELECT * FROM players;

SELECT namegiven, YEAR(debut) - birthyear as debut_age
,YEAR(finalGame) - birthYear as retirement_age
,(YEAR(finalGame) - birthYear ) - (YEAR(debut) - birthyear) as career_length_in_years 
FROM players 
WHERE year(finalgame) is not null and year(debut) is not null and birthyear is not null;

-- What team did each player play on for their starting and ending years?
with player_info as (select p.namegiven, s.yearid as starting_year, s.teamid as debut_team,
 e.yearid as retirement_year, e.teamid as retirement_team from players p INNER JOIN salaries s ON p.playerID = s.playerID 
 AND s.yearid = YEAR(p.debut)
 INNER JOIN salaries e on e.playerid = p.playerid AND e.yearid = YEAR(p.finalgame) )
 
 SELECT * FROM player_info ;
 
-- How many players started and ended on the same team and also played for over a decade?
select * from salaries;
select * from players;
with debut_info as (select p.namegiven, s.teamid as debut_team, s.yearid as  starting_year, 
e.teamid as retirement_team, e.yearid as retirement_year 
from players p inner join salaries s
on p.playerid = s.playerid AND s.yearid = YEAR(p.debut)
INNER join salaries e 
on p.playerid = e.playerid and e.yearid = year(p.finalgame) )

select * from debut_info WHERE retirement_team = debut_team AND retirement_year - starting_year > 10 ;

-- Which players have the same birthday?

SELECT p1.namegiven as player1 , p2.namegiven as player2, CONCAT(p1.birthyear,'-', p1.birthmonth, '-', p1.birthday)as birthday from players p1 INNER JOIN  
players p2 ON  CONCAT(p1.birthyear,'-', p1.birthmonth, '-', p1.birthday) =  CONCAT(p2.birthyear,'-', p2.birthmonth, '-', p2.birthday)
where p1.nameGiven<>p2.namegiven
ORDER BY player1;

-- Create a summary table that shows for each team, what percent of players bat right, left and both
select * from players ;
WITH team_info AS (SELECT  DISTINCT p.playerid, s.teamID, p.bats, p.namegiven from salaries s INNER JOIN players p on s.playerID = p.playerID ),

bat_info AS(select teamID, 
ROUND(SUM(CASE WHEN bats ='R' then 1 else 0 END)/COUNT(playerid) *100,1) AS righty,
ROUND(SUM(CASE WHEN bats ='L' then 1 else 0 END)/COUNT(playerid)*100,1) AS lefty,
ROUND(SUM(CASE WHEN bats ='B' then 1 else 0 END)/COUNT(playerid)*100,1) AS both_h
FROM team_info 
GROUP BY teamID)

SELECT * from bat_info;



--  How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?
WITH ft as (SELECT ROUND(YEAR(debut),-1) as decade, AVG(height) as avg_height, AVG(weight)as avg_weight from players
GROUP BY decade) 

SELECT decade, 
avg_height - LAG(avg_height) OVER(ORDER BY decade) as height_diff,
avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff 
from ft 
WHERE decade is not null ; 










