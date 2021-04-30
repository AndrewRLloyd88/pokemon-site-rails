class PokemonController < ApplicationController
  def index
  end

  def search
    pokemon = find_pokemon(params[:number])

    unless pokemon
      flash[:alert] = 'Pokemon not found'
      return render action: :index
    end

    @pokemon_name = pokemon["name"].capitalize()
  end


  private
  def request_api(url)
    response = Excon.get(url)
    return nil if response.status != 200
    JSON.parse(response.body)
  end
  def find_pokemon(number)
    request_api("https://pokeapi.co/api/v2/pokemon/#{number}")
  end
end