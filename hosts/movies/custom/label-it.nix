{
  pkgs,
  ...
}:

{
  environment.sessionVariables.PUPPETEER_SKIP_DOWNLOAD = 1;
  environment.sessionVariables.PUPPETEER_EXECUTABLE_PATH = "${pkgs.chromium.outPath}/bin/chromium";
  environment.systemPackages = [
    pkgs.chromium
  ];

  virtualisation.oci-containers.containers.labelIt = {
    image = "ghcr.io/realalphas/label-it:latest";
    ports = [
      "3001:3000"
    ];
    volumes = [
      "/home/alphas/labelit_dotenv:/app/.env"
    ];
    environment = {
      CHROMIUM_PATH = "/usr/bin/chromium";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
}
