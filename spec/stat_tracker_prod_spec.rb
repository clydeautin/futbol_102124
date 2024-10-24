require_relative 'spec_helper.rb'
require_relative '../lib/stat_tracker.rb'

RSpec.describe 'Stat Tracker' do 
  it 'exists' do
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
    stat_tracker = StatTracker.from_csv(locations)

    expect(stat_tracker).to be_a(StatTracker)
  end

  it 'will load fixture files' do
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }
    stat_tracker_f = StatTracker.from_csv(locations)

    expect(stat_tracker_f).to be_a(StatTracker)
  end

  describe 'Game Statistics' do
    it 'will return the highest total score' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.highest_total_score).to eq(11)
    end

    it 'will return the lowest total score' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.lowest_total_score).to eq(0)
    end

    it 'will return the perecentage of games that a home team has won' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.percentage_home_wins).to eq(43.5)
    end

    it 'will return the perecentage of games that an away team has won' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.percentage_visitor_wins).to eq(36.11)
    end

    it 'will return the perecentage of games that has resulted in a tie' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.percentage_ties).to eq(20.39)
    end

    it 'will return a hash with season names as keys and counts of games as values' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }

      expect(stat_tracker_f.count_of_games_by_season).to be_a(Hash)
      expect(stat_tracker_f.count_of_games_by_season).to eq expected
    end
    
    it 'will return average goals per game' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.average_goals_per_game).to eq(4.22)
      
    end
    
    it 'will return average goals per season' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }

      expect(stat_tracker_f.average_goals_by_season).to eq expected
    end
  end

  describe 'League Statistics' do
    it 'can count number of teams' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.count_of_teams).to eq(32)

    end

    it 'can return best offense' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.best_offense).to eq('Reign FC')

    end

    it 'can return worst offense' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.worst_offense).to_not eq('FC Dallas')
      expect(stat_tracker_f.worst_offense).to eq('Utah Royals FC')
      
    end
    
    it 'can return highest scoring visitor' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.highest_scoring_visitor).to eq('FC Dallas')
    end
    
    it 'can return lowest scoring visitor' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.lowest_scoring_visitor).to_not eq('FC Dallas')
      expect(stat_tracker_f.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end
    
    it 'can return highest scoring home team' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.highest_scoring_home_team).to eq('Reign FC')
    end
    
    it 'can return lowest scoring home team' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end

  describe 'Season Statistics' do
    it 'can return winningest coach for a given season' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.winningest_coach("20122013")).to eq("Glen Gulutzan")
    end

    it 'can return worst coach for a given season' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.worst_coach("20122013")).to_not eq("Glen Gulutzan")
      expect(stat_tracker_f.worst_coach("20122013")).to eq("Ron Rolston")
    end

    it 'can return the most accurate team' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(stat_tracker_f.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it 'can return the least accurate team' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.least_accurate_team("20132014")).to eq "New York City FC"
      expect(stat_tracker_f.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it 'can return the team with most tackles in a season' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(stat_tracker_f.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it 'can return the team with fewest tackles in a season' do
      locations = {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(stat_tracker_f.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end
end