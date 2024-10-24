require 'csv'

class StatTracker

  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    high_score = 0
    @games.each do |game|
      game_score = game[:home_goals].to_i + game[:away_goals].to_i
      if game_score > high_score
        high_score = game_score
      end
    end
    high_score
  end

  def lowest_total_score
    low_score = Float::INFINITY
    @games.each do |game|
      game_score = game[:home_goals].to_i + game[:away_goals].to_i
      if game_score < low_score
        low_score = game_score
      end
    end
    low_score
  end

  def percentage_home_wins
    games_played = @games.length
    home_wins = 0

    @games.each do |game|
      if game[:home_goals].to_i > game[:away_goals].to_i
        home_wins += 1
      end
    end
    win_percent = (home_wins.to_f / games_played.to_f) * 100
    win_percent.round(2)
  end
  
  def percentage_visitor_wins
    games_played = @games.length
    away_wins = 0
    
    @games.each do |game|
      if game[:home_goals].to_i < game[:away_goals].to_i
        away_wins += 1
      end
    end
    win_percent = (away_wins.to_f / games_played.to_f) * 100
    win_percent.round(2)
  end
  
  def percentage_ties
    games_played = @games.length
    ties = 0
    
    @games.each do |game|
      if game[:home_goals].to_i == game[:away_goals].to_i
        ties += 1
      end
    end
    win_percent = (ties.to_f / games_played.to_f) * 100
    win_percent.round(2)
  end

  def count_of_games_by_season
    seasons = Hash.new
    @games.each do |game|
      season = game[:season]
      if seasons[season]
        seasons[season] += 1
      else
        seasons[season] = 1
      end
    end
    seasons
  end

  def average_goals_per_game
    games_played = @games.length
    goals = 0

    @games.each do |game|
      goals += game[:home_goals].to_i
      goals += game[:away_goals].to_i
    end
    goals_per = (goals.to_f / games_played.to_f)
    goals_per.round(2)
  end


  def average_goals_by_season
    seasons = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }
    @games.each do |game| #0(n)
      season = game[:season]
      total_score = game[:home_goals].to_i + game[:away_goals].to_i

      seasons[season][:games_played] += 1
      seasons[season][:goals_scored] += total_score
    end
    seasons.each do |season, values| #0(m)
      seasons[season] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end
  end

  def count_of_teams
    @teams.length
  end

  def best_offense #best off of all time
    #highest avg number of goals per game
    #across all seasons
    # might still work with gt file
    # Create new Hash
    # loop through gt file
    # for each team we encounter, store goals and gamesplayed increase by 1
    # then loop through this new array and figure out the average goals scored per team
    # return the max
    # match game ID with team name

    teams = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }

    @game_teams.each do |game_team|
      team_id = game_team[:team_id]
      
      teams[team_id][:games_played] += 1
      teams[team_id][:goals_scored] += game_team[:goals].to_i
    end
    teams.each do |team_id, values|
      teams[team_id] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = teams.max_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def worst_offense 

    teams = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }

    @game_teams.each do |game_team|
      team_id = game_team[:team_id]
      
      teams[team_id][:games_played] += 1
      teams[team_id][:goals_scored] += game_team[:goals].to_i
    end
    teams.each do |team_id, values|
      teams[team_id] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = teams.min_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def highest_scoring_visitor
    visitor_teams = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }

    @game_teams.each do |game_team|
      team_id = game_team[:team_id]

      if game_team[:hoa] == "away"
        visitor_teams[team_id][:games_played] += 1
        visitor_teams[team_id][:goals_scored] += game_team[:goals].to_i
      end
    end

    visitor_teams.each do |team_id, values|
      visitor_teams[team_id] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = visitor_teams.max_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def lowest_scoring_visitor
    visitor_teams = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }

    @game_teams.each do |game_team|
      team_id = game_team[:team_id]

      if game_team[:hoa] == "away"
        visitor_teams[team_id][:games_played] += 1
        visitor_teams[team_id][:goals_scored] += game_team[:goals].to_i
      end
    end

    visitor_teams.each do |team_id, values|
      visitor_teams[team_id] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = visitor_teams.min_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def highest_scoring_home_team
    visitor_teams = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }

    @game_teams.each do |game_team|
      team_id = game_team[:team_id]

      if game_team[:hoa] == "home"
        visitor_teams[team_id][:games_played] += 1
        visitor_teams[team_id][:goals_scored] += game_team[:goals].to_i
      end
    end

    visitor_teams.each do |team_id, values|
      visitor_teams[team_id] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = visitor_teams.max_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def lowest_scoring_home_team
    visitor_teams = Hash.new { |hash, key| hash[key] = { games_played: 0, goals_scored: 0 } }

    @game_teams.each do |game_team|
      team_id = game_team[:team_id]

      if game_team[:hoa] == "home"
        visitor_teams[team_id][:games_played] += 1
        visitor_teams[team_id][:goals_scored] += game_team[:goals].to_i
      end
    end

    visitor_teams.each do |team_id, values|
      visitor_teams[team_id] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = visitor_teams.min_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def winningest_coach(season_id)
    #input = string of season id
    #ouput = string of coach name with the highest percentage of wins for the season
    #coach name lives in the game teams file
    #game file and game team file have team ID
    #compute data for given season
    # if we return team id we can get coach id easy
    # Need to use Game file to compute winningest team for a season
    # create a hash where key is season then nested within we will have teams as Key and their games won and games played as values
    season_stats = Hash.new { |hash, key| hash[key] = { games_played: 0, games_won: 0 } }

    @games.each do |game|
      home_team_id = game[:home_team_id]
      away_team_id = game[:away_team_id]
      if game[:season] == season_id #if the season of the game matches the season we're looking for
        if game[:home_goals] > game[:away_goals] # if the hometeam wins
          season_stats[home_team_id][:games_played] += 1
          season_stats[home_team_id][:games_won] += 1
          
          season_stats[away_team_id][:games_won] += 1
        elsif game[:home_goals] < game[:away_goals]
          season_stats[away_team_id][:games_played] += 1
          season_stats[away_team_id][:games_won] += 1
          
          season_stats[home_team_id][:games_played] += 1
        else
          season_stats[home_team_id][:games_played] += 1
          season_stats[away_team_id][:games_played] += 1
        end
      end
    end

    season_stats.each do |team_id, values|
      season_stats[team_id] = (values[:games_won].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = season_stats.max_by { |key, value| value }.first
    # require 'pry'; binding.pry
    
    @game_teams.find do |game_team| # binary search would speed this up
      # require 'pry'; binding.pry
      if game_team[:team_id] == desired_team_id 
        return game_team[:head_coach]
      end
    end
  end

  def worst_coach(season_id)

    season_stats = Hash.new { |hash, key| hash[key] = { games_played: 0, games_won: 0 } }

    @games.each do |game|
      home_team_id = game[:home_team_id]
      away_team_id = game[:away_team_id]
      if game[:season] == season_id #if the season of the game matches the season we're looking for
        if game[:home_goals] > game[:away_goals] # if the hometeam wins
          season_stats[home_team_id][:games_played] += 1
          season_stats[home_team_id][:games_won] += 1
          
          season_stats[away_team_id][:games_won] += 1
        elsif game[:home_goals] < game[:away_goals]
          season_stats[away_team_id][:games_played] += 1
          season_stats[away_team_id][:games_won] += 1
          
          season_stats[home_team_id][:games_played] += 1
        else
          season_stats[home_team_id][:games_played] += 1
          season_stats[away_team_id][:games_played] += 1
        end
      end
    end

    season_stats.each do |team_id, values|
      season_stats[team_id] = (values[:games_won].to_f / values[:games_played].to_f).round(2)
    end

    desired_team_id = season_stats.min_by { |key, value| value }.first
    # require 'pry'; binding.pry
    
    @game_teams.find do |game_team| # binary search would speed this up
      if game_team[:team_id] == desired_team_id 
        return game_team[:head_coach]
      end
    end
  end

  def most_accurate_team(season_id)
    #input = Season ID
    #output = name of team with the best shot to goal ratio
    #shot and goal stats live on gt file while season id lives on g
    #team name lives on team file and is linked by team_id
    #have to go through gt to get shot data
    # team_id => ratio
    #problem is how do we then break that down by season
    # track every game per team
    # team id = { game_id, shot_ratio}
    # then we go through the g file and if a g matches given season ID, team_id and a game_id w
    # e store that game in new hash as it belongs to that season and that team

    shot_stats = Hash.new { |hash, key| hash[key] = { shots: 0, goals: 0 } }
    games_this_season = {}
    
    @games.each do |game|
      if game[:season] == season_id
        games_this_season[game[:game_id]] = season_id
      end
    end
    @game_teams.each do |game_team|
      g_id = game_team[:game_id]
      t_id = game_team[:team_id]
      if games_this_season[g_id]
        shot_stats[t_id][:shots] += game_team[:shots].to_i
        shot_stats[t_id][:goals] += game_team[:goals].to_i
      end
    end
    shot_stats.each do |team, values|
      shot_stats[team] = (values[:goals].to_f / values[:shots].to_f)
    end

    desired_team_id = shot_stats.max_by { |key, value| value }.first
    # require 'pry'; binding.pry
    @teams.find do |team|
      if team[:team_id] == desired_team_id 
        return team[:teamname]
      end
    end
  end

  def least_accurate_team(season_id)

    shot_stats = Hash.new { |hash, key| hash[key] = { shots: 0, goals: 0 } }
    games_this_season = {}
    
    @games.each do |game|
      if game[:season] == season_id
        games_this_season[game[:game_id]] = season_id
      end
    end
    @game_teams.each do |game_team|
      g_id = game_team[:game_id]
      t_id = game_team[:team_id]
      if games_this_season[g_id]
        shot_stats[t_id][:shots] += game_team[:shots].to_i
        shot_stats[t_id][:goals] += game_team[:goals].to_i
      end
    end
    shot_stats.each do |team, values|
      shot_stats[team] = (values[:goals].to_f / values[:shots].to_f)
    end

    desired_team_id = shot_stats.min_by { |key, value| value }.first
    
    @teams.find do |team|
      if team[:team_id] == desired_team_id 
        return team[:teamname]
      end
    end
  end

  def most_tackles(season_id)
    tackle_stats = Hash.new { |hash, key| hash[key] = {tackles: 0}}
    games_this_season = {}

    @games.each do |game|
      if game[:season] == season_id
        games_this_season[game[:game_id]] = season_id
      end
    end

    @game_teams.each do |game_team|
      g_id = game_team[:game_id]
      t_id = game_team[:team_id]
      if games_this_season[g_id]
        tackle_stats[t_id][:tackles] += game_team[:tackles].to_i
      end
    end
    
    tackle_stats.each do |team, values|
      tackle_stats[team] = (values[:tackles])
    end
    
    desired_team_id = tackle_stats.max_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end

  def fewest_tackles(season_id)
    tackle_stats = Hash.new { |hash, key| hash[key] = {tackles: 0}}
    games_this_season = {}

    @games.each do |game|
      if game[:season] == season_id
        games_this_season[game[:game_id]] = season_id
      end
    end

    @game_teams.each do |game_team|
      g_id = game_team[:game_id]
      t_id = game_team[:team_id]
      if games_this_season[g_id]
        tackle_stats[t_id][:tackles] += game_team[:tackles].to_i
      end
    end
    
    tackle_stats.each do |team, values|
      tackle_stats[team] = (values[:tackles])
    end

    desired_team_id = tackle_stats.min_by { |key, value| value }.first

    @teams.find do |team|
      if team[:team_id] == desired_team_id
        return team[:teamname]
      end
    end
  end
end
