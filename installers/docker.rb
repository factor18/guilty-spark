require 'io/console'

module Installers
  class Docker
    DOCKER_INSTALLATION_TIMEOUT = 60.freeze

    def ensure_installation
      $log.info "#{$identity}: I'm checking if Docker is installed, if not I'll install it"
      if !system('which docker > /dev/null')
        install_docker
        $log.info "#{$identity}: Starting docker engine"
        start_docker
        verify_installation
      else
        $log.info "#{$identity}: Docker is already installed"
      end

      login_to_docker
    end

    def install_docker
      $log.warn "#{$identity}: Installing Docker"
      if !system("brew install --cask docker")
        $log.info "#{$identity}: Couldn't start docker. Try running #{$PROGRAM_NAME} again"
      end
      $log.info "#{$identity}: Successfully installed Docker"
    end

    def start_docker
      system("killall Docker")

      if system("open -a Docker")
        $log.info "#{$identity}: Starting docker now. Continue with the installation"
      else
        $log.info "#{$identity}: Couldn't start docker. Try running #{$PROGRAM_NAME} again"
        exit(false)
      end
    end 

    def verify_installation
      timeout = Time.now + DOCKER_INSTALLATION_TIMEOUT
      until system("which docker > /dev/null")
        system("sleep 2")
        if Time.now > timeout
          $log.fatal "#{$identity}: #{docker_error_message}"
          exit(false)
        end
      end
      $log.info "#{$identity}: Docker is now installed"
    end

    def login_to_docker
      $log.info "#{$identity}: Attempting to login to docker"
      retry_count = 0
      while `cat ~/.docker/config.json | jq -r ".auths"`.strip == "{}"
        puts "Enter docker hub username"
        username = gets.chomp
        puts "Enter password"
        password = STDIN.noecho(&:gets).chomp
        if (!system("docker login -u #{username} -p #{password}"))
          retry_count += 1
          if retry_count <= 3
            $log.warn "#{$identity}: Login failed. Try again later"
            exit(false)
          end
          $log.warn "#{$identity}: Login failed. Try again"
        end
      end
    end

    private

    def docker_error_message
      [
        "Docker installation failed",
        "Try running #{$PROGRAM_NAME} again"
      ].join("\n")
    end

    def docker_timeout_message
      [
        "Docker installation took more than #{DOCKER_INSTALLATION_TIMEOUT} seconds",
        "Try running #{$PROGRAM_NAME} again once installation is complete"
      ].join("\n")
    end
  end
end