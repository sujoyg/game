# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl'

Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

require 'fakefs/spec_helpers'
require 'specstar/controllers'
require 'specstar/models'
require 'specstar/support/random'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.include FactoryGirl::Syntax::Methods
  config.include Specstar::Controllers::Matchers, :type => :controller
  config.include Specstar::Models::Matchers, :type => :model

  # Include all helpers in controller specs that are included by ApplicationController.
  ApplicationController.included_modules.each do |m|
    if m.to_s.ends_with? 'Helper'
      config.include m, :type => :controller
    end
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.before do
    [File, Dir].each do |klass|
      allow(klass).to receive(:mkdir).and_raise('Please use FakeFS!') unless File == FakeFS::File
    end
  end
end
