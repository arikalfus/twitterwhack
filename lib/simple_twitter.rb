module Simple_Twitter

  require_relative '../data/secrets' # For consumer key and access token
  require 'oauth'
  require 'json'
  require 'net/http' # Will also require 'uri'

  $url = 'https://api.twitter.com'

 def self.search(search_term)

    address = URI "#{$url}/1.1/search/tweets.json?q=#{search_term}&count=100"

    # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = Net::HTTP.new address.host, address.port
    http.use_ssl = true
    # noinspection RubyResolve
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    # Build request and authorize it with OAuth
    request = Net::HTTP::Get.new address.request_uri
    request.oauth! http, @consumer_key, @access_token

    # Issue request and return response.
    http.start
    response = http.request request

    if response.code == '200'
      JSON.parse(response.body)
    else
      nil
    end

  end

  private
  @consumer_key = OAuth::Consumer.new(
      $con_key,
      $con_secret)
  @access_token = OAuth::Token.new(
      $acc_token,
      $acc_secret)

  attr_reader :consumer_key, :access_token

end