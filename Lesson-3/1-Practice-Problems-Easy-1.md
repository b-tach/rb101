# Practice Problems: Easy 1

## Q1: What would you expect the code below to print out?
``` ruby
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
```
### A1: 
```
1
2
2
3
```

## Q2: Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:
1. what is `!=` and where should you use it?
2. put `!` before something, like `!user_name`
3. put `!` after something, like `words.uniq!`
4. put `?` before something
5. put `?` after something
6. put `!!` before something, like `!!user_name`

### A2:
First, `!` and `?` may have multiple meanings depending on where they are used. `!` may be used as a boolean negation as part of an expression or when part of a method name an indicator that the method mutates its caller. When used as part of an expression, `?` is part of a terniary operator. When part of a method name, it communicates to the human reader-of-code that the method is a predicate returning a boolean value.
Answers to numbered questions:
1. What is `!=` and where should you use it? `!=` is the inequality operator which returns `true` if its operand values are not equal to each other. Placement in the expression is right between its two operands.
2. Put `!` before something, like `!user_name`. When placed before part of an expression (in this case, the variable/function/symbol `user_name` *is* an expression), `!` negates `user_name`'s truthiness. Remember that all expressions have a truthiness of `true` except for `false` and `nil`.
3. Put `!` after something, like `words.uniq!`. When its placement after the name of a method is itself a valid method, the method it calls performs the same logic with one exception: instead of merely returning its computed value, it instead *mutates* its caller to equal that value (and generally returns that value too, just like its non-mutating twin).
4. Put `?` before something. I have yet been unable to find documentation or internet answers to this. I have found that when prefixing *only* a single character, it returns that single character as a string. For example,
```
irb> ?a
=> "a"
irb> ?2
=> "2"
irb> ?6 + ?r
=> "6r"
irb> ?\
=> "\n" # ???
irb> puts ?\

=> nil
irb> puts "Hi" + ?\ + "there."
Hi there.
=> nil
irb> puts "Hi" + "\n" + "there."
Hi
there.
=> nil
```
It does not work when prefixing multiple characters. As you can see, when prefixing a backslash, it outputs an interesting string, "\n". It does not seem to behave like an escaped newline nor does it seem to behave like its literal representation, but more like a space when printed.
5. Put `?` after something. When used as a suffix for a variable, Ruby throws an error that differs depending on what you are assigning to the variable whose name ends with `?`. However, it seems fine to use it as a suffix for a method name. In this case, it communicates that the method returns a boolean value.
6. Put `!!` before something, like `!!user_name`. When placed before an expression (whether that expression is a variable or method), `!!` in effect double-negates the truthiness of that expression, resulting in either `true` or `false`. If the expression is truthy (any value except `false` and `nil`), then double-negating that expression will result in `true`. And if the expression's value is `false` or `nil`, the result of double-negating it will be `false`.

## Q3: Replace the word "important" with "urgent" in this string:
``` ruby
advice = "Few things in life are as important as house training your pet dinosaur."
```
### A3:
``` ruby
advice.gsub!('important', 'urgent')
```

## Q4: 
```ruby
numbers = [1, 2, 3, 4, 5]
```
What do the following method calls do (assume we reset `numbers` to the original array between method calls)?
```ruby
numbers.delete_at(1)
numbers.delete(1)
```
### A4:
`numbers.delete_at(1)` will remove the array element at index 1, which is the integer `2`. This value will then be returned.
`numbers.delete(1)`, will, however, delete every array element equivalent to `1`. This too will be returned.

## Q5: Programmatically determine if 42 lies between 10 and 100.
hint: Use Ruby's range object in your solution.
### A5:
```ruby
(10..100).include?(42)
```
You can also use
```ruby
(10..100).cover?(42)
```
to determine if the argument is in range.

## Q6: Starting with the string:
```ruby
famous_words = "seven years ago..."
```
show two different ways to put the expected "Four score and " in front of it.
### A6:
One way is
```ruby
"Four score and " << famous_words
```
This does not modify famous_words, but is merely an expression whose value is the concatination of the two strings into our desired string.
To modify `famous_words` with this technique, you can
```ruby
famous_words = "Four score and " << famous_words
```
There are so many ways to build a string. Another way is
```ruby
famous_words_corrected = "Four score and " + famous_words
```

## Q7: Basically turn
```ruby
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
``` 
which results in 
```ruby
["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
```
into an unnested array.
### A7:
```ruby
flintstones.flatten!
```

## Q8: Given the has below, Turn this into an array containing only two elements: Barney's name and Barney's number.
```ruby
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
```
### A8: 
```ruby
flintstones.slice('Barney').to_a.flatten
```
An easier way is
```ruby
flintstones.assoc('Barney')
```