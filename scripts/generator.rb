require 'optparse'


def generate_code(path,output_path,options)

	if File.directory?(path) && !Dir.exists?(path)
		Dir.mkdir output_path
		puts "Created Folder #{output_path}"
	else
		dir_path = File.dirname(output_path)
		if !Dir.exists?(dir_path)
			Dir.mkdir dir_path
			puts "Created Folder #{dir_path}"
		end
		file_content = File.read(path)
		file_content = file_content.gsub(/VIPER/, options[:module_name])
		file_content = file_content.gsub(/AUTHOR/, options[:author])
		file_content = file_content.gsub(/COMPANY/, options[:company])
		file_content = file_content.gsub(/YEAR/, options[:year])
		file_content = file_content.gsub(/PRODUCT/, options[:product])
		File.write(output_path,file_content)
		puts "Created File #{output_path}"
	end
end

def generate_module(options)
	Dir.glob( "#{options[:templates_path]}/VIPER/**/*").each do |path|
		output_path = path.gsub("#{options[:templates_path]}",options[:module_output_location])
		output_path = output_path.gsub(/VIPER/, options[:module_name])
		generate_code(path,output_path,options)
	end
end

def generate_test_module(options)
	Dir.glob( "#{options[:templates_path]}/VIPER_UNIT_TESTS/**/*").each do |path|
		output_path = path.gsub("#{options[:templates_path]}",options[:test_output_location])
		output_path = output_path.gsub(/VIPER_UNIT_TESTS/, options[:module_name])
		output_path = output_path.gsub(/VIPER/, options[:module_name])
		generate_code(path,output_path,options)
	end
end

def main(options)
	puts "**************************** create module *******************************"
	generate_module(options)
	puts "**************************** create module tests *******************************"
	generate_test_module(options)
	puts "**************************** done *******************************"
end



options = {:author => "Venkatesh", :company => "Go-jek", :year => "2016", :product=> 'GoProducts'}

optparse = OptionParser.new do |opts|
	opts.banner = "Usage: ruby generator.rb -m MODULE_NAME -t TEMPLATES_PATH -w MODULE_OUTPUT_LOCATION -u TEST_OUTPUT_LOCATION "
	opts.on("-m MODULE_NAME","--module_name MODULE_NAME", "Module Name To Create") do |t|
    	options[:module_name] = t
  	end

	opts.on("-t TEMPLATES_PATH","--templates_path TEMPLATES_PATH", "Path To Templates") do |t|
    	options[:templates_path] = t
  	end

	opts.on("-w MODULE_OUTPUT_LOCATION","--module_output_location MODULE_OUTPUT_LOCATION", "Path To Module Output Location") do |t|
    	options[:module_output_location] = t
  	end

	opts.on("-u TEST_OUTPUT_LOCATION","--test_output_location TEST_OUTPUT_LOCATION", "Path To Test Module Output Location") do |t|
    	options[:test_output_location] = t
  	end


	opts.on("-a AUTHOR_NAME","--author AUTHOR_NAME", "Author Name To Use") do |t|
    	options[:author] = t
  	end

	opts.on("-p PRODUCT","--author PRODUCT", "Product Name") do |t|
    	options[:product] = t
  	end


	opts.on("-c COMPANY","--company COMPANY","Company Name To Use") do |t|
    	options[:company] = t
  	end

	opts.on("-y YEAR","--year YEAR", "Year To Use") do |t|
    	options[:year] = t
  	end
end
optparse.parse!

puts options

if options[:module_name].nil?
  raise ArgumentError,"no 'module_name' option specified  as a parameter."
end

if options[:templates_path].nil?
  raise ArgumentError,"no 'templates_path' option specified  as a parameter."
end

if options[:module_output_location].nil?
  raise ArgumentError,"no 'modile_output_location' option specified  as a parameter."
end

if options[:test_output_location].nil?
  raise ArgumentError,"no 'test_output_location' option specified  as a parameter."
end

main(options)
