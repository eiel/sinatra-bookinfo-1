# coding:utf-8
require 'active_record'
require 'sinatra'
require 'erb'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

after do
  ActiveRecord::Base.connection.close
end

class Bookinfo < ActiveRecord::Base
end

get '/update' do
  @bookinfo = Bookinfo.find(params[:id])
  erb :update
end

post '/edit' do
      bookinfo = Bookinfo.find(params[:id])
      bookinfo.title = params['title']
      bookinfo.author = params['author']
      bookinfo.page = params['page']
      bookinfo.date_available = params['date_available']
      bookinfo.save
  redirect '/'
end

get '/retrieve' do
  erb :retrieve
end

post '/retrieve' do
  @bookinfos = Bookinfo.where( " title like ? OR author like ? ", "%#{params[:id]}%", "%#{params[:id]}%" )
  erb :result
end

get '/result' do
  erb :result
end

get '/' do
  @bookinfos = Bookinfo.all
  erb :index
end

post '/new' do
  bookinfo = Bookinfo.new
  bookinfo.id = params[:id]
  bookinfo.title = params[:title]
  bookinfo.author = params[:author]
  bookinfo.page = params[:page]
  bookinfo.date_available = params[:date_available]
  bookinfo.save
  redirect '/'
end

delete '/del' do
  bookinfo = Bookinfo.find(params[:id])
  bookinfo.destroy
  redirect '/'
end
