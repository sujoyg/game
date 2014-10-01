require 'lib/api'

class People
  def self.all
    JSON.parse(API.get 'users').map { |record| OpenStruct.new record }
  end
end