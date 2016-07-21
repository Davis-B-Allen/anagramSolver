# Write a program to find all words (checked against the complete scrabble word list) that can be formed from a certain set of letters
# There are 8 optional letters (any or all of which can be used) and one essential letter, which MUST be used in every word
# Note that the set of letters may include the same letter twice or more. If the set includes x instances of a given letter, x instances of that letter (but no more) may be used in a found word
# Acceptable solution words must have 4 or more letters




# Read in the word list

# Create a new hash, a dictionary anagram hash
# For each word in the dictionary, downcase it, sort its letters alphabetically, and enter the original word into an array serving as value for a key in the dictionary anagram hash where the key is the alphabetically sorted string of letters

# Prompt user to enter optional letters for the daily puzzle
# Prompt user to enter the essential letter for the daily puzzle

# From the set of optional letters in the puzzle, find all combinations of 3 letters, 4 letters, etc, up to 8 letters; then add the essential letter to each of these combinations

# For each unique combination, use that combination as a key to look up the value in the dictionary anagram hash. This should return an array; all elements in this array should be added to a full solution set.

MIN_WORD_SIZE = 4

anagramDict = Hash.new

f = File.open("words.txt", "r")
f.each_line do |word|
  # downcase line
  word.downcase!
  word.chomp!
  # sort line into alphabetic order
  alphabetizedWord = word.chars.sort.join
  # check if the anagramDict hash has a key of the alphabetizedWord; if it does, add word to the array that is the corresponding value; if it doesnt, create that key and map it to an array with word as the only element
  if anagramDict[alphabetizedWord]
  	anagramDict[alphabetizedWord] << word
  else
  	anagramDict[alphabetizedWord] = [word]
  end
end
f.close 

optionalLetters = ""
requiredLetter = ""

while optionalLetters.length < 3
	print "Please enter the optional letters (minimum 3): "
	optionalLetters = gets.chomp
end

while requiredLetter.length != 1
	print "Please enter the required letter (exactly 1): "
	requiredLetter = gets.chomp
end

anagramKeys = []

for i in MIN_WORD_SIZE-1..optionalLetters.length
	# find all combinations of 3 letters from amongst the set of optional letters
	comboOptionals = optionalLetters.chars.combination(i).to_a.uniq.map { |x| x.join("") }

	# create an array of all unique combinations of 3 letters from the optional set plus the required letter
	combo = comboOptionals.map! { |x| x << requiredLetter }
	combo.map! { |x| x.chars.sort.join }
	combo.uniq!

	anagramKeys += combo
end

solutionSet = []

for alphabeticallyOrderedString in anagramKeys
	if anagramDict[alphabeticallyOrderedString]
		solutionSet += anagramDict[alphabeticallyOrderedString]
	end
end

puts "\nSolutions:\n\n"

puts solutionSet

puts "\n#{solutionSet.length} results\n\n"























