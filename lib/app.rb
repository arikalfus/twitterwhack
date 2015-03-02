# noinspection RubyResolve
require 'sinatra'
require 'json'
require 'sinatra/formkeeper'
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
  # Build form validation rules
  form do
    filters :strip
    field :name, :present => true, :length => 1..20
  end

  # Check form validation
  if form.failed?
    erb :error, :locals => { :err_message => 'Name is invalid. Must be between 1 and 20 characters. Please press the back button on your browser.' }
  else
    session[:name] = params[:name]
    erb :form, :locals => { :name => session[:name] }
  end
end

post '/results' do
  # Build form validation rules
  form do
    filters :strip
    field :first, :present => true
    field :second, :present => true
  end

  # Check form validation
  if form.failed?
    if form.failed_on? :first
      erb :error, :locals => { :err_message => 'The first word was not present. Please press the back button on your browser.' }

    elsif form.failed_on? :second
      erb :error, :locals => { :err_message => 'The second word was not present. Please press the back button on your browser.' }
    end

  else
    # Begin Twitter API calls
    first_word = params[:first]
    last_word = params[:second]

    first_result = Simple_Twitter.search first_word
    second_result = Simple_Twitter.search last_word
    whole_result = Simple_Twitter.search "#{first_word} #{last_word}"

    redirect to '/error', :locals => { :err_message => 'Sorry, there was an error in accessing the Twitter API. One or more of the requests returned with an error code that was not 200 (did you enter values for the search words?).' } if first_result.nil? || second_result.nil? || whole_result.nil?

    erb :result, :locals => { :name => session[:name],
                              :words => [first_word, last_word],
                              :first_result => first_result['statuses'],
                              :second_result => second_result['statuses'],
                              :whole_result => whole_result['statuses'] }
  end

end
