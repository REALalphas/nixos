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
    extraOptions = [ "--network=host" ];
    volumes = [
      "/home/alphas/labelit_dotenv:/app/.env"
    ];
    autoStart = true;
  };
}
