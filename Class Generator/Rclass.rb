#!/usr/bin/env ruby


################################################################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ .::( Rclass.rb )::. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#                                                                                         
#     A command line tool for the automatic generation of classes from other languages.        #
#     ~ Java, PHP.                                                                             #
#                                                                                              #
#     To Use, type: 'ruby Rclass.rb' and follow the instructions.                              #
#                                                                                              #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
################################################################################################



#########################
# ~ GLOBAL VARIABLES ~  #
#########################

states = []
stateTypes = []
chosen = nil
select = nil
codeBody = nil
className = nil
fileName = nil


#########################
#   ~ COMMAND LINE ~    #
#########################

puts "What Language do you want to generate a class for?" 
puts "(1) Java"
puts "(2) PHP"

puts "\n>> Input the relevant number: " 


while (chosen == nil)
  select = gets.chomp

  
if (select == ?1) 
       chosen = "Java"
end


if (select == ?2) 
       chosen = "PHP"
end 

if (select != ?1 && select != ?2)
    puts "INVALID INPUT, please try again:"
end

end


puts "\n\n>> Input a name for the class: " 
className = gets.chomp.capitalize 




puts "\n\nWhat do you want your class data members to be named?"
puts "\n>> Input member names, followed by Type || Input \'-START\' to finalize your input and begin generation: " if chosen == "Java"
puts "\n>> Input member names || Input \'-START\' to finalize your input and begin generation: " if chosen == "PHP"





while value = gets.chomp 
  
      states << value if value != "-START"
   
          if (value != "-START" && chosen == "Java")
            print "~TYPE: " 
            temp2 = gets.chomp
            stateTypes << temp2
          end
       
       break if value == "-START"
          
end  



############################
#   ~ CLASS GENERATION ~   #
############################

if (chosen == "Java") 

codeBody = <<HERE
public class #{className} {
HERE


###STATES

codeBody << "\n //States"

0.upto(states.size - 1) do |i| 
  codeBody << "\n" + "private " + stateTypes[i] + " " + states[i] + ";"
end

codeBody << "\n\n"






###CONSTRUCTORS

codeBody << "\n //Constructor\n"

codeBody << "public #{className}("
0.upto(states.size - 1) do |i| 
  codeBody << stateTypes[i] + " " + states[i] + ", " if (i != (states.size - 1) )
  codeBody << stateTypes[i] + " " + states[i]  if (i == (states.size - 1) )
end
codeBody << ") {"

0.upto(states.size - 1) do |i| 
  codeBody << "\nthis." + states[i] + " = " + states[i] + ";"
end

codeBody << "\n}"




codeBody << "\n //Copy-Constructor\n"

codeBody << "public #{className}("
codeBody << "#{className} copy) {"

0.upto(states.size - 1) do |i| 
  codeBody << "\n" + states[i] + " = " + "copy." +states[i] + ";"
end

codeBody << "\n}"

codeBody << "\n\n"





###GETTERS

codeBody << "\n //Get Methods"

0.upto(states.size - 1) do |i| 
  codeBody << "\n" + "public " + stateTypes[i] + " " + "get" + states[i].capitalize + "()" + " { return #{states[i]}; }"
end

codeBody << "\n\n"





###SETTERS

codeBody << "\n //Set Methods"


0.upto(states.size - 1) do |i| 
  codeBody << "\n" + "public " +  "set" + states[i].capitalize + "(#{stateTypes[i]} #{states[i]})" + " { this.#{states[i]} = #{states[i]}; }"
end


codeBody << "\n\n"






###TOSTRING

codeBody << "\n //ToString Method\n"

codeBody << "public String toString() {\nreturn "

0.upto(states.size - 1) do |i| 
  codeBody <<  states[i]
  codeBody <<  " + \" \" + " if i != (states.size - 1)
  codeBody <<  ";" if i == (states.size - 1)
end

codeBody << "\n}"






###END OF CLASS

codeBody << "\n\n}"  
  
end


###################################################################################################################################################


if (chosen == "PHP")
  

  
codeBody = <<HERE 

HERE

codeBody << "<?php\n\nnamespace classdef;\n\n\nclass #{className} {"  
  
  
###STATES

codeBody << "\n\n //States"

0.upto(states.size - 1) do |i| 
  codeBody << "\n" + "private " + states[i] + ";"
end

codeBody << "\n\n"






###CONSTRUCTOR

codeBody << "\n //Constructor\n"

codeBody << "public __construct("
0.upto(states.size - 1) do |i| 
  codeBody << states[i] + ", " if (i != (states.size - 1) )
  codeBody << states[i]  if (i == (states.size - 1) )
end
codeBody << ") {"

0.upto(states.size - 1) do |i| 
  codeBody << "\n$this->" + states[i] + " = " + states[i] + ";"
end

codeBody << "\n}"

codeBody << "\n\n"




###GETTERS

codeBody << "\n //Get Methods"

0.upto(states.size - 1) do |i| 
  codeBody << "\n" + "public " + "get" + states[i].capitalize + "()" + " { return $this->#{states[i]}; }"
end

codeBody << "\n\n"




###SETTERS

codeBody << "\n //Set Methods"


0.upto(states.size - 1) do |i| 
  codeBody << "\n" + "public " +  "set" + states[i].capitalize + "(#{states[i]})" + " { this->#{states[i]} = #{states[i]}; }"
end


codeBody << "\n\n"





###END OF CLASS

codeBody << "\n\n}"

codeBody << "\n\n?>"  
  
  
  
end



###########################
#     ~ FILE OUTPUT ~     #
###########################


fileName = "#{className}.java" if chosen == "Java"
fileName = "#{className}.php" if chosen == "PHP"


finalFile = File.open("#{fileName}", "w")
finalFile.puts(codeBody)

puts "*** #{fileName} created in current directory ***"




