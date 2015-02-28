module Simple_Twitter

  require_relative '../data/secrets'

  consumer_key = OAuth::Consumer.new(
      @con_key,
      @con_secret)
  access_token = OAuth::Token.new(
      @acc_token,
      @acc_secret)

end