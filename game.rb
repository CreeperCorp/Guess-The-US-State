# Guess The US State - Advanced Maintainable Edition

require 'set'

US_STATES = [
  'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia',
  'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland',
  'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
  'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania',
  'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
  'West Virginia', 'Wisconsin', 'Wyoming'
]

# All 50 states adjacency list
STATE_NEIGHBORS = {
  "Alabama" => Set["Tennessee", "Georgia", "Florida", "Mississippi"],
  "Alaska" => Set[],
  "Arizona" => Set["California", "Nevada", "Utah", "Colorado", "New Mexico"],
  "Arkansas" => Set["Missouri", "Tennessee", "Mississippi", "Louisiana", "Texas", "Oklahoma"],
  "California" => Set["Oregon", "Nevada", "Arizona"],
  "Colorado" => Set["Wyoming", "Nebraska", "Kansas", "Oklahoma", "New Mexico", "Arizona", "Utah"],
  "Connecticut" => Set["New York", "Massachusetts", "Rhode Island"],
  "Delaware" => Set["Maryland", "Pennsylvania", "New Jersey"],
  "Florida" => Set["Alabama", "Georgia"],
  "Georgia" => Set["Florida", "Alabama", "Tennessee", "North Carolina", "South Carolina"],
  "Hawaii" => Set[],
  "Idaho" => Set["Montana", "Wyoming", "Utah", "Nevada", "Oregon", "Washington"],
  "Illinois" => Set["Indiana", "Kentucky", "Missouri", "Iowa", "Wisconsin"],
  "Indiana" => Set["Michigan", "Ohio", "Kentucky", "Illinois"],
  "Iowa" => Set["Minnesota", "Wisconsin", "Illinois", "Missouri", "Nebraska", "South Dakota"],
  "Kansas" => Set["Nebraska", "Missouri", "Oklahoma", "Colorado"],
  "Kentucky" => Set["Illinois", "Indiana", "Ohio", "West Virginia", "Virginia", "Tennessee", "Missouri"],
  "Louisiana" => Set["Texas", "Arkansas", "Mississippi"],
  "Maine" => Set["New Hampshire"],
  "Maryland" => Set["Virginia", "West Virginia", "Pennsylvania", "Delaware"],
  "Massachusetts" => Set["Rhode Island", "Connecticut", "New York", "Vermont", "New Hampshire"],
  "Michigan" => Set["Ohio", "Indiana", "Wisconsin", "Minnesota"], # via water for MN/WI
  "Minnesota" => Set["North Dakota", "South Dakota", "Iowa", "Wisconsin", "Michigan"], # via water for MI
  "Mississippi" => Set["Louisiana", "Arkansas", "Tennessee", "Alabama"],
  "Missouri" => Set["Iowa", "Illinois", "Kentucky", "Tennessee", "Arkansas", "Oklahoma", "Kansas", "Nebraska"],
  "Montana" => Set["North Dakota", "South Dakota", "Wyoming", "Idaho"],
  "Nebraska" => Set["South Dakota", "Iowa", "Missouri", "Kansas", "Colorado", "Wyoming"],
  "Nevada" => Set["Oregon", "Idaho", "Utah", "Arizona", "California"],
  "New Hampshire" => Set["Vermont", "Maine", "Massachusetts"],
  "New Jersey" => Set["New York", "Delaware", "Pennsylvania"],
  "New Mexico" => Set["Arizona", "Utah", "Colorado", "Oklahoma", "Texas"],
  "New York" => Set["Pennsylvania", "New Jersey", "Connecticut", "Massachusetts", "Vermont"],
  "North Carolina" => Set["Virginia", "Tennessee", "Georgia", "South Carolina"],
  "North Dakota" => Set["Minnesota", "South Dakota", "Montana"],
  "Ohio" => Set["Pennsylvania", "West Virginia", "Kentucky", "Indiana", "Michigan"],
  "Oklahoma" => Set["Colorado", "Kansas", "Missouri", "Arkansas", "Texas", "New Mexico"],
  "Oregon" => Set["Washington", "Idaho", "Nevada", "California"],
  "Pennsylvania" => Set["New York", "New Jersey", "Delaware", "Maryland", "West Virginia", "Ohio"],
  "Rhode Island" => Set["Connecticut", "Massachusetts"],
  "South Carolina" => Set["North Carolina", "Georgia"],
  "South Dakota" => Set["North Dakota", "Minnesota", "Iowa", "Nebraska", "Wyoming", "Montana"],
  "Tennessee" => Set["Kentucky", "Virginia", "North Carolina", "Georgia", "Alabama", "Mississippi", "Arkansas", "Missouri"],
  "Texas" => Set["New Mexico", "Oklahoma", "Arkansas", "Louisiana"],
  "Utah" => Set["Idaho", "Wyoming", "Colorado", "New Mexico", "Arizona", "Nevada"],
  "Vermont" => Set["New Hampshire", "Massachusetts", "New York"],
  "Virginia" => Set["North Carolina", "Tennessee", "Kentucky", "West Virginia", "Maryland"],
  "Washington" => Set["Idaho", "Oregon"],
  "West Virginia" => Set["Ohio", "Pennsylvania", "Maryland", "Virginia", "Kentucky"],
  "Wisconsin" => Set["Minnesota", "Iowa", "Illinois", "Michigan"],
  "Wyoming" => Set["Montana", "South Dakota", "Nebraska", "Colorado", "Utah", "Idaho"]
}

