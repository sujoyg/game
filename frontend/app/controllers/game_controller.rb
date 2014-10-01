require 'lib/people'

class GameController < ApplicationController
  before_filter { |c| c.send :authorize, root_path }

  def autocomplete
    people = People.all

    pattern = params[:term].split.join('.*')
    render json: people.map(&:name).select { |name| name.downcase =~ /.*#{pattern}.*/ }
  end

  def check

  end
end
