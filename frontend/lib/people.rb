require 'lib/api'

class People
  def self.all
    JSON.parse(API.get 'users').map { |person| OpenStruct.new person }
  end
end