class BreedsController < ApplicationController

  def index
    @breed = DogBreedFetcher.fetch
    @breed_list = DogBreedFetcher.fetch_breed_list
  end

  def show
    @breed = DogBreedFetcher.fetch(params[:name])
  end

end
