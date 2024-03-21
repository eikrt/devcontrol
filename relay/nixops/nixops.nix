{
  network.description = "Web server";

  network.storage.legacy = {
    databasefile = "~/.nixops/deployments.nixops";
  };
  webserver =
    { config, pkgs, ...  }:
    {
      services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80  ];
      deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 1024;
      deployment.virtualbox.vcpu = 2;
     };

}
