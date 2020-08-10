require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    voyels = ["a", "e", "i", "o", "u", "y"]
    consonnes = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]

    consonne = Array.new(5) { voyels.sample }
    voyel = Array.new(5) { consonnes.sample }
    @letters = consonne + voyel
  end

  def score
    if included?(params[:information], params[:letters])
      if verification == true
        @answer = "You succed"
      else
        @answer = "Not english"
      end
    else
      @answer = "It is not in the grid"
    end
  end

  def verification
    url = "https://wagon-dictionary.herokuapp.com/#{params[:information]}"
    word = open(url).read
    JSON.parse(word)["found"]
  end

  def included?(guess, grid)
    guess.split("").all? { |letter| grid.include? letter }
  end

end
