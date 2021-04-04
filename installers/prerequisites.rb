module Installers
  class Prerequisites
    $brew_list = [
      {tap: "jq", command: "jq"},
      {tap: "tree", command: "tree"},
      {tap: "wget", command: "wget"},
    ]

    def ensure_installation
      $log.info "#{$identity}: Installing prerequisites"
      $brew_list.each do |item|
        next if(system("which #{item[:command]} > /dev/null"))
        if !system("brew install #{item[:tap]}") || !system("which #{item[:command]} > /dev/null")
          $log.info "#{$identity}: Failed to install #{item[:tap]}. Try running #{$PROGRAM_NAME} again"
          exit(false)
        end
      end
      $log.info "#{$identity}: Prerequisites are installed"
    end
  end
end