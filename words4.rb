# Flashcard Application

# Words for Fluency
##Inspiration
# According to Helen Doron's site http://www.helendoron.com/arch_fluent_english.php, 

# The amount of words needed for different levels of fluency are as follows: 

# Crawl' level: 400-500 words, about 150 phrases. You can make yourself somewhat understood and understand slow speech.
# Mini level: 800-1000 words and 300 phrases. Now you can speak relatively well and unstrained, and can read newspapers and books with the aid of a dictionary.
# Midi level: 1500-2000 words and more than 300 phrases. What you need for day to day conversations. During the course of one day you need approximately this amount of vocabulary, and you can take part in serious discussions and understand what is being said at normal speed.
# 3000-4000 words: Sufficient for reading newspapers and magazines fluently.
# 8000 words: All you ever need. More words are not necessary in order to communicate freely and read all types of literature.

# If one is learning an Indo-European language or something listed as fairly easy
# for native English speakers to learn, we can assume that to be able to read periodicals fluently, one will need to know at least 3000 words. If one studies and learns 30 words every day, this baseline level can be achieved in 100 days, a little over three months.

# The purpose of this application is to encourage the user to study and practice 30 words a day, and to review previously learned words. The application will keep track of how many words have been studied and will report progress to the user as they progress. When different levels of words have been achieved, the program will alert the user of what level they are at. 

# A user will be able to study different languages, and the program will eventually keep track of levels of different languages. 

##Long-Term Goals -- Not Working on Just Yet
# Write the code to send appropriate reminder message using Twilio
# There should be different flashcard sets for the words learned:
# Daily
# Every three days
# Every week
# Every two weeks
# Every three weeks
# Monthly
# Every two months
# Every three months

# Scan documents and count words which are not included in any flashcards submitted. 
#Be able to create flashcards from internet browsing and clipping. 
# Eventually, it would be nice to be able to label the words by part of speech, and to create flashcards based on that.
#Set target amount of words to study, which will be the i
# When studying, the user will have the option to study in the following ways:
# Type in the right answer - done
# Show a graph of language-learning progress

##End Long-Term Goals

# Done:
# Be Able To enter flashcards - done
# Option to enter directly into program - done

# Be able to review flashcards - done
# Be able to save results - done 
# -Save the date when flashcard deck was made - done 
#Read from file and put data into the appropriate array - done

#TODO
#Sort out the stack level too deep error - PROBLEM
# Deploy code on Heroku - Slightly daunting
# Set up Heroku scheduler to send out the email weekly (for now this will be at 4 PM CST)

#Send email or text messages using Twilio.
#Hi #{user},

# Here are your results for this week:

# Day 1: 
# Rounds completed: total_rounds
# Average percentage correct: total_rounds#{percentage_correct}
# Words to work on: #{words_wrong}
#Words studied to date: 
#Words mastered
 #--"Mastered" words are words that have been correct five times. 

#Repeats for rest of the days in the week, gives weekly average as well.



#User file that tracks how many decks, how many words total studied, how many words they've "mastered". 
#Count the number of words that have been studied to date, and how many have been mastered. 

#Program needs to be able to read date ranges - not sure how to do yet
#Program needs to be able to track errors per day
#Display list of .csv (flashcards) and select (for each language); store in appropriate directory
#Second, multiple-choice quiz function - generate list of possible four answers, have user enter "a", "b", "c", or "d". 
#Option to test self on words gotten wrong. Program will use the incorrect_answers
# array to generate a new quiz is user wants to test oneself on words he or she
# had difficulty with. 
#total_rounds = fixnum
#percentages_per_round = array

class Deck
@@total_decks = 0
@@all_decks_entered = []
attr_accessor :name

def initialize

	@deck = []
	@deck_hash = {}
	#Tracks the cards that are correct
	@correct_answers = []

	#Tracks the answers that are incorrect
	@incorrect_answers = []

	#Tracks the index of the pairs that been guessed correctly. To be used so 
	#correct answers aren't repeated.
	@correct_pair_indices = []
	@name = ""

	enter_deck

	@@all_decks_entered << self
	@@total_decks += 1

end



def self.display_all_decks
	puts 'Please choose a deck:'
	@@all_decks_entered.each do |deck|
		puts "Name: #{deck.name}"
		puts "-----"
	end
end

