class Album

  def self.all
    # returns array of all albums
    return Dir.entries("app/assets/images/workexamples").map{|album| album}.delete_if{|album| album[0]=="."}
  end

  def self.display(album)
    # returns array of all images inside current album
    return Dir.entries("app/assets/images/workexamples/"+album).map{|album| album}.delete_if{|album| album[0]=="."}
  end

end