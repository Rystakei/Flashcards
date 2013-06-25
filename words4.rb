##Future Ideas
#open up saved deck and run the quiz
#Initialize method will call enter_deck, enter_pair, what else?



#Create a new deck by directly entering it into the program.

	@deck = []
	@deck_hash = {}
	#Tracks the cards that are correct
	@correct_answers = []

	#Tracks the answers that are incorrect
	@incorrect_answers = []

	#Tracks the index of the pairs that been guessed correctly. To be used so 
	#correct answers aren't repeated.
	@correct_pair_indices = []

	@name = "6_24_2013"

def display_menu
puts "Please select an option and type in your choice. /n /n"
puts "1 - Make New Deck /n /n"
puts "2 - Open Old Deck"
answer = gets.chomp
	if answer == "1"
		enter_deck
	else
		retrieve_deck
	end
end

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
	puts "Please enter your pair. Please enter Done to terminate. "
	input = gets.chomp

	if input.downcase.strip != "done"
		splitted = input.split(",")
		@deck << splitted[0]
		@deck << splitted[1]
		puts "The French term is : #{splitted[0]}"
		puts "The English term is: #{splitted[1]}"
		puts "This is the deck #{@deck}."
		enter_pair
	else
		make_deck_hash
		make_deck_csv
		puts "Completed. Here is your deck: #{@deck_hash}"
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
	
	pair_number = generate_random_number
	puts "This is the random number: #{pair_number}"
	puts "This is the size of the deck: #{@deck_hash}"

	#question is a random key from @deck)hash
	question = @deck_hash.keys[pair_number]
	#correct_answer is the corresponding key
	correct_answer = @deck_hash.values[pair_number]

	while @correct_answers.size < @deck_hash.size
	puts "The card is: #{question}" 
	user_answer = gets.chomp
	puts " " 
	puts " "
	puts " "
	puts " "
	puts " "

		if user_answer == correct_answer.strip.downcase
			@correct_answers << user_answer
			@correct_pair_indices<< pair_number
			puts "You got it right!" 
			puts "Current correct answers: #{@correct_answers} \n"
			puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
			#call quiz method again
			quiz
		else
			@incorrect_answers << user_answer
			puts "Sorry, that isn't the right answer. \n\n"
			puts "The correct answer is #{correct_answer}. \n\n"
			puts "Current correct answers: #{@correct_answers} \n\n"
			puts "Cards remaining: #{@deck_hash.size - @correct_answers.size} \n\n"
			#call quiz method again
			quiz
		end
	puts "Quiz ended!"
	end

	puts "This is where I left off. "

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






#Automatically prompt user to enter deck and then start the quiz
enter_deck
# quiz


