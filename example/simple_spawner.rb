require 'rubygems'
require 'furc'

s = Furc::Spawner.new

Thread.new do
  s.start(10) do
    sleep rand(10)
    if rand(5) == 0 then
      puts "found cheese"
    end
  end
end

puts "waiting 15 seconds"
3.times do |ii|
  sleep 5
  puts "waited #{(ii+1) * 5} seconds"
end
puts "wait complete"

s.exit

