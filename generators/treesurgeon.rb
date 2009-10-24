PROJECTNAME = ARGV[0]

fail "Need a project name to start the tree surgeon." unless PROJECTNAME

LIB        = File.join(PROJECTNAME , "lib" )
TEST       = File.join(PROJECTNAME , 'test')
RAKEFILE   = File.join(PROJECTNAME , 'Rakefile')
ALLTESTS   = File.join(TEST        , "all_tests.rb")
MAIN       = File.join(PROJECTNAME , "lib", "#{PROJECTNAME}.rb")
TESTHELPER = File.join(TEST        , "test_helper.rb")


[PROJECTNAME, LIB, TEST].each do |dir|
  puts "creating #{dir}"
  Dir.mkdir dir
end

File.open(MAIN, 'w') do |file|
  file << <<-EOF
# #{PROJECTNAME} ;; #{Time.now.year} (cc) Jan Riethmayer
# This work is licensend under a Creative Commons Attribution 3.0 license.
EOF
end

File.open(RAKEFILE, 'w') do |file|
  file << <<-EOF
task :default => :test

desc "Runs tests suite"
task :test do
  require File.dirname(__FILE__) + '/test/all_tests.rb'
end
EOF
end

File.open(ALLTESTS, 'w') do |file|
  file << "Dir['**/*_test.rb'].each { |test_case| require test_case }"
end

File.open(TESTHELPER, 'w') do |file|
  file << <<-EOF
require 'test/unit'
require 'mocha'
require 'stubba'
require File.dirname(__FILE__) + '/../lib/#{PROJECTNAME}'
EOF
end

puts %x{tree #{PROJECTNAME}} if `which tree` =~ /bin\/tree/
