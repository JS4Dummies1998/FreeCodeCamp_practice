#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\n~~ WELCOME TO WORLDCUP DATABASE STATISTICS ~~\n---------------------------------------------"
sleep 4
echo -e "Fetching data..."
sleep 2
echo -e "Analyzing data..."
sleep 2
echo -e "# Analyze Completed #\nGenerating Results..."
echo -e "------------ WORLDCUP STATISTICS ------------\n"

echo -e "Total number of goals in all games from winning teams:"
sleep 0.5
echo  "= $($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
sleep 0.5
echo  "= $($PSQL "select sum(winner_goals) + sum(opponent_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
sleep 0.5
echo  "= $($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
sleep 0.5
echo  "= $($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
sleep 0.5
echo  "= $($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
sleep 0.5
echo  "= $($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
sleep 0.5
echo  "= $($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
sleep 0.5
echo  "$($PSQL "SELECT t.name FROM teams t JOIN games g ON t.team_id = g.winner_id WHERE winner_goals > opponent_goals AND year = 2018 AND round = 'Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
sleep 0.5
echo  "$($PSQL "SELECT t.name FROM teams t JOIN games g ON t.team_id = g.winner_id OR t.team_id = g.opponent_id WHERE year = 2014 AND round = 'Eighth-Final' ORDER BY t.name")"

echo -e "\nList of unique winning team names in the whole data set:"
sleep 0.5
echo  "$($PSQL "SELECT DISTINCT(t.name) FROM teams t JOIN games g ON t.team_id = g.winner_id ORDER BY t.name")"

echo -e "\nYear and team name of all the champions:"
sleep 0.5
echo  "$($PSQL "SELECT g.year, t.name FROM teams t JOIN games g ON t.team_id = g.winner_id WHERE g.round = 'Final' ORDER BY g.year")"

echo -e "\nList of teams that start with 'Co':"
sleep 0.5
echo  "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"
