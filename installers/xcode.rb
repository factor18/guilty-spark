module Installers
  class Xcode
    XCODE_INSTALLATION_TIMEOUT = 300.freeze
    XCODE_PATH = "/Library/Developer/CommandLineTools/Library/".freeze

    def ensure_installation
      $log.info "#{$identity}: I'm checking if xcode is installed, if not I'll install it"
      if !File.directory? XCODE_PATH
        install_xcode
      else
        $log.info "#{$identity}: Xcode is already installed"
      end
    end

    def install_xcode
      $log.warn "#{$identity}: Installing Xcode"
      timeout = Time.now + XCODE_INSTALLATION_TIMEOUT
      system("xcode-select --install")
      until File.directory? XCODE_PATH
        system("sleep 2")
        if Time.now > timeout
          $log.fatal "#{$identity}: #{xcode_timeout_message}"
          exit(false)
        end
      end
      $log.info "#{$identity}: Successfully installed Xcode"
    end

    private

    def xcode_timeout_message
      [
        "Xcode installation took more than #{XCODE_INSTALLATION_TIMEOUT/60} minutes",
        "Finish installation and run #{$PROGRAM_NAME} again once installation is completed"
      ].join("\n")
    end
  end
end