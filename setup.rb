require 'logger'

require_relative 'scripts/zsh'

require_relative 'installers/rvm'
require_relative 'installers/hnvm'
require_relative 'installers/xcode'
require_relative 'installers/docker'
require_relative 'installers/homebrew'
require_relative 'installers/oh-my-zsh'
require_relative 'installers/prerequisites'

$version = "0.0.1"
$assistant = "guilty-spark"

$identity = "#{$assistant}@#{$version}"
$log = Logger.new STDOUT
$log.level = Logger::DEBUG

module GuiltySpark
  class CLI    
    def start
        $log.info "#{$identity}: Let me set up your machine"
        Installers::Xcode.new.ensure_installation
        Installers::Homebrew.new.ensure_installation
        Installers::Prerequisites.new.ensure_installation
        Installers::RVM.new.ensure_installation
        Installers::HNVM.new.ensure_installation
        Installers::OhMyZsh.new.ensure_installation
        Scripts::ZSH.new.ensure_zsh_default_shell
        Installers::Docker.new.ensure_installation
    end
  end
end

GuiltySpark::CLI.new.start