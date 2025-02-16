
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles' do
    @articles = Article.all.map{ |x| "#{x.title} #{x.content}"}.join(" ")
    erb :index
  end

  get '/articles/new' do
    Article.new
    erb :new
  end

  post '/articles' do
    article = Article.create(params)
    redirect "/articles/#{article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    Article.find(params[:id]).update(params[:article])
    redirect "/articles/#{params[:id]}"
  end

  delete "/articles/:id" do
    Article.find(params[:id]).destroy
  end
end
