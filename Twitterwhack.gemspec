# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name		= "views.sh"
  spec.version		= '1.0'
  spec.authors		= ["Ari Kalfus"]
  spec.email		= ["akalfus@brandeis.edu"]
  spec.summary		= %q{Short summary of project}
  spec.description	= %q{Longer description of project}
  spec.homepage		= "some http domain for this project"
  spec.license		= "MIT"

  spec.files 		= ['lib/views.sh.rb']
  spec.executables	= ['bin/views.sh']
  spec.test_files	= ['tests/test_Twitterwhack.rb']
  spec.require_paths	= ["lib"]
end
