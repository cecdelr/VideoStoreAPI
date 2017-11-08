class MoviesController < ApplicationController
  def index
    movies = Movie.all
    render :json => movies, :each_serializer => CustomSerializerSerializer
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie
      render json: movie, status: :ok
    else
      render json: { ok: false }, status: :not_found
    end
  end

  def create
    movie = Movie.create(movie_params)

    if movie.valid?
      render(
        json: movie,
        status: :created
      )
    else
      render json: {errors: movie.errors.messages}, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:id, :title, :overview, :release_date, :inventory)
  end
end
