{
  ...
}:

{
  virtualisation.oci-containers.containers.labelIt = {
    image = "ghcr.io/realalphas/label-it:latest";
    extraOptions = [ "--network=host" ];
    volumes = [
      "/home/alphas/label-it/.env:/app/.env"
    ];
    autoStart = true;
  };
}
