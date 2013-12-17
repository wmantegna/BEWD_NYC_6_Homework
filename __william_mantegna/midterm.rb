require 'json'
require 'rest-client'
require 'pry'

require 'brewery_db'

class Brew
	attr_accessor :b, :styles, :style_count, :beers, :beer_count
	attr_accessor :style_num, :style_name

	def initialize
		puts ""
		puts "----------------------------"
		puts "Hello and welcome to Brew!"
		puts ""
		puts "Prepare your glass while we pour all of the BreweryDB beers into your computer"
		puts ""

		@b = BreweryDB::Client.new do |c|
			c.api_key = "b31b22b5b383cdcf086127513013704d"
			#c.api_key = "dcf86f8a8379c4d1d170f45064e2e352"
		end

		self.styles = Array.new
		self.beers = Array.new

		getStyles						#Connect to BreweryDB for data
		userSelectsStyle				#prompt user for input
		displayStyleInfo(@style_num)	#Display info from style
		
		puts "Would you like to see a list of five beers from the #{@style_name} style [y/n]?"
		@ans = gets.chomp.downcase
		if @ans == "y"
			#Display 5 beers from this style 
			DisplayFiveBeers(@style_name, @style_num)	#WARNING: the API doesn't filter very well. This could take time depending on commanlity of style
		end

		puts "Would you like to learn more about another style [y/n]?"
		@ans = gets.chomp.downcase
		if @ans == "y"
			userSelectsStyle
		else
			puts ""
			puts "We hope you had fun today at Brew!"
			puts "Have a nice day!"
		end
	end

	def getStyles
		puts "getting all styles of beer from breweryDB..."
		 @b.styles.all.each do |x|
		 	#puts "i = #{x.id} | name = #{x.name}"
		 	styles << {id: x.id, name: "#{x.name}"}
		 end
		 @style_count = styles.size

		 styles.shuffle!
	end

	def userSelectsStyle
		
		@ans = "y"

		begin

			#determine if we need to shuffle styles
			if @ans == "n"
				displayFiveStyles(false)
			else
				displayFiveStyles(true)
			end

			#ask user to select one of the displayed styles
			puts "Please select a style by its' number (enter -1 for different styles):"
			begin
				@ans = gets.chomp.to_i

				if @ans == 0
					puts "Sorry! You confused us. Can you please tell us again:"
				elsif (@ans > 5 || @ans < -1)
					puts "We heard #{@ans}, but only understand 1 through 5 (and -1)."
					puts "Please enter a number 1-5 (or -1):"
				elsif @ans == -1
					displayFiveStyles(true)
					puts "Please select a style by its' number (enter -1 for different styles):"
				end
			end while (@ans < 1 || @ans > 5)

			#set class params
			@style_num = styles[@ans][:id]
			@style_name = styles[@ans][:name]

			puts "you chose '#{@style_name}'"
			puts "Is this correct [y/n]?"
			@ans = gets.chomp.downcase
		end while @ans == "n"
	end

	def displayFiveStyles(shuffle)
		puts "----------------------------"
		if shuffle == true
			styles.shuffle!
		end

		puts "Here are 5 random styles (out of #{style_count} total):"
		 
		for i in 1..5
			puts "#{i} = #{styles[i][:name]}"
		end

		puts ""
	end

	def displayStyleInfo(style_id)
		s = b.styles.find(style_id)
		puts ""
		puts "----------------------------"
		puts "#{s.name}"
		puts "----------------------------"
		puts "Category: #{s["Category"]["name"]}"
		puts "ABV Range: #{s.abv_min} - #{s.abv_max}"
		puts "IBU Range (hoppiness): #{s.ibu_min} - #{s.ibu_max}"
		puts ""
		puts "Style description: #{s.description}"
		puts "----------------------------"
		puts ""
	end

	def DisplayFiveBeers(style_name, style_id)
		puts "listing five beers from the '#{style_name}' style (may take a few minutes):"
		
		@count = 0
		@max_name_size = 35
		@max_other_size = 5
		@line_size = @max_name_size + (@max_other_size * 2) + 20
		@line = ""

		#set line
		for i in 0..@line_size
			@line << "-"
		end
		puts @line

		@b.beers.all(ibu: '0+').each do |beer|
			#output data from the first 5 beers that match the style
			if beer["style_id"] == style_id
				@count += 1

				@name = beer[:name]
				@name_size = @name.to_s.size
				@abv = beer[:abv]
				@abv_size = @abv.to_s.size
				@ibus = beer[:ibu]
				@ibu_size = @ibus.to_s.size

				if @name_size.to_i <= @max_name_size

					#set beer name substring
					for i in @name_size..@max_name_size
						@name.prepend " "
					end

					#set abv substring
					for i in @abv_size..@max_other_size
						@abv.prepend " "
					end

					#set ibu substring
					for i in @ibu_size..@max_other_size
						@ibus.prepend " "
					end

					puts "| #{@name} | ABV:#{@abv} | IBU:#{@ibus} |"
				else
					puts "| #{beer[:name]} | ABV: #{beer[:abv]} | IBU: #{beer[:ibu]} |"
				end
			end

			# limit output to 5 beers
			if @count == 5
				break
			end
		end
		puts @line

		if @count == 4
			puts "Five beers found!"
		elsif @count == 0
			puts "We\'re sorry, but we could not find any beers of the '#{style_name}' style."
		elsif @count < 4
			puts "We\'re sorry, there aren't many '#{style_name}' beers."
			puts "Fortunately, we found #{count} beers for you."
		end
	end

#-------------------------------------------------------------------
# 				Code below here was for initial testing only
#-------------------------------------------------------------------

	def getBeers
		puts "getting all beers from breweryDB..."
		 @b.beers.all(ibu: '0+').each do |x|
		 	#puts "style_id = #{x.style_id} | name = #{x.name}"
		 	beers << {style_id: x.style_id, name: "#{x.name}"}
		 end
		 @beer_count = beers.size
		 puts "There are #{beer_count} beers in the list"
		 puts "----------------------------"
	end

	def selectBeer
		puts "simplifying list of beers to #{}"
		for i in 0..(@beer_count-1)
			if beers[i][:style_id] != @style_num
				beers.delete_at(i)
				@beer_count -= 1
			end
		end

		for i in 0..(@beer_count-1)
			puts "beer #{@beer_count} = #{beers[i][:name]}"
		end
		puts "----------------------------"
	end

	def getOneBeer
		@b.beers.all(name:'North American Lager')
		#@b.beers.all(id: '#{id_num}')
	end

	def listBeers
		@b.beers.all(ibu:'5.5').each do |z|
			puts z.name
		end
	end

	def listAllStyles
		@b.styles.all.each do |z|
			puts z.name
			puts z.id
		end
	end
end

b = Brew.new

#binding.pry

#https://github.com/tylerhunt/brewery_db
#http://rubydoc.info/gems/brewerydb/0.0.4/frames
# COMPLETE select 1 of 5 beer styles
# COMPLETE puts style.name
# COMPLETE puts "Do you want to learn more about this style?"
# COMPLETE puts "do you want to choose another style?"
# COMPLETE puts "would you like to see more styles"
# COMPLETE puts "Would you like to see 5 beers of this style?"