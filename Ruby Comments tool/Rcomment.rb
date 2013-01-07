#!/usr/bin/env ruby


################################################################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ .::( Rcomment.rb )::. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#                                                                                         
#     A command line tool for extracting comments from raw source code and presenting          #
#     them in a HTML document.                                                                 #
#                                                                                              #
#     To Use, type: 'ruby Rcomment.rb' and follow the instructions.                            #
#                                                                                              #
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
################################################################################################





#######################
#  ~COMMENT CLASS~    #
#######################

class Comment  
  attr_accessor :title, :description, :members, :keyNotes  
  def to_s
    "#{@title}\n#{@description}\n#{@members}\n#{@keyNotes}\n\n"
  end
end



#######################
# ~GLOBAL VARIABLES~  #
#######################

main = []
collection = []
temp = nil
com = false
files = %w[views.js models.js templates.js]



#######################
#   ~COMMAND LINE~    #
#######################

puts "Default files to parse in current directory: " 
files.each{ |filo| puts "\n -> #{filo}" }
puts "\nDo you want to override existing defaults?(y/n)"
tempAnswer = gets.chomp

if(tempAnswer == ?y)
  files = []
  puts "\nPlease type in the name(s) of the file you wish to parse - including the extension"
  puts "Example:  views.js"
  puts "\ntype and enter the phrase \"start\" at any time to stop input and start parsing" 
  
  while(tempAnswer != "start")
  puts "File->"
  tempAnswer = gets.chomp
  files << tempAnswer
   
  end
  
  
end


########################
# ~DATA EXTRACTION~    #
########################

files.each do |name|

  myFile = File.open(name, "r") if File.exists? name 

            if(!myFile.nil?)
  
                  myFile.each do |line|
    
                          if line =~ /\/\*\*\*/
                             temp = Comment.new  
                             temp.title = ""
                             temp.description = ""
                             temp.members = []
                             temp.keyNotes = []
                             com = true
                          end
     
      
                          if(com == true)
                              temp.title <<  line.split('~').map(&:strip)[1].to_s if line[0] == "~"  
                              temp.description << line if !(line[0] =~ /[~@=\/\*]/) && (line[0] =~ /\S/)    
                              temp.members << line.split('@').map(&:strip)[1].to_s  if line[0] == "@"  
                              temp.keyNotes <<  line.split('>').map(&:strip)[1].to_s  if line[0] == "=" && line[1] == ">"   
     
                              if(line =~ /\*\*\*\//)
                                  collection << temp  
                                  com = false
                              end
                          end  
    
                  end
  
             end

main << collection if (!myFile.nil?)
collection = [] if (!myFile.nil?)

end



#########################
#   ~HTML CREATION~     #
#########################

puts "Please type in a name for your HTML Documentation file: "
docName = gets.chomp

document1 = <<HERE

<HTML>
<HEAD><TITLE>Documentation :: #{docName}</TITLE></HEAD>
<BODY>
<h2>Documentation :: #{docName}</h2>

<h3>Contents</h3>
HERE


0.upto(main.size - 1) do |num|

 
  document1 << "<li>(#{files[num].split('.')[0].to_s.capitalize})</li>\n" 
  main[num].each{|single| document1 << "<li>#{single.title}</li>" }
  document1 << "<br/>"
end

document1 << "<br/>\n\n"




0.upto(main.size - 1) do |num|

      main[num].each do |single| 
      
      document1 << "<h4>#{files[num]} :: #{single.title}</h4>"
      document1 << "\n<p> #{single.description} </p>"
      single.members.each{|mem| document1 << "\n<br/><li>#{mem}</li>"} 
      single.keyNotes.each{|notes| document1 << "\n<br/> => #{notes} "} 
      document1 << "\n<br/><br/><br/><br/>\n\n"
      
      
      end
  

end

document2 = <<HERE

</BODY>

</HTML>

HERE


finaldoc = document1 + document2


#########################
#     ~FILE OUTPUT~     #
#########################

finalFile = File.open("#{docName}-Documentation.html", "w")
finalFile.puts(finaldoc)

puts "*** #{docName}-Documentation.html created in current directory ***"

