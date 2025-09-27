import random
import sys
usStates = ['Washington', 'Oregon', 'California', 'Nevada', 'Idaho', 'Montana', 'Utah', 'Arizona', 'Alaska', 'Hawaii', 'New Mexico', 'Texas', 'Colorado', 'Wyoming', 'North Dakota', 'South Dakota', 'Nebraska', 'Kansas', 'Oklahoma', 'Missouri', 'Arkansas', 'Louisiana', 'Mississippi', 'Alabama', 'Iowa', 'Minnesota', 'Wisconsin', 'Illinois', 'Indiana', 'Kentucky', 'Ohio', 'Michigan', 'Virginia', 'West Virginia', 'New York', 'Pennsylvania', 'Florida', 'Georgia', 'South Carolina', 'North Carolina', 'Delaware', 'Maryland', 'Connecticut', 'Rhode Island', 'New Jersey', 'Maine', 'Vermont', 'New Hampshire', 'Massachusetts', 'Tennessee']
randomState = random.choice(usStates)
guesses = 0
stillPlaying = 1

while (stillPlaying == 1):
  guessedState = input('What state do you guess?: ')
  if (guessedState == randomState):
    guesses = guesses + 1
    stillPlaying = 0
    if (guesses == 1):
      print(f'You guessed the state correctly, it was {randomState}. It took you {guesses} guess, congratulations.')
      sys.exit(0)
    else:
      print(f'You guessed the state correctly, it was {randomState}. It took you {guesses} guesses.')
      sys.exit(0)
  else:
    guesses = guesses + 1
  if (randomState == 'Washington' and (guessedState == 'Oregon' or guessedState == 'Idaho')):
    print('Your guess borders the state')
  elif (randomState == 'Washington' and (guessedState == 'California' or guessedState == 'Montana' or guessedState == 'Nevada' or guessedState == 'Utah' or guessedState == 'Wyoming')):
    print('Your guess is 2 states away')
  elif (randomState == 'Washington' and (guessedState == 'North Dokata' or guessedState == 'South Dokata' or guessedState == 'Nebraska' or guessedState == 'Colorado' or guessedState == 'New Mexico' or guessedState == 'Arizona')):
    print('Your guess is 3 states away')
  elif (randomState == 'Washington'):
    print('Your guess is more than 3 states away')
  if (guesses >= 3 and randomState == 'Washington'):
    print('The state is on the left side of the US')
    
  if (randomState == 'Alaska' and (guessedState == 'Washington' or guessedState == 'Idaho' or guessedState == 'Montana' or guessedState == 'North Dakota' or guessedState == 'Minnesota' or guessedState == 'Wisconsin' or guessedState == 'Michigan' or guessedState == 'Illinois' or guessedState == 'Indiana' or guessedState == 'Ohio' or guessedState == 'Pennsylvania' or guessedState == 'New York' or guessedState == 'Vermont' or guessedState == 'New Hampshire' or guessedState == 'Maine')):
    print('The state is north')
  elif (randomState == 'Alaska'):
    print('Your guess is more than 2 states away')
     
  if (randomState == 'Hawaii' and (guessedState == 'California' or guessedState == 'Arizona' or guessedState == 'New Mexico' or guessedState == 'Texas' or guessedState == 'Louisiana' or guessedState == 'Mississippi' or guessedState == 'Alabama' or guessedState == 'Florida' or guessedState == 'Georgia' or guessedState == 'South Carolina' or guessedState == 'North Carolina' or guessedState == 'Virginia' or guessedState == 'Maryland' or guessedState == 'Delaware' or guessedState == 'New Jersey' or guessedState == 'Connecticut' or guessedState == 'Rhode Island' or guessedState == 'New York' or guessedState == 'New Hampshire' or guessedState == 'Maine' or guessedState == 'Massachusetts')):
    print('The state is south')
  elif (randomState == 'Hawaii'):
    print('Your guess is more than 2 states away')
  if (randomState == 'Oregon' and (guessedState == 'Washington' or guessedState == 'Idaho' or guessedState == 'Nevada' or guessedState == 'California')):
    print('Your guess borders the state')
  elif (randomState == 'Oregon' and (guessedState == 'Montana' or guessedState == 'Wyoming' or guessedState == 'Utah' or guessedState == 'Arizona' or guessedState == 'Hawaii' or guessedState == 'Alaska')):
    print('Your guess is 2 states away')
  elif (randomState == 'Oregon' and (guessedState == 'North Dakota' or guessedState == 'South Dakota' or guessedState == 'Nebraska' or guessedState == 'New Mexico' or guessedState == 'Colorado')):
    print('Your guess is 3 states away')
  elif (randomState == 'Oregon'):
    print('Your guess is more than 3 states away')
  if (guesses >= 3 and randomState == 'Oregon'):
    print('The state is on the left side of the US')
