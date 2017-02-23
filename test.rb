require 'minitest/autorun'
require 'rack/test'
require_relative '../app.rb'

class TestApp < Minitest::Test
	include Rack::Test::Methods

	def app
		PersonalDetailsApp
	end

	def test_ask_name_on_entry_page
		get '/'
		assert(last_response.ok?)
		assert(last_response.body.include?('Hello, what is your name?'))
		assert(last_response.body.include?('<input type="text" name="name_input">'))
		assert(last_response.body.include?('<form method= "post" action= "/name">'))
		assert(last_response.body.include?('<input type="submit" value="submit">'))
	end

	def test_post_to_name
		post '/name', name_input: 'Thomas'
		follow_redirect!
		assert(last_response.body.include?('Thomas'))
		assert(last_response.ok?)
	end

	def test_get_age
		get '/age?name=Thomas'
		assert(last_response.body.include?('Hello Thomas, how old are you?'))
		assert(last_response.ok?)
	end

	def test_post_to_age
		post '/age', age_input: '24', name_input: 'Thomas'
		follow_redirect!
		assert(last_response.body.include?('24'))
		assert(last_response.ok?)
	end

	def test_get_fav_nums
		get '/fav_nums?age=24&name=Thomas'
		assert(last_response.ok?)
		assert(last_response.body.include?('Thomas'))
		assert(last_response.body.include?('24'))
  		assert(last_response.body.include?('<form method="post" action="/fav_nums">'))
  		assert(last_response.body.include?('<input type="number" name="fav_num1_input">'))
 		assert(last_response.body.include?('<input type="number" name="fav_num2_input">'))
 		assert(last_response.body.include?('<input type="number" name="fav_num3_input">'))
	end

	def test_post_to_fav_nums
		post '/fav_nums', fav_num1_input: '7', fav_num2_input: '4', fav_num3_input: '3', age_input: '24', name_input: 'Thomas'
		assert(last_response.body.include?('7'))
		assert(last_response.body.include?('4'))
		assert(last_response.body.include?('3'))
		assert(last_response.ok?)
	end
end