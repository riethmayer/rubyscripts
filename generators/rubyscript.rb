#!/usr/bin/env ruby -w

path = ARGV[0]
fail "give me a filename to create the ruby script within." unless path

File.open(path, "w"){ |f| f.puts "#!/usr/bin/env ruby -w"}
File.chmod(0755, path)
`emacsclient -n #{path}`
