require 'lib/people'

class UsersController < ApplicationController
  include GameHelper
  before_filter { |c| c.send :authorize, root_path }

  def home
    @person = People.all.sample
    @score = get_score
  end

  def on_login
    reset_game
    redirect_to home_path
  end
end
