class Dog 
  
  attr_accessor :name, :owner
  
  def initialize(name)
    @name = name
  end
  
end

fido.owner = "Sophie"
fido.owner

def adopted(dog, owner_name)
  dog.owner = owner_name
end

# Refactored Code Below

class Dog 
  
  attr_accessor :name, :owner 
  
  def initialize(name)
    @name = name
  end
  
  def bark
    "Woof!"
  end
  
  def get_adopted(owner_name)
    self.owner = owner_name
  end
  
end

# Here, we use the self keyword inside of the #get_adopted instance method to refer to whichever dog this method is being called on. We set that dog's owner property equal to the new owner's name by calling the #owner= method on self inside the method body.