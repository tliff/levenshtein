Gem::Specification.new do |s|
  s.name		= "levenshtein"
  s.version		= File.open("VERSION"){|f| f.read}.chomp
  s.summary		= "Calculates the Levenshtein distance between two byte strings."
  s.description		= "Calculates the Levenshtein distance between two byte strings."

  s.author		= "Erik Veenstra"
  s.email		= "levenshtein@erikveen.dds.nl"
  s.homepage		= "http://www.erikveen.dds.nl/levenshtein/index.html"
  s.rubyforge_project	= "levenshtein"

  s.files		= Dir.glob("lib/**/*") + Dir.glob("ext/**/*") + ["README", "LICENSE", "VERSION", "CHANGELOG"]
  s.extensions		= ["ext/levenshtein/extconf.rb"]
  s.test_files		= ["test/test.rb"]

  s.has_rdoc		= true
  s.rdoc_options	= ["README", "LICENSE", "VERSION", "CHANGELOG", "--title", "#{s.name} (#{s.version})", "--main", "README"]
end
