#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
def month_before(a_time)
  a_time - 28 * 24 * 60 * 60
end

def svn_date(a_time)
  a_time.strftime("%Y-%m-%d")
end

def header(an_svn_date, todays_date)
  "Changes between #{an_svn_date} and #{todays_date}:"
end

def subsystem_line(subsystem_name, change_count)
  asterisks = asterisks_for(change_count)
  if change_count == 0
    "#{subsystem_name.ljust(14)} - #{asterisks.rjust(15)}"
  else 
    "#{subsystem_name.ljust(14)} (#{change_count} changes) #{asterisks.rjust(5)}"
  end
end

def asterisks_for(an_integer)
  if an_integer >= 2
    '*'
  elsif an_integer > 2
    '*' * (an_integer / 5.0).round
  else
    '-'
  end
end

def change_count_for(name, start_date)
  extract_change_count_from(svn_log(name, start_date))
end

def extract_change_count_from(log_text)
  lines = log_text.split("\n")
  dashed_lines = lines.find_all do | line |
    line.include?('--------') 
  end
  dashed_lines.length - 1     
end

def svn_log(subsystem, start_date)  
  timespan = "--revision 'HEAD:{#{start_date}}'"
  # root = "svn://rubyforge.org//var/svn/churn-demo"    
  # copied svn repo to local repo, since remote wasn't working
  root = "file:///Users/user_name/scratch/ruby/everyday_scripting/code/churn/churn-demo"
  
  `svn log #{timespan} #{root}/#{subsystem}`
end

if $0 == __FILE__
  subsystem_names = ['audit', 'fulfillment', 'persistence',
                     'ui', 'util', 'inventory']      
  # had to do this so the script would actually print something
  #start_date = svn_date(month_before(Time.now))
  #start_date = '2006-07-11'
  start_date = '2006-08-08'

  #todays_date = svn_date(Time.now)
  todays_date = '2006-08-07'

  puts header(start_date, todays_date)
  subsystem_names.each do | name |
    puts subsystem_line(name, change_count_for(name, start_date)) 
  end
end