# def display_menu
# puts "Please select an option and type in your choice. /n /n"
# puts "1 - Make New Deck /n /n"
# puts "2 - Open Old Deck"
# answer = gets.chomp
# 	if answer == "1"
# 		enter_deck
# 	else
# 		retrieve_deck
# 	end
# end

def enter_deck
	puts "What do you want to name this deck? Enter 'date' if you would like to use today's date."
	@name = gets.chomp
	if @name.include?("date")
		@name = "#{Time.now.month}_#{Time.now.day}_#{Time.now.year}"
	end

	puts "Okay, this is the #{@name} deck."
		enter_pair

end

def return_deck_name
	@name
	end

	def enter_pair
		puts "\nPlease enter your pair and make sure to separate the terms by a comma.\n\nAn example is 'cat, feline'. Please enter 'done' to terminate. "
		input = gets.chomp

		if input.to_s == ''
			puts "This input is invalid. It doesn't look like you entered anything. Please re-enter the pair."
			puts " " 
			enter_pair

		elsif input.downcase.strip != "done"
			splitted = input.split(",")
			if splitted[1].to_s == ''
				puts "You didn't enter the second word. Please re-enter the pair."
				puts " " 
				enter_pair
			else @deck << splitted[0]
				@deck << splitted[1]
				puts "The French term is : #{splitted[0]}"
				puts "The English term is: #{splitted[1]}"
				puts "This is the deck #{@deck}."
				enter_pair
				end
		else
			make_deck_hash
			make_deck_csv
			puts "Completed. Here is your deck: #{@deck_hash}"


			puts "Would you like to take a quiz now? Please type 'y' if yes, or 'n' if no. "
			answer = gets.chomp
			while answer != 'y' && answer != 'n'
				puts "Sorry, that wasn't a valid selection. Please enter 'y' for yes or 'n' for no."
			end
			if answer == 'y'
				quiz
			else answer == 'n'
				u = User.new #hmmmm....
				u.display_menu
			end
			


		end
		



	end



#Change array into hash

def make_deck_hash 
	@deck_hash = Hash[*@deck]
end 

def display_deck
	puts @deck_hash
end

#modify_pair needs to be added for typos

#Not working properly..need to work on this
# def retrieve_pair
# french_words, english_words= CSV.read("#{@name}.csv")
# puts "French Words + #{french_words}"
# puts "English Words + #{english_words}" 
# end


def return_pair(num)
	pair = " #{@deck_hash.keys[num]} + #{@deck_hash.values[num]}"
end

def return_all_pairs
counter = 0

	while counter < @deck_hash.size
		puts "Pair #ei{counter+1}: #{@deck_hash.keys[counter]} + #{@deck_hash.values[counter]}"
		counter = counter + 1
	end

end
# def check_random_pair
# 		#checks the array numbers_used to make sure that pair number hasn't already been called. 
# 		#If it's been used, the method will be called again.
# 		#If it hasn't been used, the number will be used to create pull the question and correct
# 		#answer from the deck. 
# 		numbers_used = []
# 			if !numbers_used.include?(random_number)
# 				generate_random_pair
# 			else 
# 				#Displays a card randomly from the deck
# 				random_number = rand(@deck_hash.size)
# 				#question is a random key from @deck)hash
# 				question = @deck_hash.keys[random_number]
# 				#correct_answer is the corresponding key
# 				correct_answer = @deck_hash.values[random_number]
# 			end
# 		end

def generate_random_number
		rand_num = rand(@deck_hash.size)
		if @correct_pair_indices.include?(rand_num)
			generate_random_number
		else 
			return rand_num
		end
end

