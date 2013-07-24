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
	@@checked_numbers = []
	
	attr_accessor :name, :cards, :deck_hash

	def initialize

		@cards = []
		@deck_hash = {}
		#Tracks the cards that are correct
		@correct_answers = []

		#Tracks the answers that are incorrect
		@incorrect_answers = {}

		#Tracks the index of the pairs that been guessed correctly. To be used so 
		#correct answers aren't repeated.
		@correct_pair_indices = []
		@name = ""

	end

	# #This was the old initialize method, but I'm calling it something different because it prompts the user to enter the information. If the user
	# is initializing a new Deck object when retrieving a deck, they shouldn't be prompted to manually enter the information. 
	def self.enter_new_deck
		d1 = Deck.new

		@cards = []
		@deck_hash = {}
		#Tracks the cards that are correct
		@correct_answers = []

		#Tracks the answers that are incorrect
		@incorrect_answers = []

		#Tracks the index of the pairs that been guessed correctly. To be used so 
		#correct answers aren't repeated.
		@correct_pair_indices = []
		@name = ""

		#enter_deck
		puts "What do you want to name this deck? Enter 'date' if you would like to use today's date."
		@name = gets.chomp
		if @name.include?("date")
			@name = "#{Time.now.month}_#{Time.now.day}_#{Time.now.year}"
		end

		puts "Okay, this is the #{@name} deck."
		# enter_pair
				puts "\nPlease enter your pair and make sure to separate the term and definition by a comma.\n\nAn example is 'cat, feline'. Please enter 'done' to terminate. "
		input = gets.chomp

		until input.downcase.strip == "done"
			splitted = input.split(",")
			if input.to_s == ''
				puts "This input is invalid. It doesn't look like you entered anything. Please re-enter the pair."
				puts " " 
			elsif splitted[1].to_s == ''
				puts "You didn't enter the second word. Please re-enter the pair."
				puts " " 
			elsif splitted[0].to_s != ''	
				@cards<< splitted[0]
			 	@cards << splitted[1]
				puts "The term is : #{splitted[0]}"
				puts "The definition is: #{splitted[1]}"
				puts "Please enter your next pair "
			else
				puts
			end
			input = gets.chomp
		end
		puts "This is what's in the cards array #{@cards}"
		make_deck_hash
		puts "The hash has been made. This is what's in it #{@deck_hash}"
		puts "This is the deck object: #{d1}"
		Deck.make_deck_csv(d1, @name, @deck_hash)
		@deck_hash = Deck.retrieve_deck(@name)
		puts "This is the deck #{@deck_hash}."
		puts "Completed."


		@@all_decks_entered << self
		@@total_decks += 1

		#end of enter_pair method


		puts "Would you like to take a quiz now? Please type 'y' if yes, or 'n' if no. "
		answer = gets.chomp
		while answer != 'y' && answer != 'n'
			puts "Sorry, that wasn't a valid selection. Please enter 'y' for yes or 'n' for no."
		end
		
		if answer == 'y'
			@deck_hash = Deck.retrieve_deck(@name)
			puts "This is d1's name :#{@name}"
			puts "This is d1's deck_hash :#{@deck_hash}"
			d1.quiz
		else answer == 'n'
			# u = User.new #hmmmm....
			Menu.display_menu
		end

	end


