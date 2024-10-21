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

  def home_team_win_percent
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
  
  def away_team_win_percent
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
  
  def tie_percent
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
    #no order for when we get season data
    # every time we increment hit a season we need to increment
    ## games played
    ## goals scored
    # {'20122013' => 3.3}
    # we come across a game
    # if the season already exists in our hash, 
    ## we go into that season hash and increment games played by 1
    ## goals scored += total score in that game
    # if the season does not exist
    ## create a new key with season id
    ## save games played as 1
    ## save goals scored as total score
    # run another loop through each season
    ## for each season divide goals scored by games played
    ## return a hash with season name as key and average goal scored as the value



    # games_played = 0
    # goals_scored = 0
    @games.each do |game|
      season = game[:season]
      total_score = game[:home_goals].to_i + game[:away_goals].to_i

      if seasons[season]
        seasons[season][:games_played] += 1
        seasons[season][:goals_scored] += total_score
      else
        seasons[season]
        seasons[season][:games_played] = 1
        seasons[season][:goals_scored] = total_score
      end
    end
    seasons.map do |season, values|
      seasons[season] = (values[:goals_scored].to_f / values[:games_played].to_f).round(2)
    end
    # require 'pry'; binding.pry
    seasons
  end
end
