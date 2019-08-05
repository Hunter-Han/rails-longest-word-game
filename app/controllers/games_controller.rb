class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @sample = []
    10.times do
      @sample << alphabet.sample
    end
  end

  def score
    'new.html.erb'
    @word = params[:query]
    sample_hash = @sample.each_with_object(Hash.new(0)) do |letter, hash|
      hash[letter] = @sample.count(letter)
    end

    attempt_serialized = open("https://wagon-dictionary.herokuapp.com/#{@word.downcase}").read
    analyze = JSON.parse(attempt_serialized)

    @result = "That's not an english word!" if analyze['found'] == false

    @word.upcase.chars do |letter|
      if sample_hash[letter].zero?
        @result = 'You used letters not in the grid!'
      else
        sample_hash[letter] -= 1
        @result = 'Well done!'
      end
    end
  end
end
