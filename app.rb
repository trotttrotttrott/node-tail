require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/config_file'

class App < Sinatra::Base
  register Sinatra::ConfigFile
  helpers  Sinatra::JSON

  config_file "#{File.dirname(__FILE__)}/config/settings.yml"

  configure :development do
    require 'debugger'
    enable :show_exceptions
    register Sinatra::Reloader
  end

  get '/' do
    haml :index
  end

  get '/tail' do

    return (status 400; json :success => false, :message => 'unauthorized file requested') unless settings.authorized_files.include?(params[:file])

    file = File.open(params[:file], 'r')
    lines = file.readlines
    from = params[:from].to_i
    from = lines.size - 5 unless (1..lines.size).include? from
    tail = lines[from..-1].join
    json :success => true, :tail => tail, :from => from, :to => lines.size
  end
end
