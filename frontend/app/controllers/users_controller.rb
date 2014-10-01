require 'lib/people'

class UsersController < ApplicationController
  before_filter { |c| c.send :authorize, root_path }

  def home
    @person = People.all.sample
  end
end
