#!/usr/bin/env ruby


################################################################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ .::( Rfile.rb )::. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#                                                                                         
#             A command line tool to bulk rename an entire directory of files.                 #
#              ~ Can prepend or append a string, or completely rename.                         #
#                                                                                              #
#             To Use, type: 'ruby Rfile.rb' and follow the instructions.                       #
#                                                                                              #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
################################################################################################



################################
#     ~ GLOBAL VARIABLES ~     #
################################

choice = nil
chosen = false
text = ""


################################
#   ~ FUNCTIONS DEFINITIONS ~  #
################################

def renameAll(fileName)
    counter = 1
    Dir::glob("*").each do |name| 
        File.rename(name, fileName + counter.to_s) if name != "Rfile.rb" 
        counter += 1  if name != "Rfile.rb"
    end
end





def prepend(preName)
    Dir::glob("*").each do |name| 
        File.rename(name, preName + name) if name != "Rfile.rb" 
    end
end





def append(postName)
    Dir::glob("*").each do |name| 
        File.rename(name, name + postName) if name != "Rfile.rb"  
    end
end






#################################
#        ~ COMMAND LINE ~       #
#################################


puts "What type of naming operation do you want to execute?"
puts "(1) prepend string"
puts "(2) append string"
puts "(3) string + [number]"

puts "\n>> Input the relevant number: "


while (chosen == false)
  choice = gets.chomp

  
chosen = true if (choice == ?1) 

chosen = true if (choice == ?2) 

chosen = true if (choice == ?3) 


if (choice != ?1 && choice != ?2 && choice != ?3)
    puts "INVALID INPUT, please try again:"
end



end



puts "\n\n>> Please enter a text string to be used to rename files:"
text = gets.chomp


##################################
#      ~ FINAL EXECUTION ~       #
##################################


prepend(text) if choice == ?1

append(text) if choice == ?2

renameAll(text) if choice == ?3


puts "** Operation Successful **"

