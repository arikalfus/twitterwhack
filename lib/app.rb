# noinspection RubyResolve
require 'sinatra'
require 'json'
require_relative 'simple_twitter'

set :port, 3843
set :public_folder, File.dirname(__FILE__) + '/static'
enable :sessions

# HTTP entry points
get '/' do
  erb :name
end

get '/error' do
  erb :error, :layout => false
end

post '/form' do
  session[:name] = params[:name]
  erb :form, :locals => { :name => session[:name] }
end

post '/results' do
  first_word = params[:first]
  last_word = params[:second]

  first_result = Simple_Twitter.search first_word
  second_result = Simple_Twitter.search last_word
  whole_result = Simple_Twitter.search "#{first_word} #{last_word}"

  redirect to '/error' if first_result.nil? || second_result.nil? || whole_result.nil?

  erb :result, :locals => { :name => session[:name],
                            :words => [first_word, last_word],
                            :first_result => first_result['statuses'],
                            :second_result => second_result['statuses'],
                            :whole_result => whole_result['statuses'] }
end
