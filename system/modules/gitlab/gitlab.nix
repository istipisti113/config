{config, pkgs, unstable, ...}:
{
  services.gitlab = {
    enable = true;
    databasePasswordFile = pkgs.writeText "dbPassword" "zgvcyfwsxzcwr85l";
    initialRootPasswordFile = pkgs.writeText "rootPassword" "dakqdvp4ovhksxer";
    secrets = {
      secretFile = "./secret";
      otpFile = "./otpsecret";
      dbFile = "./dbsecret";
      jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      localhost = {
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
  };

  services.openssh.enable = true;

  systemd.services.gitlab-backup.environment.BACKUP = "dump";

}
