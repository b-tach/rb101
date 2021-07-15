# Pseudocode exercise

# 1. a method that returns the sum of two integers
# START
# method start, arguments number1, number2
# result = number1 + number2
# return result
def add(number1, number2)
  result = number1 + number2
  return result
end
puts "1 + 3 is #{add(1, 3)}"


# 2. a method that takes an array of strings, and returns a string that is all those strings concatenated together
# method concat_array_of_strings(string_array)
#   SET result to an empty string
#   loop through each element of string_array,
#    append each element's value to result
#    return result
def concat_array_of_strings(string_array)
  result = ""
  string_array.each do | str |
    result = result + str
  end
  return result
end
concat_test = ["one", "two", "three"]
puts "array of strings: #{concat_test}"
puts "concatenated: #{concat_array_of_strings(concat_test)}"


# 3. a method that takes an array of integers, and returns a new array with every other element
# method every_other_element(integer_array)
#   set result to an empty array
#   iterate through integer_array
#     if index if element is odd, then append its value to the end of result
#   return result
