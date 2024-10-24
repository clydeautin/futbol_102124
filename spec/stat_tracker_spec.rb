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
      games: './spec/fixtures/g_fixture.csv',
      teams: './spec/fixtures/t_fixture.csv',
      game_teams: './spec/fixtures/gt_fixture.csv'
    }
    stat_tracker_f = StatTracker.from_csv(locations)

    expect(stat_tracker_f).to be_a(StatTracker)
  end

  describe 'Game Statistics' do
    it 'will return the highest total score' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.highest_total_score).to eq(5)
    end

    it 'will return the lowest total score' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.lowest_total_score).to eq(1)
    end

    it 'will return the perecentage of games that a home team has won' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.home_team_win_percent).to eq(70.00)
    end

    it 'will return the perecentage of games that an away team has won' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.away_team_win_percent).to eq(26.67)
    end

    it 'will return the perecentage of games that has resulted in a tie' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.tie_percent).to eq(3.33)
    end

    it 'will return a hash with season names as keys and counts of games as values' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.count_of_games_by_season).to be_a(Hash)
      expect(stat_tracker_f.count_of_games_by_season.keys).to eq(["20122013"])
    end
    
    it 'will return average goals per game' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.average_goals_per_game).to eq(3.73)
      
    end
    
    it 'will return average goals per season' do
      locations = {
        games: './data/games.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.average_goals_by_season).to be_a(Hash)
      expect(stat_tracker_f.average_goals_by_season.keys).to include("20122013")
    end
  end

  describe 'League Statistics' do
    it 'can count number of teams' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.count_of_teams).to eq(32)

    end

    it 'can return best offense' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.best_offense).to eq('FC Dallas')

    end

    it 'can return worst offense' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.worst_offense).to_not eq('FC Dallas')
      expect(stat_tracker_f.worst_offense).to eq('Sporting Kansas City')
      
    end
    
    it 'can return highest scoring visitor' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.highest_scoring_visitor).to eq('FC Dallas')
    end
    
    it 'can return lowest scoring visitor' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.lowest_scoring_visitor).to_not eq('FC Dallas')
      expect(stat_tracker_f.worst_offense).to eq('Sporting Kansas City')
    end
    
    it 'can return highest scoring home team' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.highest_scoring_home_team).to eq('LA Galaxy')
    end
    
    it 'can return lowest scoring home team' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)
      
      expect(stat_tracker_f.lowest_scoring_home_team).to eq('Sporting Kansas City')
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
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.most_accurate_team("20122013")).to eq("FC Dallas")
    end

    it 'can return the least accurate team' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.least_accurate_team("20122013")).to eq("Sporting Kansas City")
    end

    it 'can return the team with most tackles in a season' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.most_tackles("20122013")).to eq("FC Dallas")
    end

    it 'can return the team with fewest tackles in a season' do
      locations = {
        games: './spec/fixtures/g_fixture.csv',
        teams: './spec/fixtures/t_fixture.csv',
        game_teams: './spec/fixtures/gt_fixture.csv'
      }
      stat_tracker_f = StatTracker.from_csv(locations)

      expect(stat_tracker_f.fewest_tackles("20122013")).to eq("New England Revolution")
      expect(stat_tracker_f.fewest_tackles("20122013")).to_not eq("Sporting Kansas City")
    end
  end
end