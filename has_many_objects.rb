# Using Artist class
#

class Artist
    attr_accessor :name

    def initialize(name)
        @name = name
        @songs = [] # Whenever a new Artist is created, I am initializing their name and a songs array to store all their songs
    end

    def add_song(song) # Creating a method to add songs to the song array
        @songs << song # Shoveling the name of the song that gets passed as an argument into the songs array.
    end
end

# Now I can execute the following code:

jay_z = Artist.new("Jay-Z") # Creating a new Artist
jay_z.add_song("99 Problems") # Adding a new song
jay_z.add_song("Crazy in Love") # Adding a new song

# Now we need a method that will allow a given artist to show us all of the songs in their collection.

class Artist
    attr_accessor :name

    def initialize(name)
        @name = name
        @songs = [] # Whenever a new Artist is created, I am initializing their name and a songs array to store all their songs
    end

    def add_song(song) # Creating a method to add songs to the song array
        @songs << song # Shoveling the name of the song that gets passed as an argument into the songs array.
    end

    def songs # An instance method that we can call on an individual artist to return the list of songs that artist has.
        @songs # The #songs method simply returns the @songs array, which contains the list of songs that the artist has many of.
    end
end

# So, if I run this code:
jay_z.songs
  # => ["99 Problems", "Crazy in Love"] It returns the array, with the two songs from the Artist

# Let's ask jay_z to tell us the genres of the songs he has many of.
#Oh no! We can't do that because jay_z's songs are simply a list of strings. We can't ask a plain old string what genre it has—it will have no idea what we are talking about.

# This is the limitation of one-sided relationships. Just like associating a given song to a string that contains an artist's name instead of to a real Artist instance had its drawbacks, 
# so too does associating a given artist to a list of strings. With this set up, we are limited to references to a given artist's songs by their name alone. We cannot associate any further
# information to an artist's songs or enact any further behavior on an artist's songs.
    
# Let's fix this now. Instead of calling the #add_song method with an argument of a string, let's call that method with an argument of a real song object:

ninetynine_problems = Song.new("99 Problems", "rap")
crazy_in_love = Song.new("Crazy in Love", "pop")
 
jay_z.add_song(ninetynine_problems)
jay_z.add_song(crazy_in_love)
 
jay_z.songs
    # =>[#<Song:0x007fa96a878348 @name="99 Problems", @genre="rap">, #<Song:0x007fa96a122580 @name="Crazy in Love", @genre="pop">]

# Great, now our artist has many songs that are real, tangible Song instances, not just strings.

# We can do a number of useful things with this collection of real song objects, such as iterate over them and collect their genres:

jay_z.songs.collect do |song|
    song.genre
end
    # => ["rap", "pop"]

# Although we do have an attr_accessor for artist in our Song class, this particular song doesn't seem to know that it belongs to Jay-Z. That is because our 
# add_song method only accomplished associating the song object to the artist object. Our artist knows it has a collection of songs and knows how to add songs to that collection. But, we didn't tell the song that we added to the artist that it belonged to that artist.

# Let's fix that now. Telling a song that it belongs to an artist should happen when that song is added to the artist's @songs collection. Consequently, we will write the code that accomplishes this inside our #add_song method:

class Artist
    attr_accessor :name
   
    def initialize(name)
      @name = name
      @songs = []
    end
   
    def add_song(song)
      @songs << song
      song.artist = self # Telling the song object that it belongs to the Artist
    end
   
    def songs
      @songs
    end
  end

  # Here, we use the self keyword to refer to the artist on which we are calling this method. We call the #artist= method on the song that is being passed in as an argument and set it equal to self––the artist.

  jay_z.add_song(crazy_in_love)
  crazy_in_love.artist.name # Asking the song for it's artist
    # => "Jay-Z"

# As it currently stands, we have to first create a song and then add it to a given artist's collection of songs. We are lazy programmers, if we could combine these two steps, that would make us happy. 
# Furthermore, if you think about our domain model, i.e. the program we are writing to model the real-world environment of an artist and their songs, the current need to create a song and then add it to an artist doesn't really make sense. A song doesn't exist before an artist creates it.

# Instead, let's build a method #add_song_by_name, that takes in an argument of a name and genre and both creates the new song and adds that song to the artist's collection.

class Artist
    ...
   
    def add_song_by_name(name, genre) # a method #add_song_by_name, that takes in an argument of a name and genre and both creates the new song and adds that song to the artist's collection.
      song = Song.new(name, genre)
      @songs << song
      song.artist = self
    end

    Since we've already set up these great associations between instances of the Song and Artist class, we can use them to build other helpful methods.

Currently, to access the name of a given song's artist, we have to chain our methods like this:

crazy_in_love.artist.name
  # => "Jay-Z"

# Chaining methods is not very elegant. Wouldn't it be nice if we have one simple and descriptive method that could return the name of a given song's artist? Let's build one!

class Song
  ...
 
  def artist_name # descriptive method that could return the name of a given song's artist
    self.artist.name
  end

# Now we can call:

crazy_in_love.artist_name
  # => "Jay-Z"

# Much better. Notice that we used the self keyword inside the #artist_name method to refer to the instance of Song on which the method is being called. Then we call #artist on that song instance. 
# This would return the Artist instance associated to the song. Chaining a call to #name after that is equivalent to saying: call #name on the return value of self.artist, i.e. call #name on the artist of this song.