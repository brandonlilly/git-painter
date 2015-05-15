require 'git'

str = <<-IMG.split("\n").map {|row| row.split('')}
XXABXXXXXBXABXXXXABXXXXABXXABXXXXXXXXXXXXXXXXXXXXXXX
XXABXXXXABXABXXXXABXXXXABXXABXXXXXXXXXXXXXXXXXXXXXXX
XXABXXXXABXABXXXXABXXXXXABBBXXXXXXXXXXXXXXXXXXXXXXXX
XXABXXXXABXABXXXXABXXXXXXABXXXXXXXXXXXXXXXXXXXXXXXXX
XXABXXXXABXABXXXXABXXXXXXABXXXXXXXXXXXXXXXXXXXXXXXXX
XXABBBBXABXABBBBXABBBBXXXABXXXXXXXXXXXXXXXXXXXXXXXXX
XXXAAAXXXBXXAAAXXXAAAXXXXABXXXXXXXXXXXXXXXXXXXXXXXXX
IMG
days = 24*60*60
monday = Time.now - 52*7*days
monday += monday.monday? ? 0 : (7 - monday.wday) * days
p monday
p monday.wday

A = []
B = []
str.each_with_index do |row, wday|
  row.each_with_index do |char, weeks|
    if char == 'A'
      A << monday + (wday + weeks*7) * days
    elsif char == 'B'
      B << monday + (wday + weeks*7) * days
    end
  end
end
p A
