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
    if params[:name].downcase == params[:guess].downcase
      record_a_hit
    else
      record_a_miss
    end

    redirect_to home_path
  end
end
