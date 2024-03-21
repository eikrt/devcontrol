{config, pkgs, ... }: {
        imports = [
        ];
      services.sshd = {
            enable = true;
      };
      services.openssh = { 
            enable = true;
            settings.PasswordAuthentication = false;
            settings.PermitRootLogin = "no";
      };
      services.xserver.enable = true;
      services.xserver.layout = "us";
      environment.systemPackages = with pkgs; [
        surf
        xorg.xrandr
        xorg.xset
      ];
      services.getty.autologinUser = "kiosk";
      services.xserver.displayManager.sessionCommands = ''
        exec startx /usr/bin/surf -F -z 1.5 -p https://is.fi
      '';
      users.users = {
        admin = {
                isNormalUser = true;
                createHome = true;
                description = "admin";
                extraGroups = ["wheel"];
                home = "/home/admin";
                initialHashedPassword = "$y$j9T$dNDkP04QFh0kXxVmaD5TI1$4tEAqY/Kr2YT2BanBsNyIWTBp8vSstCX3SCjy48Tm20";
                openssh.authorizedKeys.keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChX5tXTQt8Vf6z6g2vs/eVZUNGLz9/DrhuxtOTkgLUIo82CyP1qPi7EVn1+11S50aaB3CXPiX2APZQq8+aS3jzOWv4u54hwtomORQ7vXXPPFcgv6LeW4N1MuMWAEYdpP/BwfSi9MkNhu5s+hehUSexCZFkHZ5pUCqwMWGYD6MXtokS7/7DkrBx2Ni5LnKvRuXwrerwTK58WurQOojm6xUU82jMHZYt2VkDbLlJJEAgRqf1MnbpuTkoQWjG3zDdbEKiF9nOliGCiUw5ORp7NUk2u0KLAt8Sh09/Lqlpz+q8kE1Lk6LPfld8CgqkAV2iqP6WgplmMXePuhwXErKgVfAlCVr4+3j67RSIH4jS/Q50B30rjaVEtm3nCr/iMLXgA1JpoF8wj6pUVsKJ1m9btJBD7LJTQcYheMFT1B/XsLuQX0eCakDKodRNprNPx8Eid9Z/xcJxvP/6ZUo4ANsVoQ0X1Rid5JzgPdazTgQPbQY2KvfWvriRttX85R7dTZjl8yk= admin@nixos" 
                ];
        };
        kiosk = {
            isNormalUser = true;
            home = "/home/kiosk";
            createHome = true;
        };
     };
} 
