# User Class

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

# total_rounds = number 
total_wrong_cards = []
total_cards_studied = []
total_cards_mastered = []
# average_per_day
# average_per_week

Tracking - weekly goals - did you hit your goal for this week?
A deck should be reviewed at least twice by the end of the week. 
If a deck hasn't been reviewed within four days, reminder should be sent. 
Deck has a minimum of thirty words. 
Should identify the source of the words. 


need a CSV containing each deck, total_times_deck_studied

def send_message
message = ""
Dear User,

Here are your statistics for this week. 
Rounds completed: total_rounds
Average percentage of correct words: total_rounds#{percentage_correct}
#Words to work on: 
#Words studied to date: 
#Words mastered

end