# State region mapping for advanced clues
STATE_REGIONS = {
  "Northeast" => Set["Maine","New Hampshire","Vermont","Massachusetts","Rhode Island","Connecticut","New York","New Jersey","Pennsylvania"],
  "Midwest" => Set["Ohio","Michigan","Indiana","Illinois","Wisconsin","Minnesota","Iowa","Missouri","North Dakota","South Dakota","Nebraska","Kansas"],
  "South" => Set["Delaware","Maryland","District of Columbia","Virginia","West Virginia","North Carolina","South Carolina","Georgia","Florida","Kentucky","Tennessee","Mississippi","Alabama","Oklahoma","Texas","Arkansas","Louisiana"],
  "West" => Set["Montana","Idaho","Wyoming","Colorado","New Mexico","Arizona","Utah","Nevada","California","Oregon","Washington","Alaska","Hawaii"]
}

# Time zone mapping for clues
STATE_TIMEZONES = {
  "Eastern" => Set["Maine","New Hampshire","Vermont","Massachusetts","Rhode Island","Connecticut","New York","New Jersey","Pennsylvania","Delaware","Maryland","District of Columbia","Virginia","West Virginia","North Carolina","South Carolina","Georgia","Florida","Ohio","Michigan","Indiana","Kentucky","Tennessee"],
  "Central" => Set["Alabama","Arkansas","Illinois","Iowa","Louisiana","Minnesota","Mississippi","Missouri","Oklahoma","Texas","Wisconsin","Kansas","Nebraska","North Dakota","South Dakota"],
  "Mountain" => Set["Arizona","Colorado","Idaho","Montana","New Mexico","Utah","Wyoming"],
  "Pacific" => Set["California","Nevada","Oregon","Washington"],
  "Alaska" => Set["Alaska"],
  "Hawaii-Aleutian" => Set["Hawaii"]
}

# Get region for a state
def get_us_region(state)
  STATE_REGIONS.each do |region, states|
    return region if states.include?(state)
  end
  "Unknown"
end

# Get time zone for a state
def get_us_time_zone(state)
  STATE_TIMEZONES.each do |zone, states|
    return zone if states.include?(state)
  end
  "Unknown"
end

# Get first letter clue
def first_letter_clue(state)
  state[0]
end

# Get length clue
def name_length_clue(state)
  state.length
end

# BFS to get the minimum number of borders (distance)
def bfs_distance(from_state, to_state, neighbors_hash)
  return 0 if from_state == to_state
  visited = Set[from_state]
  queue = [[from_state, 0]]
  until queue.empty?
    curr_state, dist = queue.shift
    neighbors = neighbors_hash[curr_state] || Set[]
    neighbors.each do |neighbor|
      return dist + 1 if neighbor == to_state
      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue << [neighbor, dist + 1]
      end
    end
  end
  nil # unreachable (e.g., HI/AK)
end

random_state = US_STATES.sample
guesses = 0
hint_level = 0

puts "Welcome to Guess The US State!"
while true
  print "What state do you guess?: "
  guessed_state = gets&.strip
  unless guessed_state
    puts "\nExiting."
    exit
  end

  unless US_STATES.include?(guessed_state)
    puts "That's not a valid US state!"
    next
  end

  guesses += 1

  if guessed_state == random_state
    puts "You guessed the state correctly, it was #{random_state}. It took you #{guesses} #{guesses == 1 ? "guess" : "guesses"}. Congratulations!"
    exit
  end

  # Special case for Hawaii/Alaska
  if [random_state, guessed_state].include?("Hawaii") || [random_state, guessed_state].include?("Alaska")
    puts "Hint: One of these states is not in the contiguous United States!"
  else
    distance = bfs_distance(guessed_state, random_state, STATE_NEIGHBORS)
    case distance
    when 1
      puts "Your guess borders the state."
    when 2
      puts "Your guess is 1 state away."
    when 3
      puts "Your guess is 2 states away."
    when 4
      puts "Your guess is 3 states away."
    when nil
      puts "Your guess is not connected (likely Alaska or Hawaii)."
    else
      puts "Your guess is more than 3 states away."
    end
  end

  # Advanced clues
  case guesses
  when 3
    puts "Clue: The state is in the #{get_us_region(random_state)} region."
  when 5
    puts "Clue: The state is in the #{get_us_time_zone(random_state)} time zone."
  when 7
    puts "Clue: The state starts with the letter '#{first_letter_clue(random_state)}'."
  when 9
    puts "Clue: The state name has #{name_length_clue(random_state)} letters."
  end
end
