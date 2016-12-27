#require "#{File.expand_path(File.dirname(__FILE__))}/seeds_help/scert.rb"
#require "#{File.expand_path(File.dirname(__FILE__))}/seeds_help/sheet_1.rb"
#require "#{File.expand_path(File.dirname(__FILE__))}/seeds_help/sheet_2.rb"
#require "#{File.expand_path(File.dirname(__FILE__))}/seeds_help/sheet_childs.rb"
#
#puts "create_brands"
#create_brands()
#puts "sheet_1"
#sheet_1()
#puts "sheet_2"
#sheet_2()
#puts "sheet_childs"
#sheet_childs()
#
20.times do |l|
  next if l == 0
  a = Machine.new({
    name: "m#{l}",
  })
  if a.save

  else
    p a.errors
  end
end
