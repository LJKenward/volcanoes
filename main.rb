     
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'

#Define a method to connect to the database
def run_sql(sql)
  db = PG.connect(dbname: 'volcanoes')
  results = db.exec(sql)
  db.close
  return results
end

#List all of the Volcanoes in the DB on index page.

get '/' do
  @all_volcanoes = run_sql('SELECT * FROM volcanoes;')
  erb :index
end

#New Volcanoe Page
get '/volcanoes/new' do
  erb :new
end

#Create a new Volcanoe
post '/volcanoes' do
  sql = "INSERT INTO volcanoes (name, image_url, height, status) VALUES ('#{ params[:name] }', '#{ params[:image_url] }', '#{ params[:height] }', '#{ params[:status] }');"
  run_sql(sql)
  redirect to "/"
end

#Show a Single Volcanoe
get '/all_volcanoes/:id' do
  sql = "SELECT * FROM volcanoes WHERE id=#{ params[:id] };"
  results = run_sql(sql)
  @single_volcanoe = results.first
  erb :volcanoe
end

#Run The Edit Command
patch '/volcanoes/:id' do
  sql = "UPDATE volcanoes SET name = '#{ params[:name]}', image_url = '#{ params[:image_url] }', height = '#{ params[:height] }', status = '#{ params[:status] }' WHERE id = #{ params[:id] };"
  run_sql(sql)
  redirect to '/'
end

#Update Exisiting Volcanoe Page
get '/volcanoes/:id/edit' do
  sql = "SELECT * FROM volcanoes WHERE id = #{ params[:id] };"
  results = run_sql(sql)
  @single_volcanoe = results.first
  erb :edit
end












