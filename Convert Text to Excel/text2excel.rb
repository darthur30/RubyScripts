require 'spreadsheet' 

################################################
##~ A CLASS TO REPRESENT EACH COMPANY RECORD ~##
################################################
class CoachCompany  
  attr_accessor :company, :address, :town, :postcode, :tel, :fax, :email, :site 
  def to_s
    "#{@company}#{@address}#{@town}#{@postcode}#{@tel}#{@fax}#{@email}#{@site}\n\n"
  end
end



########################
##~ GLOBAL VARIABLES ~##
########################
$currentState = false
$arr = []
$counter = 1
$temp = CoachCompany.new


############################################
##~ FUNCTIONS TO STORE RECORD INTO ARRAY ~##
############################################
def check(value) 
  
      
      if $counter == 1  
        $temp.company = value 
        $counter += 1
        return
      end 
      if $counter == 2 
        $temp.address = value
        $counter += 1
        return
      end
      if $counter == 3 
        $temp.town = value
        $counter += 1 
        return
      end 
      if $counter == 4 
        $temp.postcode = value
        $counter += 1
        return 
      end 
      
      
        
  
       if value =~ /^\(TEL\)/
          $temp.tel = value.to_s.sub(/^\(TEL\)/, '')
          return 
       end
       if value =~ /^\(FAX\)/
          $temp.fax = value.to_s.sub(/^\(FAX\)/, '')
          return 
       end
       if value =~ /^\(EMAIL\)/
          $temp.email = value.to_s.sub(/^\(EMAIL\)/, '')
          return 
       end      
       if value =~ /^\(SITE\)/
          $temp.site = value.to_s.sub(/^\(SITE\)/, '')  
       end
       
    
end


def commit()
  
    
    $temp.tel = " " if $temp.tel.nil?
    $temp.fax = " " if $temp.fax.nil?
    $temp.email = " " if $temp.email.nil?
    $temp.site = " " if $temp.site.nil?
  
  
    $arr << $temp
    $temp = CoachCompany.new 
        
    $counter = 1
    
end




##########################################
##~ OPEN TEXT FILE & STORE INTO ARRAY  ~##
##########################################
File.open("Passenger Transport Directory.txt", "r").each do |line|
      
      $currentState = true if line =~ /\w/  && !(line =~ /\*/) 
      check(line)  if $currentState == true
       
      if line =~ /^\s*$/ && $currentState == true
          $currentState = false 
          commit()
      end
          
end



########################################
##~ WRITE TO SPREADSHEET FROM ARRAY  ~##
########################################
book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet :name => 'Coach Companies'

sheet1.row(0).concat %w{CompanyName Address City Postcode Telephone Fax Email Site}


 format = Spreadsheet::Format.new :color => :blue,
                                   :weight => :bold,
                                   :size => 18
 sheet1.row(0).default_format = format


$arr.each do |el|
      sheet1.row($counter).push el.company, el.address, el.town, el.postcode, el.tel, el.fax, el.email, el.site
      $counter += 1
end


book.write 'C:\Users\dylan\Documents\Aptana Studio 3 Workspace\Convert Text to Excel\Transport Directory.xls'

puts $arr.size
puts $arr

