ENV['RACK_ENV'] ||= 'development'

require_relative 'data_mapper_setup'


require 'sinatra/base'
# require './app/models/bookmark.rb'
# require './app/models/tag.rb'
# require './app/models/user.rb'
require 'database_cleaner'


# ENV['RACK_ENV'] ||= 'development'
# p ENV['RACK_ENV']

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :sign_up
  end

  get '/links' do
    @links = Bookmark.all
    @user_email = session[:email]
    erb :links
  end

  get '/links/new' do
    erb :new
  end

  post '/links' do
    bookmark = Bookmark.first_or_create(url: params[:url], title: params[:title])
    # tag = Tag.new(name: params[:tags])
    params[:tags].split.each do |tag|
      bookmark.tags << Tag.first_or_create(name: tag)
    end
    # bookmark.tags << tag
    bookmark.save
    # bookmark = Bookmark.create(url: params[:url], title: params[:title], tags: [Tag.new(name: params[:tags])])
    redirect '/links'
  end

  get '/tags/:name' do
   tag = Tag.first(name: params[:name])
   @links = tag ? tag.bookmarks : []
   erb :'/links'
  end

  post '/sign_up' do
    user = User.create(email: params[:email], password: params[:password])
    p User.create(email: params[:email], password: params[:password])
    p User.all
    session[:email] = params[:email]
    session[:user_id] = user.id
    user.save
    redirect '/links'
  end

  helpers do
   def current_user
     @current_user ||= User.get(session[:user_id])
   end
  end

  run! if app_file == $0

end
