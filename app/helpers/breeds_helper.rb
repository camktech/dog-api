module BreedsHelper
  def base_breed_name(breed_data)
    breed_data[0]
  end

  def full_breed_name(name)
    name.split('-').reverse.join(" ")
  end

  def has_sub_breeds(breed_data)
    breed_data[1].present?
  end

  def sub_breeds(breed_data)
    breed_data[1]
  end
end
