require 'lib/people'
require 'lib/play'

class GameController < ApplicationController
  include GameHelper

  before_filter { |c| c.send :authorize, root_path }

  def autocomplete
    people = People.all

    pattern = params[:term].split.join('.*')
    render json: people.map(&:name).select { |name| name.downcase =~ /.*#{pattern}.*/ }
  end

  def check
    person = People.find params[:person_id]
    hit = person.name.downcase == params[:guess].downcase
    set_result hit
    over = get_rounds >= $globals.game.rounds
    if over
      Play.finish(current_user, get_score)
    end

    render json: {
        score: get_score,
        hit: hit,
        name: person.name,
        guess: params[:guess],
        over: over
    }
  end
end
