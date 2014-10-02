require 'lib/people'

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

    render json: {
        score: get_score,
        hit: hit,
        name: person.name,
        guess: params[:guess],
        over: get_rounds >= $globals.game.rounds
    }
  end
end
