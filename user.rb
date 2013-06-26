# User Class

# Day 1: 
# Rounds completed: total_rounds
# Average percentage correct: total_rounds#{percentage_correct}
# Words to work on: #{words_wrong}
#Words studied to date: 
#Words mastered
 #--"Mastered" words are words that have been correct five times. 

#Repeats for rest of the days in the week, gives weekly average as well.



# #User file that tracks how many decks, how many words total studied, how many words they've "mastered". 
# #Count the number of words that have been studied to date, and how many have been mastered. 

# # total_rounds = number 
# total_wrong_cards = []
# total_cards_studied = []
# total_cards_mastered = []
# total_decks = number
# # average_per_day
# # average_per_week

# Tracking - weekly goals - did you hit your goal for this week?
# A deck should be reviewed at least twice by the end of the week. 
# If a deck hasn't been reviewed within four days, reminder should be sent. 
# Deck has a minimum of thirty words. 
# Should identify the source of the words. 


# need a CSV containing each deck, total_times_deck_studied

# def send_message
# message = ""
# Dear User,

# Here are your statistics for this w




# eek. 
# Rounds completed: total_rounds
# Average percentage of correct words: total_rounds#{percentage_correct}
# #Words to work on: 
# #Words studied to date: 
# #Words mastered

# end


# Process:

# (User enters deck)
#  the number of total decks, and  the number of total words are each incremented
# User does a quiz using the deck
# After the quiz is completed, the amount of times deck has been studied is incremented, we'll store
# this in the deck .csv file. 
# Using this data, we'll generate a message. 
# At the end of the week, Heroku will send out an email with statistics on
# how well the user has done. 

class User 

  attr_accessor :total_decks, :total_rounds, :percentage_words_correct, :incorrect_words, :total_words_studied 


  def initialize
    @total_decks =  0
    @deck_names = []
    @total_rounds = 0
    @percentage_words_correct = 0
    @incorrect_words = []
    @total_words_studied = 0 
  end


  def send_message
    #heredoc syntax for a block of text
   <<-MESSAGE
    Dear User,

    Here are your statistics for this week. 

    Total decks: #{@total_decks}
    Total words in all decks: #{@total_words_studied}
    Rounds completed: #{@total_rounds} 
    Average percentage of correct words: #{@percentage_words_correct}
    Words to work on: #{@incorrect_words}


  MESSAGE

  end





# def add_deck(deckname)

#   enter the filename
#   take filename and create a new deck with that filename
#   prompt user to enter cards, or the file location

# #Create a new deck
# deck = Deck.new(deck)

# #Enter the contents of the deck 
# deck.enter_deck

# #The user class keeps track of total decks a user has, and the names of those decks
# @total_decks += 1
# # @deck_names << deck.get_name
# end


def list_decks
puts @deck_names
end


def display_menu
puts "Please make a selection by entering the number next to the desired option."

puts "1. Enter New Deck"
puts "2. Display All Decks"

answer = gets.chomp.strip

  if answer == "1"
    new_deck
  elsif answer == "2"
    display_all_decks
  else 
    puts 'Sorry, that is not a valid selection. Please enter "1" or "2" .'
  end

#display_menu ends
end

#User class ends
end

def new_deck
Deck.enter_deck
end





# class Deck

# def initialize
#   @name = name
#   @cards = {"avoir"=>"to have"}
# end


# def enter_deck(filename)


# end

