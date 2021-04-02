module Scripts
  class ZSH
    def ensure_zsh_default_shell
      $log.info "#{$identity}: I'm changing the default shell to zsh"
      if `echo $SHELL | grep -o zsh`.strip != "zsh"
        if !system("chsh -s /bin/zsh &> /dev/null")
          $log.fatal "#{$identity}: #{zsh_error_message}"
          exit(false)
        end
        $log.info "#{$identity}: zsh is the default shell now"
      else
        $log.info "#{$identity}: zsh is already the default shell"
      end
    end

    def zsh_error_message
      [
        "Couldn't make zsh default shell",
        "Try running #{$PROGRAM_NAME} again"
      ].join("\n")
    end
  end
end