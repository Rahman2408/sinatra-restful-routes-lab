class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

    get '/recipes' do 
      erb :index
    end

   

    get '/recipes/new' do 
      erb :new 
    end
   
    
    post '/recipes/new' do 
      @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
      @recipe.save
      redirect "/recipes/#{@recipe.id}"
    end

    
    get '/recipes/:id' do 
      @recipe= Recipe.find(params[:id])
      
      erb :show
    end

    post '/recipes' do 
      @recipe = Recipe.create(params)
      redirect "/recipes/#{@recipe.id}"
    end

    delete '/recipes/:id' do 
      @recipe = Recipe.find(params[:id])
      @recipe.delete
      redirect '/recipes'
    end

    get '/recipes/:id/edit' do
      @recipe = Recipe.find(params[:id])
      erb :edit 
    end

    patch '/recipes/:id/edit' do
      @recipe = Recipe.find(params[:id])
 
      @recipe.update(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients])
      redirect "/recipes/#{@recipe.id}"
    end
end
