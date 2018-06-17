class Person
  attr_accessor :name 
  @@all = []
  
  def initialize(name)
    @name = name
  end
  
  
  def self.all # self.all is a class method for reading the data stored in the class variable @@all
    @@all
  end
  
end

Person.new("Grace Hopper")
Person.new("Sandi Metz")

# How might you find a specific person by name given this Person model?

sandi_mets = Person.all.find {|person| person.name == "Sandi Metz"}
sandi_metz 
  #=> #<Person @name="Sandi Metz">
  
# Every time your application requires you to find a particular person by name, you will have to use #find or some sort of iteration logic on Person.all to find a specific instance of a person that has the name you want. #find will return a specific instance of a person, not an array. see the docs here This stinks! Writing Person.find over and over will quickly become unsustainable as your application grows.

# Instead of writing #find every time we want to search for an object, we can encapsulate this logic into a class method, like Person.find_by_name Instead of writing

  Person.find{|p| p.name == "Grace Hopper"}
  
# every single time we need to search, we can simply teach our Person class how to search by defining a class method:


class Person
  attr_accessor :name 
  @@all = []
  
  def initialize(name)
    @name = name
  end
  
  
  def self.all # self.all is a class method for reading the data stored in the class variable @@all
    @@all
  end
  
  def self.find_by_name(name) # We call class methods like Person.find_by_name 'finders'. Finder class methods are responsible for finding instances based on some property or condition.
    @@all.find {|person| person.name == name}
  end
  
end

Person.new("Grace Hopper")
Person.new("Sandi Metz")
 
sandi_metz = Person.find_by_name("Sandi Metz")
sandi_metz 
  #=> #<Person @name="Sandi Metz">
 
grace_hopper = Person.find_by_name("Grace Hopper")
grace_hopper 
  #=> #<Person @name="Grace Hopper">
 
avi_flombaum = Person.find_by_name("Avi Flombaum")
avi_flombaum 
  #=> nil
  # Avi hasn't been defined yet so it returns nil
  
  
class Person
  attr_accessor :name
  @@people = [] # changed from @@all
 
  def initialize(name)
    @name = name
    # self in the initialize method is our new instance
    # self.class is Person
    # self.class.all == Person.all
    self.class.all << self
  end
 
 # If the variable @@people changes names, we only have to update it in one place, the Person.all reader. All code that relies on that method still works. 1 conceptual change -> 1 line-of-code (LOC) change. Nice.
  def self.all # 
    @@people # changed from @@all
  end
 
  def self.find_by_name(name)
    self.all.find{|person| person.name == name}
  end
 
end

# Difference in code:

Person.all.find{|p| p.name == "Ada Lovelace"}
# literal implementation, no abstraction or encapsulation
# our program would be littered with this
 
Person.find_by_name("Ada Lovelace")
# abstract implementation with logic entirely encapsulated.