#This is a test method that I'll delete soon. 
	def short_enter_pair
		d1 = Deck.new
		@name = "d1"
		@deck_hash = {"deck"=>"hash"}
		d1.make_deck_csv(d1)
		s = "d1"

		puts "I've made a new deck, and saved it. It's name is #{@name} and it's hash is #{@deck_hash}."

		puts "I am retrieving it here...#{Deck.retrieve_deck(@name)}"

	end





	# def self.display_all_decks
	# 	puts 'Please choose a deck by entering the appropriate number, i.e. "1" for the first deck:'
	# 	puts 'If you would like to return to the main menu, please enter "0". ' 
	

	# 	counter = 0 
	# 	@@all_decks_entered.each do |deck|
	# 		counter += 1
	# 		puts "#{counter}: #{deck.name}"
	# 		puts "-----"
	# 	end
	# 	answer = gets.chomp.to_i
	# 	if answer == 0
	# 		Menu.display_menu
	# 	else
	# 		deck = @@all_decks_entered[answer-1]
	# 		deck_name = deck.name
	# 		puts "Here is the deck's name: #{deck_name}" 
	# 		Deck.retrieve_deck(deck_name)
	# 		puts "Your quiz will begin now." #We will insert additional options for type of quiz or to update the deck later on. 
	# 		deck.quiz
	# 	end

	# end

	def self.display_all_decks
		puts 'Please choose a deck by entering the appropriate number, i.e. "1" for the first deck:'
		puts 'If you would like to return to the main menu, please enter "0". ' 
		counter = 0
		#Iterate through the 'decks' folder and print out the name of each file to the user. 
		Dir.glob('decks/*.csv').each do |f|
			counter += 1
			puts "#{counter}. #{f[6..-5]} "
			deck_name = f[6..-5]
			@@all_decks_entered << deck_name

		end
		answer = gets.chomp.to_i
		#If user answers '0', display the menu
		if answer == 0
			Menu.display_menu
		#If the user enters a number, display the right deck. This probably needs a fix to account for incorrect entries like letters
		#or spaces. 
		else
			retrieved_deck_str = @@all_decks_entered[answer-1]
			puts "#{retrieved_deck_str.class} <-- This is the retrieved deck's class (should be string)"
			puts "Here is the string of the retrieved deck's name: #{retrieved_deck_str}" 
			d1 = Deck.new
			d1.deck_hash = Deck.retrieve_deck(retrieved_deck_str)

			# Display Deck Options Here
			puts "Please make a selection from the following. "
			puts "1. Review Deck"
			puts "2. Recall Quiz - Type in Your Response"
			puts "3. Multiple Choice Quiz"

			answer = gets.chomp
			if answer == "2"
				puts "Your quiz will begin now." #We will insert additional options for type of quiz or to update the deck later on. 
				d1.quiz
			elsif answer == "3"
				puts "Your quiz will begin now."
				d1.quiz_2
			end
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


	def enter_pair
		puts "\nPlease enter your pair and make sure to separate the term and definition by a comma.\n\nAn example is 'cat, feline'. Please enter 'done' to terminate. "
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
			else @cards<< splitted[0]
				@cards << splitted[1]
				puts "The term is : #{splitted[0]}"
				puts "The definition is: #{splitted[1]}"
				puts "This is the deck #{@deck}."
				enter_pair
			end
		else
			make_deck_csv
			puts "Completed."
		end

	end



#Change array into hash

	def self.make_deck_hash 
		@deck_hash = Hash[*@cards]
	end 


#modify_pair needs to be added for typos


	def save_user_info
		#Need to save the names of decks that a user has
		#Need to save how many times the deck has been reviewed
		#Need to save the average score each time the deck has been reviewed

	end


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
		puts "This is in the quiz method. The contents of the @deck_hash are #{@deck_hash}. "
		until @correct_answers.size == @deck_hash.size
			##Need to make sure flashcard is not in correct_answers array. 
			pair_number = generate_random_number
			#question is a random key from @deck)hash
			question = @deck_hash.keys[pair_number]
			#correct_answer is the corresponding key
			correct_answer = @deck_hash.values[pair_number]

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
				puts " " 
				puts "Current correct answers: #{@correct_answers} \n"
				puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
			else
				@incorrect_answers[question] = correct_answer
				puts "Sorry, that isn't the right answer. \n\n"
				puts "The correct answer is #{correct_answer}. \n\n"
				puts "Current correct answers: #{@correct_answers} \n\n"
				puts "You go these wrong: #{@incorrect_answers}"
				puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
			end

		end
		puts "Quiz ended!"
		puts "You need to work on the following terms: @incorrect_answers"
		Menu.display_menu
	end




def quiz_2
	# The deck is loaded. 
	# Four answers will be shown to the user at one time.
	# The user must then select the correct answer by typing a, b, c, or d. 
	# If the card is correct, it is added to the correct cards deck. 
	# Otherwise, the answer is recorded in the incorrect answers deck.
	# Each time a new card is pulled, we need to check if it is already in the correct cards deck.
	@choices = []
	# If it isn't, we need randomly generate another deck again. 

puts "This is in the quiz method. The contents of the @deck_hash are #{@deck_hash}. "
		while @correct_pair_indices.length < @deck_hash.size-3

			pair_number = generate_random_number
			#question is a random key from @deck)hash
			question = @deck_hash.keys[pair_number]
			#correct_answer is the corresponding key
			correct_answer = @deck_hash.values[pair_number]
			@choices << correct_answer
			#call method to generate three incorrect answers
			generate_wrong_answers
			
			#Display the card that is being tested
			puts "-------------------------"
			puts "The card is: #{question} \n \n"
			puts "Please enter the number of the answer you would like to choose: \n" 
			

			#shuffle the cards  and display the possible choices to the user
			counter = 1
			while counter <= @choices.length 
				@choices.shuffle!.each do |choice|
				
					puts "Choice #{counter}: #{choice} \n \n"
					counter += 1
					puts "The counter is currently at : #{counter}"
				end
			end
			#Get the user's answer
			puts "Please enter your answer: "
			user_answer = gets.chomp.to_i
			puts " \n \n \n \n \n" 

			if @choices[user_answer-1] == correct_answer
				#Put user_answers
				@correct_answers << @choices[user_answer-1]
				@correct_pair_indices<< pair_number
				puts "You got it right!"
				puts " " 
				puts "Deck hash size: #{@deck_hash.size} \n"
				puts "Correct answers size: #{@correct_answers.size}\n"
				puts "Current correct answers: #{@correct_answers} \n"
				puts "You got these wrong: #{@incorrect_answers}"
				puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"

			else
				@incorrect_answers[question] = correct_answer
				puts "Sorry, that isn't the right answer. \n\n"
				puts "The correct answer is #{correct_answer}. \n\n"
				puts "Current correct answers: #{@correct_answers} \n\n"
				puts "You got these wrong: #{@incorrect_answers}"
				puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
			end
			@choices = []

		end
		puts "Quiz ended!"
		puts "You need to work on the following terms: @incorrect_answers"
		Menu.display_menu
	end

