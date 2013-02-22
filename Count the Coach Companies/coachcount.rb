#!/usr/bin/env ruby


$coachCount = 0
$currentState = false
$arr = []
        
        
def record (currentLine)
  $coachCount += 1
  $currentState = true
  $arr << currentLine
end        
        
        
        File.open("Passenger Transport Directory.txt", "r").each do |line|
            record(line) if line =~ /\w/  && !(line =~ /\*/) && $currentState == false
            $currentState = false if line =~ /^\s*$/ && $currentState == true
            
        end


puts "#{$coachCount} Coach Companies compiled\n\n"
puts $arr