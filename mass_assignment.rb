def print_name_and_greeting(greeting, name)
  puts "#{greeting}, #{name}"
end
 
print_name_and_greeting("'sup", "Hillary Clinton")
  "'sup, Hillary Clinton"
    => nil
  
  
def happy_birthday(name, current_age)
  puts "Happy Birthday, #{name}"
  current_age += 1
  puts "You are now #{current_age} years old"
end
 
happy_birthday("Beyonce", 31)
  Happy Birthday, Beyonce
  You are now 32 years old
    => nil
  
  # But what happens if we accidentally pass the arguments in in the wrong order?
  
  happy_birthday(31, "Beyonce")
  Happy Birthday, 31
    => TypeError: no implicit conversion of Fixnum into String
    
# Keyword arguments are a special way of passing arguments into a method. They behave like hashes, pairing a key that functions as the argument name, with its value. 

def happy_birthday(name: "Beyonce", current_age: 31)
  puts "Happy Birthday, #{name}"
  current_age += 1
  puts "You are now #{current_age} years old"
end

# Same code as above but without default values 

def happy_birthday(name:, current_age:)
  puts "Happy Birthday, #{name}"
  current_age += 1
  puts "You are now #{current_age} years old"
end

happy_birthday(current_age: 31, name: "Carmelo Anthony")
  =>"Happy Birthday, Carmelo Anthony"
  => "You are now 32 years old"
  
  # Notice that even though we changed the order of our key/value pairs, our method didn't break! Not only is this method more robust (i.e. more resistant to breakage) than the previous one, it is also more explicit. Anyone looking at its invocation can tell exactly what kind of data you are passing in.
  
class Person
  attr_accessor :name, :age
 
  def initialize(name:, age:) # can take in a person's attributes as keyword arguments
    @name = name
    @age = age
  end
end

person_attributes = {name: "Sophie", age: 26}
sophie = Person.new(person_attributes)
  => #<Person:0x007f9bd5814ae8 @name="Sophie", @age=26>
