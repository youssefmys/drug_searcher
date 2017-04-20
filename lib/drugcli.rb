class Drugcli

  def self.start #class method
    puts "preparation of database" #show programe is doing something
    scrapper = DrugScrapper.new
    Drug.import_drugs_from_array(scrapper.get_drugs_by_letter)

    puts "Welcome to drugs' names database"

    user_input = nil

    while user_input != "quit" do
      puts "1- display drugs alphabitically"
      puts "2- seach by brand name"

      user_input = gets.chomp

      case user_input
      when "1"
        puts "Insert a letter from a to z or quit"

        user_input = gets.chomp

        if ("a".."z").include?(user_input.downcase)
          found_drugs = Drug.find_drugs_by_letter(user_input)
          found_drugs.each_with_index do |drug, index|
            puts "#{index + 1}. #{drug.name}"
          end
          puts "Insert drug No. to get drug descripion:"
          user_input = gets.chomp

          found_drugs.each_with_index do |drug, index|

            if index == user_input.to_i - 1
              puts "Scrapping drug description from {#drug.website}"
              puts "------------------------------------------------"
              puts scrapper.get_drug_description(drug.website)
              puts "------------------------------------------------"
              
            end
          end
        else
          puts "please insert letter from a to z or quit"
          
        end

      when "2"

        puts "search drug name : "
        user_input = gets.chomp
        found_drugs = Drug.find_drug_by_name(user_input)

        if found_drugs
          found_drugs.each_with_index do |drug, index|
            puts "#{index + 1}. #{drug.name}"
          end
          
          puts "Insert drug No. to get drug descripion:"
          user_input = gets.chomp

          found_drugs.each_with_index do |drug, index|

            if index == user_input.to_i - 1
              puts "Scrapping drug description from {#drug.website}"
              puts "------------------------------------------------"
              puts scrapper.get_drug_description(drug.website)
              puts "------------------------------------------------"
              
            end
          end
        else
          puts "Drug was not found"
          
        end

      when "quit"
        puts "quitig"

      else
        puts "Please inser 1,2, or quit"
      end

    end
  end
end
