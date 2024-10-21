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
end