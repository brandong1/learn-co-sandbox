# Understand Has-Many-Through relationships
# Construct indirect relationships between models (Customers, Waiters and Meals)
# Explore the concept of a 'joining' model
# Continue to write code using a Single Source of Truth

# In this lesson, we'll build out just such a relationship using waiters, customers, and meals. A customer has many meals, and a customer has many waiters through those meals. Similarly, a waiter has many meals, and has many customers through meals.

# BUILDING OUT OUR CLASSES
# Let's start by building out the Customer class and Waiter class. We want to make sure, when building out classes, that there's something to store each instance. That is to say: the Customer class should know about every customer instance that gets created.

class Customer

    attr_accessor :name, :age

    @@all =[] # The Customer class also has a class variable that tracks every instance of customer upon creation.

    def initialize(name, age)
        @name = name
        @age = age
        @@all << self
    end

    def self.all # Customer class knows every customer instance
        @@all
    end

    def new_meal(waiter, total, tip=0)
        Meal.new(waiter, self, total, tip)
    end
    # As you can see, we don't need to take customer in as an argument, because we're passing in self as reference to the current instance of customer. 
    # This method will allow us to create new meals as a customer, and automatically associate each new meal with the customer that created it. We can do the same thing for the Waiter class

    def meals
        Meal.all.select do |meal|
          meal.customer == self
       end
    end
     
    def waiters
        meals.map do |meal|
          meal.waiter
      end
    end
     
    def new_meal(waiter, total, tip=0)
        Meal.new(waiter, self, total, tip)
    end

    def new_meal_20_percent(waiter, total)
        tip = total * 0.2
        Meal.new(waiter, total, tip)
    end

    def self.oldest_customer
        oldest_age = 0
        oldest_customer = nil   
        self.all.each do |customer|
            if customer.age > oldest_age
                oldest_age = customer.age
                oldest_customer = customer
            end
        end
        oldest_customer
    end

end

class Waiter

    attr_accessor :name, :yrs_experience

    @@all

    def initialize(name, yrs_experience)
        @name = name
        @yrs_experience = yrs_experience
        @@all << self
    end

    def self.all
        @@all
    end

    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end

end

# setting up our Meal class as a 'joining' model between our Waiter and our Customer classes. And because we're obeying the single source of truth, 
# we're going to tell the Meal class to know all the details of each meal instance. That includes not only the total cost and the tip (which defaults to 0), but also who the customer and waiter were for each meal.

class Meal

    attr_accessor :waiter, :customer, :total, :tip

    @@all = []

    def initialize(waiter, customer, total, tip = 0)
        @waiter = waiter
        @customer = customer
        @total = total
        @tip = tip
        @@all << self

    end

    def self.all
        @@all
    end

    # In plain English, the customer is going to look at all of the meals, and then select only the ones that belong to them. 
    # This is pretty similar to how we're going to write it in code.

    def meals # We're iterating through every instance of Meal and returning only the ones where the meal's customer matches the current customer instance. 
        Meals.all.select do |meal|
            meal.customer == self
        end
    end

    # If our customer, Sam, wants to know about all of their meals, all we need to do is call the #meals method on that instance.
    # sam.meals will get an an array of all of Sam's meals, but what if we now want a list of all of the waiters that Sam has interacted with? 
    # We can simply reference the meals array! And since we have a method to get that array already, we can reuse that method.
        
    def waiters
        meals.map do |meal|
            meal.waiter
        end
    end

end