require 'sinatra'

class PersonalDetailsApp < Sinatra::Base

	get '/' do
		erb :name
	end

	post '/name' do
		name = params[:name_input]
		redirect '/age?name=' + name
	end

	get '/age' do
		name = params[:name]
		erb :age, :locals => {name: name}
	end

	post '/age' do
		name = params[:name_input]
		age = params[:age_input]
		redirect '/fav_nums?age=' + age + '&name=' + name
		# "#{name} and #{age}"	
	end

	get '/fav_nums' do
		name = params[:name]
		age = params[:age]
		# "#{name} and #{age}"
		erb :fav_nums, locals: {name: name, age: age}
	end

	post '/fav_nums' do
		name = params[:name_input]
		age = params[:age_input]
		fav_num1 = params[:fav_num1_input].to_i
		fav_num2 = params[:fav_num2_input].to_i
		fav_num3 = params[:fav_num3_input].to_i
		sum = fav_num1 + fav_num2 + fav_num3
		"#{name}, #{age}, #{fav_num1}, #{fav_num2}, #{fav_num3} and #{sum}"
	end
end