require 'csv'
require 'open-uri'

class Score
  def initialize
    file = open("https://raw.githubusercontent.com/turingschool/posse_challenges/master/college_scorecard/2013_college_scorecards.csv")
    file = CSV.new(file)
  end
end

Score.new