@@checked_numbers = []

			#generate wrong answers that aren't the correct answer and haven't been gotten correct
			def generate_wrong_answers
			@current_wrong_pair_numbers = []

			#@current_wrong_answers holds the three possible incorrect answers a user may choose. 
			#The counter starts at 0 and is used in the loop so that three incorrect answers will be
			# generated. 
			counter = 0
			#While less than 3 cards have been counted, run the following loop and increment the counter appropriately
			while counter < 3
			#generate a random number that is less than or equal to the card size. This is the card that will be
			#tested. 
			rand_num = rand(@deck_hash.size)
				#Check if the selected card has already been gotten correct by the user and if this card has
				# already been selected to be tested during this question. If either of the conditions are true,
				# generate a new random number. 
				if @correct_pair_indices.include?(rand_num) || @choices.include?(@deck_hash.values[rand_num])
					puts "These are the numbers in the @correct_pair_indices #{@correct_pair_indices.sort}"
					puts "The current number is : #{rand_num}."
					puts "Is it included in the @correct_pair_indices? #{@correct_pair_indices.include?(rand_num)}"
					puts "Is it included in the @choices? #{@choices.include?(@deck_hash.values[rand_num])}"
					puts "the deck size is :#{@deck_hash.size}"
					generate_random_number
				#If the random number hasn't already been gotten correct and isn't already selected for the current question,
				# add the card's answer (value of the pair number that has randomly generated) to the choices array. 
				else 
					@choices << @deck_hash.values[rand_num]
					puts "These are the current choices: #{@choices}"
					puts "This number should not be among them: #{rand_num}"
					counter += 1
				end
				
			end
		end


	require 'csv'

	def self.make_deck_csv(deck, deck_name, deck_hash)
		puts "This method is at least running."
		puts "#{deck_hash}"
	#THIS WORKS! Let's make a method.
	# Need to use string interpolation to make it customizable for different languages.  
		headers = ["French Word/Phrase", "English Word/Phrase"]
		CSV.open("decks/#{deck_name}.csv", "w") do |csv|
	  	csv << headers
	  	deck_hash.each_pair {|pair| csv << pair}
		end
	end

#modify_pair needs to be added for typos

	def self.retrieve_deck(name)
		retrieved_deck = {}
		CSV.open("decks/#{name}.csv", "r", {:headers => :first_row}) do |csv|
			matches = csv.find_all do |row|
				key_value = row.to_s.split(",")
				key= row[0]
				value = row[1]	
				# puts row.class
				# puts row
				# retrieved_pair = {key => value} |this only pushes one pair in and overwrites the others
				retrieved_deck[key] = value
			end
		end
		return retrieved_deck
	end
# Old way 
	# def self.retrieve_deck(name)
	# 	@cards= []
	# 	CSV.foreach("decks/#{name}.csv") do |row|
	# 		splitted = row.join
	# 		puts splitted
	# 		@cards<< splitted[0]
	# 		@cards<< splitted[1]
	# 		puts "Row: #{row}"
	# 	end
	# 	@cards.shift
	# 	@cards.shift
	# 	deck = make_deck_hash
	# 	return deck
	# end

# def make_deck_csv(deck_name, deck_hash)
# 	#THIS WORKS! Let's make a method.

# 	#Need to use string interpolation to make it customizable for different languages.  
# 		headers = ["French Word/Phrase", "English Word/Phrase"]
# 		CSV.open("decks/#{deck_name}.csv", "w") do |csv|
# 	  	csv << headers
# 	  	deck_hash.each_pair {|pair| csv << pair}
# 		end
# 	end



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




	#User class ends
end

# #Automatically prompt user to enter deck and then start the quiz




class Menu


	def self.display_menu
		puts " "
		puts "Main Menu"
		puts " "
		puts "Please make a selection by entering the number next to the desired option."
		puts "1. Enter New Deck"
		puts "2. Display All Decks"
		puts "3. Exit the Program"

		answer = gets.chomp.strip
		if answer == "1"
			Deck.enter_new_deck
		elsif answer == "2"
			Deck.display_all_decks
		elsif answer == "3"
			puts "Thanks for studying!"
			Kernel.exit
		else
			puts 'Sorry, that is not a valid selection. Please enter "1", "2", or "3" .'
		end
	end

end



puts "Displaying menu"
Menu.display_menu


# class CardDeck

# 	def self.execute

		
# 	end

# end