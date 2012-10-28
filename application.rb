require 'sinatra/base'
require 'sprockets'
require 'sprockets-helpers'

class Application < Sinatra::Base
  set :assets, Sprockets::Environment.new(root)

  configure do
    assets.append_path File.join(root, 'assets', 'stylesheets')
    assets.append_path File.join(root, 'assets', 'javascripts')

    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = '/assets'
      config.digest      = true
    end
  end

  helpers do
    include Sprockets::Helpers
  end

  before do
    cache_control :public, :must_revalidate, :max_age => 60
  end

  get '/' do
    erb :index
  end
end
