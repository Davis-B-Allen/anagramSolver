# Script to solve for the daily POLYWORD puzzle from the Telegraph newspaper
# Author: Davis Allen

# Rules:

# Write a program to find all words (checked against the complete scrabble word list) that can be formed from a certain set of letters
# There are 8 optional letters (any or all of which can be used) and one essential letter, which MUST be used in every word
# Note that the set of letters may include the same letter twice or more. If the set includes x instances of a given letter, x instances of that letter (but no more) may be used in a solution word
# Acceptable solution words must have 4 or more letters

MIN_WORD_SIZE = 4

# Initialize a new hash, to be used to store arrays of anagrams mapped to a string of the alphabetically sorted letters contained within those anagrams
# The relevant keys will be determined by finding combinations of letters based on user input of the requried and optional letter(s)
anagramDict = Hash.new
anagramKeys = []
solutionSet = []
optionalLetters = ""
requiredLetter = ""

# Read in the complete Scrabble list of approved words and store each within the anagram array corresponding to the relevant alphabetized key
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

# Prompt user for the optional letters. User must enter at least 3; typical POLYWORD has 8
while optionalLetters.length < 3
	print "Please enter the optional letters (minimum 3): "
	optionalLetters = gets.chomp
end

# Prompt user for the required letter. There must be precisely one
while requiredLetter.length != 1
	print "Please enter the required letter (exactly 1): "
	requiredLetter = gets.chomp
end

# Populate an array of relevant anagram keys by finding all combinations of 4 or more letters, using the required letter and 3 or more of the optional letters
for i in MIN_WORD_SIZE-1..optionalLetters.length
	# find all combinations of 3 letters from amongst the set of optional letters
	comboOptionals = optionalLetters.chars.combination(i).to_a.uniq.map { |x| x.join("") }

	# create an array of all unique combinations of 3 letters from the optional set plus the required letter
	combo = comboOptionals.map! { |x| x << requiredLetter }
	combo.map! { |x| x.chars.sort.join }
	combo.uniq!

	anagramKeys += combo
end

# Populate an array of solutions using the Anagram Dictionary Hash
for alphabeticallyOrderedString in anagramKeys
	if anagramDict[alphabeticallyOrderedString]
		solutionSet += anagramDict[alphabeticallyOrderedString]
	end
end

# Print solutions found from user input
puts "\nSolutions:\n\n"

puts solutionSet

puts "\n#{solutionSet.length} results\n\n"


