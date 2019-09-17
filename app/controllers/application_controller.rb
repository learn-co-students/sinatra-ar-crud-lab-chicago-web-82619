
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "hello world"
  end

  #wiwtd: view all the articles
  #raw: INDEX
  get '/articles' do
    @articles = Article.all
    erb :'/articles/index'
  end

  #wiwtd: add a newly filed submission to the database
  #raw: CREATE
  post '/articles' do
    article = Article.new(title: params[:title], content: params[:content])
    article.save
    # binding.pry
    redirect "articles/#{article.id}"
    # binding.pry
  end

  #what i want to do: visit a form to add a new article with content
  #rest action word: NEW
  get '/articles/new' do
    erb :'articles/new'
  end

  #wiwtd: view my newly created submission
  #raw: SHOW
  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb :'/articles/show'
  end

  #wiwtd: visit a form to edit an existing article
  #raw: EDIT
  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb :'/articles/edit'
  end

  #wiwtd: change existing record in the database with the newly submitted form information
  #raw: UPDATE
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    # binding.pry
    @article.assign_attributes(title: params[:title], content: params[:content])
    @article.save
    redirect "/articles/#{@article.id}"
  end

  #wiwtd: delete an existing record in the database
  #raw: DELETE
  delete '/articles/:id' do
    article = Article.find_by(id: params[:id])
    # binding.pry
    article.destroy
    redirect '/articles'
  end
end
