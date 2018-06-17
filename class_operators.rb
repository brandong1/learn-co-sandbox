class Person
  attr_accessor :name
  @@all = []
  def self.all
    @@all
  end
 
  def initialize(name)
    @name = name
    @@all << self
  end
 
  def self.normalize_names
    self.all.each do |person|
      person.name = person.name.split(" ").collect{|w| w.capitalize}.join(" ")
    end
  end
end
# The logic for actually normalizing a person's name is pretty complex. 
# person.name.split(" ").collect{|w| w.capitalize}.join(" ")

# What we're doing is splitting a name, like "ada lovelace", into an array at the space, " ", returning ["ada", "lovelace"]. With that array we collect each word into a new array after it has been capitalized, returning ["Ada", "Lovelace"]. We then join the elements in that array with a " " returning the final capitalized name, "Ada Lovelace".

# Given how complex normalizing a person's name is, we should actually encapsulate that into the Person instance.

class Person
  attr_accessor :name
  @@all = []
  def self.all
    @@all
  end
 
  def initialize(name)
    @name = name
    @@all << self
  end
  
  def normalize_name 
    self.name.split(" ").collect {|w| w.capitalize}.join(" ")
  end
  
  def self.normalize_names
    self.all.each do |person|
      person.anme = person.normalize_name
    end
  end
end

# With #normalize_name, we've taught a Person instance how to properly convert its name into a capitalized version. The class method that acts on the global data of all people is simplified and delegates the actual normalization to the original instances. This is a common pattern for global class operators.

# Another example of this type of global data manipulation might be deleting all the people. We would build a Person.destroy_all class method that will clear out the @@all array.

class Person
  attr_accessor :name
  @@all = []
  def self.all
    @@all
  end
 
  def initialize(name)
    @name = name
    @@all << self
  end
 
  def self.destroy_all
    self.all.clear
  end
end

# Here our Person.destroy_all method uses the Array#clear method to empty the @@all array through the class reader Person.all.