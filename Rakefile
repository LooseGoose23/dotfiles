require 'rake'
Dir["./lib/*.rb"].each {|file| require file }
os = detect_os

task :default do 
  Rake::Task["install"].invoke
end 

task :install do
  Rake::Task["install:all"].invoke
end

task :uninstall do
  system('rm -rf ~/.zshrc')
  system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"')
  system('sudo dscl . -create /Users/$USER UserShell `which bash`')
end

namespace :install do
  desc "Install all the dofiles magic, but no brewfile, brewcask and brewmas will be installed without question"
  task :nobrew do 
    case os
    when :macosx
      puts "Running MacOSX Development system Bootstrap sequence without Brew ..."
      install_components({brew: false})
    when :linux
      raise NotImplementedError, 'Not Implemented Sorry!'
    else
      print "Sorry not currently supported!"
    end  
  end

  desc "Install all the dofiles magic, brewfiles, brewcask and brewmas will be installed without question"
  task :all do
    case os
    when :macosx
      puts "Running MacOSX Development system Bootstrap sequence..."
      install_components({brew: true, brewfile: true, brewmas: true, brewcask: true})
    when :linux
      raise NotImplementedError, 'Not Implemented Sorry!'
    else
      print "Sorry not currently supported!"
    end
  end

  desc "Install the dofiles magic with only shell setup. No Brewcask or Brewmas apps will be installed."
  task :shell do
    case os
    when :macosx
      puts "Running MacOSX Development system Bootstrap sequence..."
      install_components({brew: true, brewfile: true, brewmas: false, brewcask: false})
    when :linux
      raise NotImplementedError, 'Not Implemented Sorry!'
    else
      print "Sorry not currently supported!"
    end
  end
end
