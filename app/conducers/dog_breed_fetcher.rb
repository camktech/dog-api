class DogBreedFetcher
  attr_reader :breed

  def initialize(name=nil)
    @name  = name || "random"
    @breed = Breed.find_or_initialize_by(name: name)
  end

  def fetch
    return @breed if @breed.pic_url.present?

    @breed.pic_url = fetch_info["message"]
    @breed.save && @breed
  end

  def self.fetch(name=nil)
    name ||= "random"
    DogBreedFetcher.new(name).fetch
  end

  def self.fetch_breed_list
    fetch_breed_list_info["message"]
  end

private
  def fetch_info
    begin
      JSON.parse(RestClient.get(breed_url).body)
    rescue Object => e
      default_body
    end
  end

  def default_body
    {
      "status"  => "success",
      "message" => "https://images.dog.ceo/breeds/cattledog-australian/IMG_2432.jpg"
    }
  end

  def breed_url
    if @name == "random"
      "https://dog.ceo/api/breeds/images/random"
    else
      "https://dog.ceo/api/breed/#{@name.gsub('-', '/')}/images/random"
    end
  end

  def self.fetch_breed_list_info
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all").body)
    rescue Object => e
      breed_list_error_body
    end
  end

  def self.breed_list_error_body
    {
      "status" => "error",
      "message" => []
    }    
  end

  private_class_method :breed_list_error_body, :fetch_breed_list_info
end
