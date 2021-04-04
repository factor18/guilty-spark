module Installers
  class HNVM
    HNVM_PATH = File.expand_path "~/.hnvm"

    def ensure_installation
      $log.info "#{$identity}: I'm checking if HNVM is installed, if not I'll install it"
      if !File.directory? HNVM_PATH
        install_hnvm
      else
        $log.info "#{$identity}: HNVM is already installed"
      end
    end

    def install_hnvm
      $log.warn "#{$identity}: Installing HNVM"
      system("git clone git@github.com:factor18/hnvm.git ~/.hnvm")
      if !File.directory? HNVM_PATH
        $log.fatal "#{$identity}: #{hnvm_error_message}"
        exit(false)
      end
      system("cd #{HNVM_PATH}; ruby install.rb")
      exec("zsh -c \"source ~/.zshrc; ruby setup.rb\"")
      $log.info "#{$identity}: Successfully installed HNVM"
    end

    private

    def hnvm_error_message
      [
        "HNVM installation failed",
        "Try running #{$PROGRAM_NAME} again"
      ].join("\n")
    end
  end
end