def quiz
	#Displays a key to the user and user has to type in the correct term. 
	#If the term is correct, moves on to next term. 
	#If term is incorrect, user is shown the answer and will be quizzed again. 
	#Keeps track of what cards have been presented to the user. 
	#Keeps track of the words that are wrong. If words are wrong, they remain in the deck. 
	#When all the cards have been answered correctly, user is presented with how many
	#times they got each word wrong and the percentage of words right on the first try. 


	##Need to make sure flashcard is not in correct_answers array. 
	
	# pair_number = generate_random_number

	# #question is a random key from @deck)hash
	# question = @deck_hash.keys[pair_number]
	# #correct_answer is the corresponding key
	# correct_answer = @deck_hash.values[pair_number]

	until @correct_answers.size == @deck_hash.size
		##Need to make sure flashcard is not in correct_answers array. 
		pair_number = generate_random_number
		#question is a random key from @deck)hash
		question = @deck_hash.keys[pair_number]
		#correct_answer is the corresponding key
		correct_answer = @deck_hash.values[pair_number]

		puts "#{@correct_answers.size} <-- Correct Answers' array size"
		puts "#{@deck_hash.size} <-- Deck Hash' array size"
	puts "The card is: #{question}" 
	user_answer = gets.chomp
	puts " " 
	puts " "
	puts " "
	puts " "
	puts " "

		if user_answer == correct_answer.strip.downcase
			#Put user_answers
			@correct_answers << user_answer
			@correct_pair_indices<< pair_number
			puts "You got it right!" 
			puts "Current correct answers: #{@correct_answers} \n"
			puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
		else
			@incorrect_answers << user_answer
			puts "Sorry, that isn't the right answer. \n\n"
			puts "The correct answer is #{correct_answer}. \n\n"
			puts "Current correct answers: #{@correct_answers} \n\n"
			puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
		end

	end
	puts "Quiz ended!"
	display_menu
end

require 'csv'

def make_deck_csv
#THIS WORKS! Let's make a method.

#Need to use string interpolation to make it customizable for different languages.  
headers = ["French Word/Phrase", "English Word/Phrase"]
CSV.open("#{@name}.csv", "w") do |csv|
  csv << headers
  @deck_hash.each_pair {|pair| csv << pair}
end
end

#modify_pair needs to be added for typos


def retrieve_deck
	@deck = []
	CSV.foreach("#{@name}.csv") do |row|
		splitted = row.join
		@deck<< splitted[0]
		@deck<< splitted[1]
		puts "Row: #{row}"
	end
	@deck.shift
	@deck.shift
	make_deck_hash
end


#Deck class ends here
end


#-------------------Next Class: The User Class----------------------

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

  attr_accessor :total_decks, :total_rounds, :percentage_words_correct, :incorrect_words, :total_words_studied, :deck_names_array 


  def initialize
    @total_decks =  0
    @deck_names_array = []
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


#Old Version to be deleted
# def display_menu
# 	puts "Please make a selection by entering the number next to the desired option."

# 	puts "1. Enter New Deck"
# 	puts "2. Display All Decks"
# 	puts "3. Exit the Program"

# 	answer = gets.chomp.strip

# 	  if answer == "1"
# 	    Deck.new
# 	  elsif answer == "2"
# 	  	puts "Hi!"
# 	  elsif answer == "3"
# 	  	puts "Thanks for studying!"
# 	  	Kernel.exit
# 	  else 
# 	    puts 'Sorry, that is not a valid selection. Please enter "1" or "2" .'
# 	    u.display_menu
# 	  end

# 	#display_menu ends
# 	end


def display_deck
	puts "Please make a selection by entering the number next to the desired option."
	puts "1. Enter New Deck"
	puts "2. Display All Decks"
	puts "3. Exit the Program"

	answer = gets.chomp.strip
	if answer == "1"
		Deck.new
	elsif answer == "2"
		Deck.display_all_decks
	elsif answer == "3"
		puts "Thanks for studying!"
		Kernel.exit
	else
		puts 'Sorry, that is not a valid selection. Please enter "1" or "2" .'
	end


# puts "Do you want to go back to the menu? Please enter 'y' or 'n'."
# answer = gets.chomp.strip

# while answer != 'n' || answer !='y'
# 	if answer == 'y'
# 		display_menu
# 	elsif answer == 'n'
# 		Kernel.exit
# 	else
# 		puts "Sorry, that is not a valid selection. Please enter 'y' or 'n'."
# 	end
end


	#User class ends
end


##We need to do a scrutiny of the deck-related
# methods in the User class. We may need to combine
# them into more succint methods and place them in the Deck
# class. 
# def new_deck
# 	ndeck = Deck.new
# 	ndeck.enter_deck
# 	dname = ndeck.return_deck_name
# 	add_deck_name(dname)
# 	@total_decks += 1
# end

# def add_deck_name(deck_name)
# 	@deck_names_array << deck_name
# end

# def display_all_decks
# puts "Here's the list of decks: #{@deck_names_array}"
# end








# #Automatically prompt user to enter deck and then start the quiz
# enter_deck
# # quiz
u = User.new
puts "User initalized"
puts "Displaying menu"
u.display_deck



