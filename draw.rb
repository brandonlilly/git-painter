require 'fileutils'
require 'rugged'
require 'json'
require 'titleize'
require_relative 'painter'

base_repo = 'base_repo'
target_repo = 'painted'

# fresh painted repo
FileUtils.rm_rf(target_repo)
FileUtils.copy_entry(base_repo, target_repo)
FileUtils.mv(target_repo + '/git', target_repo + '/.git')

repo = Rugged::Repository.new('painted')
painter = Painter.new(repo)

pattern = File.read('pattern.txt').split("\n").map {|row| row.split('')}

color_file = File.read('colors.json')
color_data = JSON.parse(color_file)

colors = color_data.map(&:first).map(&:titleize)

phrases = [
  "Nice layer of _",
  "A happy little mistake",
  "Coating of _",
  "Slathering of _",
  "Just a touch of _",
  "Faintest hint of _",
  "Generous amount of _",
  "Tasteful use of _",
  "Smidgen of _",
]

first_sunday = Painter.first_sunday

weights = { A: 1, B: 4, }

pattern.each_with_index do |row, wday|
  row.each_with_index do |char, weeks|
    next unless weight = weights[char.to_sym]

    day = first_sunday + (wday + weeks*7) * 24*60*60
    weight.times do
      message = phrases.sample.sub('_', colors.sample)
      painter.commit(time: day, message: message, content: "This is a paint job.")
    end
  end
end
