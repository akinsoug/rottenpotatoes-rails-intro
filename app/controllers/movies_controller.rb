class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    @all_ratings = ["G", "PG", "PG-13", "R"]
    
 
    if params["ratings"]
      @filter = params["ratings"]
      @movies = Movie.where(rating: params["ratings"].keys)
    else
      @filter = @all_ratings
       @movies = Movie.all
    end  
    
    if(params["sort"])
      sort = params[:sort]
      @movies = @movies.order(params["sort"])

      if sort == "title"
        @title_header =  'hilite'
      else
        @release_date ='hilite'
      end
    end
    
  end



##############
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  
  # def load_ratings######################
  # @all_ratings = Movie.all_ratings
  # end

end



      # case sort
      # @movies = Movie.sort
      # when 'title'
      #   ordering,@title_header = {:order => :title}, 'hilite'
        
      # when 'release_date'
      #   ordering,@date_header = {:order => :release_date}, 'hilite'
      # end
      
    
    #@all_ratings = Movie.all_ratings
    
    #@movies = sort.Movies.all
    