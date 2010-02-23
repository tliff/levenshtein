require "rubygems"

def patch(file, &block)
  data	= File.read(file)
  data	= block.call(data)

  File.open(file, "w") do |f|
    f.puts(data)
  end

  data
end

ENV["RUBYOPT"]	= nil	# Don't accidently use the already installed gem.

version		= ARGV.shift
spec		= File.open("levenshtein.gemspec"){|f| Kernel.eval(f.read)}
rdoc_opt	= spec.rdoc_options

patch("VERSION") do |data|
  version	||= (data.scan(/\d+/)[0, 3] + [Time.now.to_i]).join(".")
end

patch("lib/levenshtein.rb") do |data|
  data.sub(/\bVERSION\s*=\s*"[\.\d]+"$/, "VERSION\t= \"#{version}\"")
end

patch("CHANGELOG") do |data|
  ["%s (%s)" % [version, Time.now.strftime("%d-%m-%Y")]] + data.split(/\r*\n/)[1..-1]
end

system "rm -f levenshtein-*.gem"
system "rm -f levenshtein-*.tar.gz"
system "rm -rf doc"

system "ruby ext/levenshtein/extconf.rb"
system "make"

system "rdoc -q lib #{rdoc_opt.collect{|s| s.inspect}.join(" ")}"
system "ruby -I lib test/test.rb"

system "make clean"
system "rm -f Makefile"

system "gem build levenshtein.gemspec"
system "tar czf levenshtein-#{version}.tar.gz -C .. --exclude '*.gem' --exclude '*.tar.gz' --exclude '.pog*' levenshtein"
