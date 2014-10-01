require 'lib/api'

class UsersController < ApplicationController
  before_filter { |c| c.send :authorize, root_path }

  def home
    @people = JSON.parse(API.get 'users').map { |person| OpenStruct.new person }
  end
end
