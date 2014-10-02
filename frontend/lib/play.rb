require 'lib/api'

class Play
  def self.finish(user, score)
    API.post 'game', {email: user.email, score: score}
  end

  def self.leaderboard
    JSON.parse API.get '/bestGames', {n: 50}
  end
end
