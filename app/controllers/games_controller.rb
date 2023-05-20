require 'open-uri'

class GamesController < ApplicationController
  ALPHABET = ('A'..'Z').to_a

  def new
    @@letters = []
    i = 0
    10.times do
      @@letters[i] = ALPHABET.sample
      i += 1
    end
    @array = []
    @array = @@letters
  end

  def score
    # raise
    @array = []
    @array = @@letters

    word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    resultApi = JSON.parse(URI.open(url).read)

    result = true
    if (resultApi["found"] === true)
      @wordChars = word.upcase.split('')

      @wordChars.each do |char|
        @array.include?(char) === false ? result = false : result
      end

      if(result === false)
        @message = "Sorry but #{word} can't be built out of #{@array.join(',')}"
      else
        @message = "Congratulations! #{word} is a valid English word!"
      end
    else
      @message = "Sorry but #{word} does not seem to be a valid English word..."
    end
  end

end
