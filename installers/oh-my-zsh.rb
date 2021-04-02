module Installers
  class OhMyZsh
    OH_MY_ZSH_PATH = File.expand_path "~/.oh-my-zsh"

    def ensure_installation
      $log.info "#{$identity}: I'm checking if oh-my-zsh is installed, if not I'll install it"
      if !File.directory? OH_MY_ZSH_PATH
        install_oh_my_zsh
      else
        $log.info "#{$identity}: oh-my-zsh is already installed"
      end
    end

    def install_oh_my_zsh
      $log.warn "#{$identity}: Installing oh-my-zsh"
      system("sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended")
      if !File.directory? OH_MY_ZSH_PATH
        $log.fatal "#{$identity}: #{oh_my_zsh_error_message}"
        exit(false)
      end
      $log.info "#{$identity}: Successfully installed oh-my-zsh"
    end

    private

    def oh_my_zsh_error_message
      [
        "oh-my-zsh installation failed",
        "Try running #{$PROGRAM_NAME} again"
      ].join("\n")
    end
  end
end