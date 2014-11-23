def check_usage
  unless ARGV.length == 2 
    puts "Usage: differences.rb old-inventory new-inventory"
    exit
  end
end

def contains?(line, boring_word)
  line.chomp.split('/').include?(boring_word)
end

def boring?(line, boring_words)
  boring_words.any? do | a_boring_word |
    contains?(line, a_boring_word)
  end
end

def inventory_from(filename)
#def inventory_from(filename, boring_words)
  inventory = File.open(filename)  
  downcased = inventory.collect do | line | 
    line.downcase  # (1)
  end 
  downcased.reject do | line |   
    boring?(line, ['temp', 'recycler'])
    #boring?(line, boring_words)
  end
end

def compare_inventory_files(old_file, new_file) # (2)
  old_inventory = inventory_from(ARGV[0])
  new_inventory = inventory_from(ARGV[1])
  
  puts "The following files have been added:"
  puts new_inventory - old_inventory
  
  puts ""
  puts "The following files have been deleted:"
  puts old_inventory - new_inventory
end

if $0 == __FILE__ # (3)
  check_usage 
  compare_inventory_files(ARGV[0], ARGV[1]) 
end
