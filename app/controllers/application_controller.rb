
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  post '/articles' do 
    @article = Article.new(title: params[:title], content: params[:content])
    @article.save
    redirect "/articles/#{@article.id}"
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @found_article = found_article
    erb :show
  end

  get '/articles/:id/edit' do 
    @article = found_article
    erb :edit
  end

  patch '/articles/:id' do
    @article = found_article
    @article.assign_attributes(title: params[:title], content: params[:content])
    @article.save
    redirect "articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = found_article
    @article.destroy
    redirect "/articles"
  end

  def found_article
    Article.find_by(id: params[:id])
  end

end
