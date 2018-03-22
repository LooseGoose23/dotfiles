#!/usr/bin/env ruby
require "./lib/detect_os.rb"

def install(options = {})  
  opts = eval options.first

  brew_option     = opts[:brew]
  brewcask_option = opts[:brewcask]
  brewmas_option = opts[:brewmas]
  brewfile_option = opts[:brewfile]

  if brew_option
    install_homebrew if detect_os == :macosx
    install_brewfiles_apps(brewfile_option) if detect_os == :macosx # Std brew apps
    install_brewcasks_apps(brewcask_option) if detect_os == :macosx # Brew cask
    # install_brewmas_apps(brewmas_option) if detect_os == :macosx # brew mas apps (app store, i.e xcode)
    brew_upgrade
    brew_cleanup
  else 
    puts "Not running Brew installs for anything!"
  end
end

def brew_upgrade
  if `brew outdated`
    puts "Running brew upgrade now."
    system('brew upgrade')
  end
end

def brew_cleanup
  puts "Running Brew cleanup"
  system('brew cleanup -v')
end

def install_brewmas_apps(brewmas_option)
  case brewmas_option
  when nil
    print "Would you like to install mas apps (mac app store apps) (Y/n)?"
    results = STDIN.gets
    return unless results.match(/y/i) or results == "\n"
  when false
    return
  end

  puts "Installing mas apps now..."
  system('brew tap homebrew/bundle')
  system("brew bundle --file=./etc/homebrew/Brewmas_macosx")
end

def install_brewcasks_apps(brewcask_option)
  case brewcask_option
  when nil
    print "Would you like to install gui/dev apps (Y/n)?"
    results = STDIN.gets
    return unless results.match(/y/i) or results == "\n"
  when false
    return
  end

  puts "Installing BrewCask's now..."
  system('brew tap homebrew/bundle')
  system("brew bundle --file=./etc/homebrew/Brewcask_#{detect_os}")
end

def install_homebrew
  brew = `which brew`.chomp

  if !brew.empty?
    puts "!!! Homebrew already installed. Doing nothing !!!"
  else
    system('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
  end
end

def install_brewfiles_apps(brewfile_option)
  case brewfile_option
  when nil 
    print "Would you like to install brewfiles apps (Y/n)?"
    results = STDIN.gets
    return unless results.match(/y/i) or results == "\n"
  when false
    return 
  end

  puts "Installing BrewFile now..."
  system('brew tap homebrew/bundle')
  system("brew bundle --file=./etc/homebrew/BrewFile_#{detect_os}")
end

install(ARGV)
