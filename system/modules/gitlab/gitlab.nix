{config, pkgs, unstable, ...}:
{
  services.gitlab = {
    enable = true;
    port = 80;

    databaseCreateLocally = true;
    databasePasswordFile = "/var/gitlab/state/passwd/dbPassword" ;
    initialRootPasswordFile ="/var/gitlab/state/passwd/rootPassword" ;
    secrets = {
      secretFile = "/var/gitlab/state/passwd/secret";
      otpFile = "/var/gitlab/state/passwd/otpsecret";
      dbFile = "/var/gitlab/state/passwd/dbsecret";
      activeRecordSaltFile = "/var/gitlab/state/passwd/activeRecordSaltFile";
      activeRecordPrimaryKeyFile = "/var/gitlab/state/passwd/activeRecordPrimaryKeyFile";
      activeRecordDeterministicKeyFile = "/var/gitlab/state/passwd/activeRecordDeterministicKeyFile";
      jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    clientMaxBodySize = "2g";
    virtualHosts = {
      localhost = {
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
  };

  services.openssh.enable = true;

  systemd.services.gitlab-backup.environment.BACKUP = "dump";

}
