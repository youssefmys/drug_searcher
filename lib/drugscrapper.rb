require "nokogiri"
require "open-uri"
require "pry"



class DrugScrapper

  def initialize
    @main_url = "http://www.rxlist.com"
  end

  def get_drugs_by_letter
    drugs = []
    ("a".."z").to_a.each do |letter|
      page = "#{@main_url}/drugs/alpha_#{letter}.htm"
      doc = Nokogiri::HTML(open(page))

      doc.css(".contentstyle ul a").each do |drug|
        drug_hash = {}
        drug_hash[:name] = "#{drug.text}"

        website = "#{@main_url}#{drug.attribute("href")}"
        drug_hash[:website] = website

        drugs << drug_hash
      end
      
    end
    drugs
  end


  #getting drug description from drug page

  def get_drug_description(url)

    doc = Nokogiri::HTML(open(url))

    description = ""
    description_tag = doc.css("#FDAMonographPadding_fmt p").each do |paragraph|
      #adding new line between each paragraph
      description << paragraph.text << "\n" if  paragraph.text != nil
    end
    description
  end

end

