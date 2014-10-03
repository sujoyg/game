require 'lib/people'
require 'lib/play'

class GameController < ApplicationController
  include GameHelper

  before_filter do |c|
    params[:action] == 'leaderboard' ? true : c.send(:authorize, root_path)
  end

  def autocomplete
    people = People.all

    pattern = params[:term].split.join('.*')
    render json: people.map(&:name).select { |name| name.downcase =~ /.*#{pattern}.*/ }
  end

  def check
    person = People.find params[:person_id]
    set_result person, params[:guess]

    if get_rounds >= $globals.game.rounds
      Play.finish(current_user, get_score)
    end

    hit, name, guess, email = get_last_round

    render json: {
        score: get_score,
        hit: hit,
        name: name,
        email: email,
        guess: guess,
        remaining: $globals.game.rounds - get_rounds
    }
  end

  def leaderboard
    @leaderboard = Play.leaderboard
  end
end
