class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end
  
  get '/figures/new' do
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :'/figures/new'
  end

  post '/figures' do
    # binding.pry
    if params[:figure][:name] != ""
      new_figure = Figure.create(params[:figure])
      if params[:title][:name] != ""
        new_figure.titles << Title.create(params[:title])
      end
      if params[:landmark][:name] != ""
        new_figure.landmarks << Landmark.create(params[:landmark])
      end
    else
      redirect '/figures/new'
    end
    redirect '/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :'/figures/update'
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    if params[:figure][:name] != ""
      figure.update(params[:figure])
      if params[:title][:name] != ""
        figure.titles << Title.create(params[:title])
      end
      if params[:landmark][:name] != ""
        figure.landmarks << Landmark.create(params[:landmark])
      end
    else
      redirect "/figures/#{figure.id}/edit"
    end
    redirect "/figures/#{figure.id}"
  end

end
