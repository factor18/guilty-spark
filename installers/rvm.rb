module Installers
  class RVM
    def ensure_installation
      $log.info "#{$identity}: I'm checking if RVM is installed, if not I'll install it"
      if !system("zsh -c \"source ~/.zshrc; which rvm > /dev/null\"")
        install_rvm
      else
        $log.info "#{$identity}: RVM is already installed"
      end
    end

    def install_rvm
      $log.warn "#{$identity}: Installing RVM"
      if !system("curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable")
        $log.fatal "#{$identity}: #{rvm_error_message}"
        exit(false)
      else
        $log.info "#{$identity}: Successfully installed RVM"
        exec("zsh -c \"source ~/.zshrc; ruby setup.rb\"")
      end
    end

    private

    def rvm_error_message
      [
        "RVM installation failed",
        "Try running #{$PROGRAM_NAME} again"
      ].join("\n")
    end
  end
end