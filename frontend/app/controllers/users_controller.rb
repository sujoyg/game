class UsersController < ApplicationController
  before_filter { |c| c.send :authorize, root_path }

  def home
  end
end
