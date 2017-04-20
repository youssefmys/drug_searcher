class Drug

  attr_accessor :name,  :website

  @@all = []
  
  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  #writing finders

  def self.find_drug_by_name(name)
    #search if drug name contains the search string
    found_drugs = @@all.find_all {|drug| drug.name.downcase.include? (name.downcase)}
    found_drugs.empty? ? nil : found_drugs
  end

  def self.find_drugs_by_letter(letter)
    found_drugs = @@all.find_all do |drug|
      drug.name.start_with?(letter.upcase) || drug.name.start_with?(letter.downcase)
    end
    
  end

  def self.import_drugs_from_array(drugs_array)

    #getting info from scrapper array of hashes

    drugs_array.each do |drug_hash|
      drug = Drug.new(drug_hash) # using hash of attributes from scrapper
      @@all << drug unless @@all.any? {|d| d.name == drug_hash[:name]}
    end
    
  end
  
end
