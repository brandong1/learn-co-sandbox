# The purpose of this MP3 Importer is to take in a list of mp3s and send each mp3 filename to the Song class to make a Song. Let's just focus on the collaboration. Our MP3Importer class will receive a list of filenames that look like this "Drake - Hotline Bling". MP3Importer will then send each of those filenames to the Song class to be created.

class Song
  attr_accessor :title
 
  def self.new_by_filename(filename)
    song = self.new
    song.title = filename.split(" - ")[1]
    song
  end
 
end
 
class MP3Importer
  def import(list_of_filenames)
    list_of_filenames.each{ |filename| Song.new_by_filename(filename) } # within the MP3Importer class we are calling the Song class and a                                                                     method within the Song class: .new_by_filename.
  end
end


# When we hit this line of code, it will send us to the Song class to do whatever behavior we have defined in the .new_by_filename class method. Then we will return to the MP3Importer class to continue executing the code. This is at the heart of collaborating objects.