# Auto-generated using compose2nix v0.3.1.
{ 
  pkgs, 
  lib, 
  config,
  host,
  ... 
}:
{
  options = {
    resolve_db.enable = lib.mkEnableOption "enables a davinci resolve project server running in a podman container.";
  };

  config = lib.mkIf config.resolve_db.enable {

    # Runtime
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        # Required for container networking to be able to use names.
        dns_enabled = true;
      };
    };

    # Enable container name DNS for non-default Podman networks.
    # https://github.com/NixOS/nixpkgs/issues/226365
    networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 9080 ];

    virtualisation.oci-containers.backend = "podman";

    # Containers
    virtualisation.oci-containers.containers."resolve_pgadmin" = {
      image = "dpage/pgadmin4";
      environment = {
        "PGADMIN_DEFAULT_EMAIL" = "adamlundrigan1@gmail.com";
        "PGADMIN_DEFAULT_PASSWORD" = "root";
        "PGADMIN_PORT" = "3001:9080";
      };
      volumes = [
        "/home/${host}/containers/cuff2025_dr_database_backups:/backups"#:rw
        "resolve_db_pgadmin:/var/lib/pgadmin"#:rw
        "resolve_db_pgadmin-config:/pgadmin4-config"#:rw
      ];
      ports = [
        "3001:9080/tcp"
      ];
      cmd = [ "-c" "mkdir -p /var/lib/pgadmin/storage/\${PGADMIN_DEFAULT_EMAIL//@/_}/
      ln -s /backups /var/lib/pgadmin/storage/\${PGADMIN_DEFAULT_EMAIL//@/_}/
      /entrypoint.sh
      " ];
      dependsOn = [
        "resolve_pgadmin-config-creator"
        "resolve_pgsql"
      ];
      log-driver = "journald";
      extraOptions = [
        "--entrypoint=[\"/bin/sh\"]"
        "--health-cmd=wget --no-verbose --tries=1 --spider http://localhost/ || exit 1"
        "--network-alias=pgadmin"
        "--network=resolve_db_default"
      ];
    };
    systemd.services."podman-resolve_pgadmin" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-resolve_db_default.service"
        "podman-volume-resolve_db_pgadmin-config.service"
        "podman-volume-resolve_db_pgadmin.service"
      ];
      requires = [
        "podman-network-resolve_db_default.service"
        "podman-volume-resolve_db_pgadmin-config.service"
        "podman-volume-resolve_db_pgadmin.service"
      ];
      partOf = [
        "podman-compose-resolve_db-root.target"
      ];
      wantedBy = [
        "podman-compose-resolve_db-root.target"
      ];
    };
    virtualisation.oci-containers.containers."resolve_pgadmin-config-creator" = {
      image = "ghcr.io/elliotmatson/pgadmin-config-creator:latest";
      environment = {
        "PGADMIN_SERVER_JSON_FILE" = "/pgadmin4-config/servers.json";
        "POSTGRES_DB" = "cuff2025_dr_database";
        "POSTGRES_LOCATION" = "/home/${host}/containers/cuff2025_dr_database";
        "POSTGRES_PASSWORD" = "DaVinci";
        "POSTGRES_USER" = "postgres";
        "TZ" = "America/Edmonton";
      };
      volumes = [
        "resolve_db_pgadmin-config:/config"#:rw
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=pgadmin-config"
        "--network=resolve_db_default"
      ];
    };
    systemd.services."podman-resolve_pgadmin-config-creator" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "on-failure";
      };
      after = [
        "podman-network-resolve_db_default.service"
        "podman-volume-resolve_db_pgadmin-config.service"
      ];
      requires = [
        "podman-network-resolve_db_default.service"
        "podman-volume-resolve_db_pgadmin-config.service"
      ];
      partOf = [
        "podman-compose-resolve_db-root.target"
      ];
      wantedBy = [
        "podman-compose-resolve_db-root.target"
      ];
    };
    virtualisation.oci-containers.containers."resolve_pgbackup" = {
      image = "prodrigestivill/postgres-backup-local:17";
      environment = {
        "BACKUP_KEEP_DAYS" = "7";
        "BACKUP_KEEP_MONTHS" = "6";
        "BACKUP_KEEP_WEEKS" = "4";
        "BACKUP_LOCATION" = "/home/${host}/containers/cuff2025_dr_database_backups:/backups";
        "BACKUP_SUFFIX" = ".backup";
        "HEALTHCHECK_PORT" = "8080";
        "POSTGRES_DB" = "cuff2025_dr_database";
        "POSTGRES_EXTRA_OPTS" = "--blobs --format=custom --quote-all-identifiers";
        "POSTGRES_HOST" = "postgres";
        "POSTGRES_LOCATION" = "/home/${host}/containers/cuff2025_dr_database";
        "POSTGRES_PASSWORD" = "DaVinci";
        "POSTGRES_USER" = "postgres";
        "SCHEDULE" = "@every 3h";
        "TZ" = "America/Edmonton";
      };
      volumes = [
        "/home/adam/containers/cuff2025_dr_database_backups:/backups"#:rw
      ];
      dependsOn = [
        "resolve_pgsql"
      ];
      log-driver = "journald";
      extraOptions = [
        "--health-interval=30s"
        "--network-alias=pgbackups"
        "--network=resolve_db_default"
      ];
    };
    systemd.services."podman-resolve_pgbackup" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-resolve_db_default.service"
      ];
      requires = [
        "podman-network-resolve_db_default.service"
      ];
      partOf = [
        "podman-compose-resolve_db-root.target"
      ];
      wantedBy = [
        "podman-compose-resolve_db-root.target"
      ];
    };
    virtualisation.oci-containers.containers."resolve_pgsql" = {
      image = "postgres:13";
      environment = {
        "POSTGRES_DB" = "cuff2025_dr_database";
        "POSTGRES_LOCATION" = "/home/${host}/containers/cuff2025_dr_database"; #:/var/lib/postgresql/data
        "POSTGRES_PASSWORD" = "DaVinci";
        "POSTGRES_USER" = "postgres";
        "TZ" = "America/Edmonton";
      };
      volumes = [
        "/home/${host}/containers/cuff2025_dr_database"#:rw
      ];
      ports = [
        "5432:5432/tcp"
      ];
      log-driver = "journald";
      extraOptions = [
        "--health-cmd=[\"pg_isready\", \"-U\", \"postgres\"]"
        "--health-interval=10s"
        "--health-retries=5"
        "--health-timeout=5s"
        "--network-alias=postgres"
        "--network=resolve_db_default"
      ];
    };
    systemd.services."podman-resolve_pgsql" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
      };
      after = [
        "podman-network-resolve_db_default.service"
      ];
      requires = [
        "podman-network-resolve_db_default.service"
      ];
      partOf = [
        "podman-compose-resolve_db-root.target"
      ];
      wantedBy = [
        "podman-compose-resolve_db-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-resolve_db_default" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f resolve_db_default";
      };
      script = ''
        podman network inspect resolve_db_default || podman network create resolve_db_default
      '';
      partOf = [ "podman-compose-resolve_db-root.target" ];
      wantedBy = [ "podman-compose-resolve_db-root.target" ];
    };

    # Volumes
    systemd.services."podman-volume-resolve_db_pgadmin" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        podman volume inspect resolve_db_pgadmin || podman volume create resolve_db_pgadmin
      '';
      partOf = [ "podman-compose-resolve_db-root.target" ];
      wantedBy = [ "podman-compose-resolve_db-root.target" ];
    };
    systemd.services."podman-volume-resolve_db_pgadmin-config" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        podman volume inspect resolve_db_pgadmin-config || podman volume create resolve_db_pgadmin-config
      '';
      partOf = [ "podman-compose-resolve_db-root.target" ];
      wantedBy = [ "podman-compose-resolve_db-root.target" ];
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."podman-compose-resolve_db-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = [ "multi-user.target" ];
    };

    networking.firewall.allowedTCPPorts = [ 9080 ];
  };
}
# See: https://github.com/elliotmatson/Docker-Davinci-Resolve-Project-Server
