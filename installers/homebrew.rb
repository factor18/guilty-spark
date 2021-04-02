module Installers
  class Homebrew
    def ensure_installation
      $log.info "#{$identity}: I'm checking if Homebrew is installed, if not I'll install it"
      if !system('which brew > /dev/null')
        install_homebrew
      else
        $log.info "#{$identity}: Homebrew is already installed"
      end
    end

    def install_homebrew
      $log.warn "#{$identity}: Installing Homebrew"
      system("/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
      if !system("which brew > /dev/null")
        $log.fatal "#{$identity}: #{homebrew_error_message}"
        exit(false)
      end
      $log.info "#{$identity}: Successfully installed Homebrew"
    end

    private

    def homebrew_error_message
      [
        "Homebrew installation failed",
        "Try running #{$PROGRAM_NAME} again"
      ].join("\n")
    end
  end
end