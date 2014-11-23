old_inventory = File.open('old-inventory.txt').readlines
new_inventory = File.open('new-inventory.txt').readlines

puts "The following files have been added:"
puts new_inventory - old_inventory

puts ""
puts "The following files have been deleted:"
puts old_inventory - new_inventory

puts ""
print "The number of new files added: "
num_new_files = (new_inventory - old_inventory).length
puts num_new_files

puts ""
print "The number of old files removed: "
num_files_removed = (old_inventory - new_inventory).length
puts num_files_removed

puts""
print "The number of files unchanged in old-inventory.txt: "
num_files_unchanged = new_inventory.length - num_new_files
puts num_files_unchanged
