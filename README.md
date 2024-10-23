# Futbol

Starter repository for the [Turing School](h[ttps://turing.edu/](https://backend.turing.edu/module1/projects/futbol_pd/iterations/file_io_stats)) Futbol project.

Statistics
Each of the methods described below should be implemented as instance methods on StatTracker in order for the spec harness to work properly.

Game Statistics
Method	Description	Return Value
highest_total_score	Highest sum of the winning and losing teams’ scores	Integer
lowest_total_score	Lowest sum of the winning and losing teams’ scores	Integer
percentage_home_wins	Percentage of games that a home team has won (rounded to the nearest 100th)	Float
percentage_visitor_wins	Percentage of games that a visitor has won (rounded to the nearest 100th)	Float
percentage_ties	Percentage of games that has resulted in a tie (rounded to the nearest 100th)	Float
count_of_games_by_season	A hash with season names (e.g. 20122013) as keys and counts of games as values	Hash
average_goals_per_game	Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th)	Float
average_goals_by_season	Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th)	Hash
League Statistics
Method	Description	Return Value
count_of_teams	Total number of teams in the data.	Integer
best_offense	Name of the team with the highest average number of goals scored per game across all seasons.	String
worst_offense	Name of the team with the lowest average number of goals scored per game across all seasons.	String
highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
Season Statistics
These methods each take a season id as an argument and return the values described below.

Method	Description	Return Value
winningest_coach	Name of the Coach with the best win percentage for the season	String
worst_coach	Name of the Coach with the worst win percentage for the season	String
most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
most_tackles	Name of the Team with the most tackles in the season	String
fewest_tackles	Name of the Team with the fewest tackles in the season	String
