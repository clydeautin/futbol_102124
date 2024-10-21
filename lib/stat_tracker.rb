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
    @games.map do |game|
      game_score = game[:home_goals].to_i + game[:away_goals].to_i
      if game_score > high_score
        high_score = game_score
      end
    end
    high_score
  end

end
