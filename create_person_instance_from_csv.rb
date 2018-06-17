class Person
  attr_accessor :name, :age, :company
end

csv_data = "Elon Musk, 46, 
Mark Zuckerberg, 32, Facebook
Martha Stewart, 74, MSL"

rows = csv_data.split("\n")
people = rows.collect do |row|
  data = row.split(", ")
  name = data[0]
  age = data[1]
  company = data[2]
  person = Person.new 
  person.name = name
  person.age = age 
  person.company = company
  person
end

people
#=> [
  #<Person @name="Elon Musk"...>,
  #<Person @name="Mark Zuckerberg"...>,
  # ...
# ]
# Pretty complex. We don't want to do that throughout our application. In an ideal world, every time we got CSV data we'd just want the Person class to be responsible for parsing it. Could we build something like Person.new_from_csv? Of course! Let's look at how we might implement a custom constructor.


class Person
  attr_accessor :name, :age, :company
  
  def self.new_from_csv(csv_data)
    # Split the CSV data into an array of individual rows.
    rows = csv_data.split("\n")
    # For each row, let's collect a Person instance based on the data
    people = rows.collect do |row|
      # Split the row into 3 parts, name, age, company, at the ", "
      data = row.split(", ")
      name = data[0]
      age = data[1]
      company = data[2]
    
      # Make a new instance 
      person = self.new   # self refers to the Person class. This is Person.new
      # Set the properties on the person.
      person.name = name
      person.age = age 
      person.company = company
      # Return the person to collect
      person
    end
    # Return the array of the newly created people
    people
  end
end

csv_data = "Elon Musk, 45, Tesla
Mark Zuckerberg, 32, Facebook
Martha Stewart, 74, MSL"

people = Person.new_from_csv(csv_data)
people #=> [
  #<Person @name="Elon Musk"...>,
  #<Person @name="Mark Zuckerberg"...>,
  # ...
# ]
 
new_csv_data = "Avi Flombaum, 31, Flatiron School
Payal Kadakia, 30, ClassPass"
 
people << Person.new_from_csv(new_csv_data)
people #=> [
#<Person @name="Elon Musk"...>,
#<Person @name="Mark Zuckerberg"...>
#<Person @name="Martha Stewart"...>,
#<Person @name="Avi Flombaum"...>,
#<Person @name="Payal Kadakia"...>
# ]