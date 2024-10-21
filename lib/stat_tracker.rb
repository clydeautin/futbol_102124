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
end
