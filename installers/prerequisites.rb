module Installers
  class Prerequisites
    $brew_list = ["jq", "tree"]

    def ensure_installation
      $log.info "#{$identity}: Installing prerequisites"
      $brew_list.each do |item|
        next if(system("which #{item} > /dev/null"))
        if !system("brew install #{item}") || !system("which #{item} > /dev/null")
          $log.info "#{$identity}: Failed to install #{item}. Try running #{$PROGRAM_NAME} again"
          exit(false)
        end
      end
      $log.info "#{$identity}: Prerequisites are installed"
    end
  end
end