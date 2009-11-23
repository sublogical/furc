#--
#
# Copyright (c) 2009 by Thoughtcrime, llc. All Rights Reserved.
#
# File name: spawn.rb
# Author:    Jay Hoover
# Date:      11/22/2009
#
#++
#
# === File Description
# This file creates a simple managed spawner. Forks and maintains a set of worker children, restarting them as they are killed.
#


module Server
  class Spawner
    def exit
      @exitting = true
      @worker_pids.each do |pid|
        Process.kill('INT', pid)
      end
    end

    # === Description
    # This method causes the spawner to fork off a number of worker processes.
    # If any of these processes exit, they are restarted automatically.
    #
    # === Parameters
    # * workers - the number of workers to run
    # * options - hash of optional parameters
    #   * :log - logger to use for spawning events
    #   * :verbose - whether to include verbose logging
    #
    def run(workers, options = {}, &block)
      @exitting = false      
      @worker_pids = []
      workers.times do
        @worker_pids << Process.fork do
          begin
            block.call
          rescue Interrupt
          end
        end
      end

      while !@exitting
        pid, ret = Process.wait2
        if !@exitting && @worker_pids.include?(pid) then
          @worker_pids.delete(pid)
          @worker_pids << Process.fork do
            begin
              block.call
            rescue Interrupt
            end
          end
        end
      end
    end
  end
end

s = Server::Spawner.new

Thread.new do
  s.run(10, food) do |type_of_food|
    sleep rand(10)
    if rand(5) = 0 then
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

