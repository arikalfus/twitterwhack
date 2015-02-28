# noinspection RubyResolve
require 'sinatra'
require 'oauth'
require 'json'

set :port, 3843

# HTTP entry points
get '/' do
  erb :name
end

post '/form' do
  erb :form, :locals => { :name => params[:name] }
end

get '/results' do
  erb :result
end

post '/calculate/whack' do
  first_word = params[:first]
  last_word = params[:second]
  erb :calculating, :locals => { :name => params[:name] }

  address = URI 'https://api.twitter.com/1.1/search/tweets.json'

end

