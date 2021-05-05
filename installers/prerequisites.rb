module Installers
  class Prerequisites
    $brew_list = [
      {formula: "jq", command: "jq"},
      {formula: "fzf", command: "fzf"},
      {formula: "bat", command: "bat"},
      {formula: "tree", command: "tree"},
      {formula: "tldr", command: "tldr"},
      {formula: "tmux", command: "tmux"},
      {formula: "wget", command: "wget"},
      {formula: "httpie", command: "http"},
      {formula: "thefuck", command: "fuck"},
      {formula: "elixir", command: "elixir"},
      {formula: "thrift", command: "thrift"},
      {formula: "trash-cli", command: "trash"},
      {formula: "ngrok", command: "ngrok", cask: true},
      {tap: "gigalixir/brew", formula: "gigalixir", command: "gigalixir"},
    ]

    def ensure_installation
      $log.info "#{$identity}: Installing prerequisites"
      $brew_list.each do |item|
        next if(system("which #{item[:command]} > /dev/null"))
        print "."
        if !item[:tap].nil? && !system("brew tap #{item[:cask] ? "--cask" : ""} #{item[:tap]} > /dev/null") || !system("brew install #{item[:formula]} > /dev/null") || !system("which #{item[:command]} > /dev/null")
          $log.info "#{$identity}: Failed to install #{item[:formula]}. Try running #{$PROGRAM_NAME} again"
          exit(false)
        end
      end
      puts ""
      system("/usr/local/opt/fzf/install --all > /dev/null")
      $log.info "#{$identity}: Prerequisites are installed"
    end
  end
end
