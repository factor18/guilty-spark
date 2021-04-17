module Installers
  class Prerequisites
    $brew_list = [
      {tap: "jq", command: "jq"},
      {tap: "fzf", command: "fzf"},
      {tap: "bat", command: "bat"},
      {tap: "tree", command: "tree"},
      {tap: "tldr", command: "tldr"},
      {tap: "tmux", command: "tmux"},
      {tap: "wget", command: "wget"},
      {tap: "httpie", command: "http"},
      {tap: "thefuck", command: "fuck"},
      {tap: "elixir", command: "elixir"},
      {tap: "trash-cli", command: "trash"},
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
      system("/usr/local/opt/fzf/install --all > /dev/null")
      $log.info "#{$identity}: Prerequisites are installed"
    end
  end
end