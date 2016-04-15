require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'

require './db_config'
require './models/volcanoe'
require './models/volcanoe_region'
require './models/comment'
require './models/user' 

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user

    #if current user
    #return true
    #else
    #return false
    #@end
  end
end


#List all of the Volcanoes in the DB on index page.
get '/' do
  # @all_volcanoes = run_sql('SELECT * FROM volcanoes;')
  # return params.inspect
  @volcanoe_regions = VolcanoeRegion.all
  #filter my volvanoes based on the selected volcanoe region id
  if params[:id]
    # if user pass in the id as a querystring
    @all_volcanoes = Volcanoe.where(volcanoe_region_id: params[:id])
else
    #just get all dishes
    @all_volcanoes = Volcanoe.all
end
  erb :index
end

#New Volcanoe Page
get '/volcanoes/new' do

  @volcanoe_regions = VolcanoeRegion.all
  erb :new
end

#Create a new Volcanoe
post '/volcanoes' do
  # @volcanoe_regions = VolcanoeRegion.all
  new_volcanoe = Volcanoe.new 
  new_volcanoe.name = params[:name]
  new_volcanoe.image_url = params[:image_url]
  new_volcanoe.height = params[:height]
  new_volcanoe.status = params[:status]
  new_volcanoe.volcanoe_region_id = params[:volcanoe_region_id]
  #volcanoe_region_id ????
  new_volcanoe.save
  # sql = "INSERT INTO volcanoes (name, image_url, height, status) VALUES ('#{ params[:name] }', '#{ params[:image_url] }', '#{ params[:height] }', '#{ params[:status] }');"
  # run_sql(sql)

  redirect to "/"

  # so this is another way you can write it, because Volcanoe is a class, and new is a Function, then you can put in the stuff as the params).
  # Volcanoe.new(params[:name], params[:image_url])
end

#Show a Single Volcanoe
get '/all_volcanoes/:id' do
  
  # sql = "SELECT * FROM volcanoes WHERE id=#{ params[:id] };"
  # results = run_sql(sql)
  @single_volcanoe = Volcanoe.find( params[:id] )
  @comments = @single_volcanoe.comments
  erb :volcanoe
end

#Run The Edit Command
patch '/volcanoes/:id' do
  #udpdate the existing dish
  volcanoe = Volcanoe.find(params[:id])
  volcanoe.name = params[:name]
  volcanoe.image_url = params[:image_url]
  volcanoe.height = params[:height]
  volcanoe.status = params[:status]
  volcanoe.volcanoe_region_id = params[:volcanoe_region_id]
  volcanoe.save

  # sql = "UPDATE volcanoes SET name = '#{ params[:name]}', image_url = '#{ params[:image_url] }', height = '#{ params[:height] }', status = '#{ params[:status] }' WHERE id = #{ params[:id] };"
  # run_sql(sql)
  redirect to '/'
end

#Exisiting Volcanoe Edit Page
get '/volcanoes/:id/edit' do
  @single_volcanoe = Volcanoe.find(params[:id])
  @volcanoe_regions = VolcanoeRegion.all 
  erb :edit
end

#Deleting single Volcanoe
delete '/all_volcanoes/:id' do
  single_volcanoe = Volcanoe.delete(params[:id])  
  # sql = "DELETE FROM volcanoes WHERE id = #{ params[:id] }"

  # run_sql(sql)
  redirect to '/'
end

post '/volcanoes/:volcanoe_id/comments' do
#create a new comment for volcanoe with volcanoe_id
comment = Comment.new
comment.body = params[:body]
comment.volcanoe_id = params[:volcanoe_id]
comment.save
redirect to "/all_volcanoes/#{ params[:volcanoe_id] }"
end


#log in form
get '/session/new' do
  erb :login
  end

#submitting the log in form
post '/session' do
  user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      #we're in! Create a new session. 
      session[:user_id] = user.id
      #redirect (to home)
      redirect to '/' 
        
    else
      #stay at the login form
      erb :login #keeping it to the same page instead of redirecting. 
    end
end


#submitting the log OUT button
delete '/session' do
      session[:user_id] = nil
      #redirect (to home)
      redirect to '/' 
    end







