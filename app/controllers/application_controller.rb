
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    @article = Article.new(title: params[:title], content: params[:content])
    @article.save
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = find_article
    erb :show
  end

  get '/articles/:id/edit' do
    @article = find_article
    erb :edit
  end

  patch '/articles/:id' do
    @article = find_article
    @article.update(title: params[:title], content: params[:content])
    redirect "articles/#{article.id}"
  end

  delete '/articles/:id' do
    @article = find_article
    @article.delete
    redirect "articles/index"
  end

  def find_article
    Article.find_by(id: params["id"])
  end

end
