# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
  virtualisation.oci-containers.backend = "docker";

  # Containers
  virtualisation.oci-containers.containers."appflowy-cloud-admin_frontend" = {
    image = "appflowyinc/admin_frontend:latest";
    environment = {
      "ADMIN_FRONTEND_APPFLOWY_CLOUD_URL" = "http://appflowy_cloud:8000";
      "ADMIN_FRONTEND_GOTRUE_URL" = "http://gotrue:9999";
      "ADMIN_FRONTEND_PATH_PREFIX" = "/console";
      "ADMIN_FRONTEND_REDIS_URL" = "redis://redis:6379";
      "RUST_LOG" = "info";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    dependsOn = [
      "appflowy-cloud-appflowy_cloud"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=admin_frontend"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-admin_frontend" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-ai" = {
    image = "appflowyinc/appflowy_ai:latest";
    environment = {
      "APPFLOWY_AI_DATABASE_URL" = "postgresql+psycopg://postgres:password@postgres:5432/postgres";
      "APPFLOWY_AI_REDIS_URL" = "redis://redis:6379";
      "APPFLOWY_AI_SERVER_PORT" = "5001";
      "OPENAI_API_KEY" = "";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    dependsOn = [
      "appflowy-cloud-postgres"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=ai"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-ai" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-appflowy_cloud" = {
    image = "appflowyinc/appflowy_cloud:latest";
    environment = {
      "AI_OPENAI_API_KEY" = "";
      "AI_SERVER_HOST" = "ai";
      "AI_SERVER_PORT" = "5001";
      "APPFLOWY_ACCESS_CONTROL" = "true";
      "APPFLOWY_ADMIN_FRONTEND_PATH_PREFIX" = "/console";
      "APPFLOWY_DATABASE_MAX_CONNECTIONS" = "40";
      "APPFLOWY_DATABASE_URL" = "postgres://postgres:password@postgres:5432/postgres";
      "APPFLOWY_ENVIRONMENT" = "production";
      "APPFLOWY_GOTRUE_ADMIN_EMAIL" = "admin@example.com";
      "APPFLOWY_GOTRUE_ADMIN_PASSWORD" = "password";
      "APPFLOWY_GOTRUE_BASE_URL" = "http://gotrue:9999";
      "APPFLOWY_GOTRUE_EXT_URL" = "http://localhost/gotrue";
      "APPFLOWY_GOTRUE_JWT_EXP" = "7200";
      "APPFLOWY_GOTRUE_JWT_SECRET" = "hello456";
      "APPFLOWY_MAILER_SMTP_EMAIL" = "email_sender@some_company.com";
      "APPFLOWY_MAILER_SMTP_HOST" = "smtp.gmail.com";
      "APPFLOWY_MAILER_SMTP_PASSWORD" = "email_sender_password";
      "APPFLOWY_MAILER_SMTP_PORT" = "465";
      "APPFLOWY_MAILER_SMTP_TLS_KIND" = "wrapper";
      "APPFLOWY_MAILER_SMTP_USERNAME" = "email_sender@some_company.com";
      "APPFLOWY_REDIS_URI" = "redis://redis:6379";
      "APPFLOWY_S3_ACCESS_KEY" = "minioadmin";
      "APPFLOWY_S3_BUCKET" = "appflowy";
      "APPFLOWY_S3_CREATE_BUCKET" = "true";
      "APPFLOWY_S3_MINIO_URL" = "http://minio:9000";
      "APPFLOWY_S3_PRESIGNED_URL_ENDPOINT" = "";
      "APPFLOWY_S3_REGION" = "";
      "APPFLOWY_S3_SECRET_KEY" = "minioadmin";
      "APPFLOWY_S3_USE_MINIO" = "true";
      "APPFLOWY_WEB_URL" = "http://localhost";
      "RUST_LOG" = "info";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    dependsOn = [
      "appflowy-cloud-gotrue"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=appflowy_cloud"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-appflowy_cloud" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-appflowy_web" = {
    image = "appflowyinc/appflowy_web:latest";
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    dependsOn = [
      "appflowy-cloud-appflowy_cloud"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=appflowy_web"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-appflowy_web" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-appflowy_worker" = {
    image = "appflowyinc/appflowy_worker:latest";
    environment = {
      "APPFLOWY_ENVIRONMENT" = "production";
      "APPFLOWY_MAILER_SMTP_EMAIL" = "email_sender@some_company.com";
      "APPFLOWY_MAILER_SMTP_HOST" = "smtp.gmail.com";
      "APPFLOWY_MAILER_SMTP_PASSWORD" = "email_sender_password";
      "APPFLOWY_MAILER_SMTP_PORT" = "465";
      "APPFLOWY_MAILER_SMTP_TLS_KIND" = "wrapper";
      "APPFLOWY_MAILER_SMTP_USERNAME" = "email_sender@some_company.com";
      "APPFLOWY_S3_ACCESS_KEY" = "minioadmin";
      "APPFLOWY_S3_BUCKET" = "appflowy";
      "APPFLOWY_S3_MINIO_URL" = "http://minio:9000";
      "APPFLOWY_S3_REGION" = "";
      "APPFLOWY_S3_SECRET_KEY" = "minioadmin";
      "APPFLOWY_S3_USE_MINIO" = "true";
      "APPFLOWY_WORKER_DATABASE_NAME" = "postgres";
      "APPFLOWY_WORKER_DATABASE_URL" = "postgres://postgres:password@postgres:5432/postgres";
      "APPFLOWY_WORKER_ENVIRONMENT" = "production";
      "APPFLOWY_WORKER_IMPORT_TICK_INTERVAL" = "30";
      "APPFLOWY_WORKER_REDIS_URL" = "redis://redis:6379";
      "RUST_LOG" = "info";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    dependsOn = [
      "appflowy-cloud-postgres"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=appflowy_worker"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-appflowy_worker" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-gotrue" = {
    image = "appflowyinc/gotrue:latest";
    environment = {
      "API_EXTERNAL_URL" = "http://localhost/gotrue";
      "DATABASE_URL" = "postgres://supabase_auth_admin:root@postgres:5432/postgres";
      "GOTRUE_ADMIN_EMAIL" = "admin@example.com";
      "GOTRUE_ADMIN_PASSWORD" = "password";
      "GOTRUE_DB_DRIVER" = "postgres";
      "GOTRUE_DISABLE_SIGNUP" = "false";
      "GOTRUE_EXTERNAL_DISCORD_CLIENT_ID" = "";
      "GOTRUE_EXTERNAL_DISCORD_ENABLED" = "false";
      "GOTRUE_EXTERNAL_DISCORD_REDIRECT_URI" = "http://localhost/gotrue/callback";
      "GOTRUE_EXTERNAL_DISCORD_SECRET" = "";
      "GOTRUE_EXTERNAL_GITHUB_CLIENT_ID" = "";
      "GOTRUE_EXTERNAL_GITHUB_ENABLED" = "false";
      "GOTRUE_EXTERNAL_GITHUB_REDIRECT_URI" = "http://localhost/gotrue/callback";
      "GOTRUE_EXTERNAL_GITHUB_SECRET" = "";
      "GOTRUE_EXTERNAL_GOOGLE_CLIENT_ID" = "";
      "GOTRUE_EXTERNAL_GOOGLE_ENABLED" = "false";
      "GOTRUE_EXTERNAL_GOOGLE_REDIRECT_URI" = "http://localhost/gotrue/callback";
      "GOTRUE_EXTERNAL_GOOGLE_SECRET" = "";
      "GOTRUE_JWT_ADMIN_GROUP_NAME" = "supabase_admin";
      "GOTRUE_JWT_EXP" = "7200";
      "GOTRUE_JWT_SECRET" = "hello456";
      "GOTRUE_MAILER_AUTOCONFIRM" = "true";
      "GOTRUE_MAILER_TEMPLATES_MAGIC_LINK" = "";
      "GOTRUE_MAILER_URLPATHS_CONFIRMATION" = "/gotrue/verify";
      "GOTRUE_MAILER_URLPATHS_EMAIL_CHANGE" = "/gotrue/verify";
      "GOTRUE_MAILER_URLPATHS_INVITE" = "/gotrue/verify";
      "GOTRUE_MAILER_URLPATHS_RECOVERY" = "/gotrue/verify";
      "GOTRUE_RATE_LIMIT_EMAIL_SENT" = "100";
      "GOTRUE_SAML_ENABLED" = "false";
      "GOTRUE_SAML_PRIVATE_KEY" = "";
      "GOTRUE_SITE_URL" = "appflowy-flutter://";
      "GOTRUE_SMTP_ADMIN_EMAIL" = "comp_admin@some_company.com";
      "GOTRUE_SMTP_HOST" = "smtp.gmail.com";
      "GOTRUE_SMTP_MAX_FREQUENCY" = "1ns";
      "GOTRUE_SMTP_PASS" = "email_sender_password";
      "GOTRUE_SMTP_PORT" = "465";
      "GOTRUE_SMTP_USER" = "email_sender@some_company.com";
      "GOTRUE_URI_ALLOW_LIST" = "**";
      "PORT" = "9999";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    dependsOn = [
      "appflowy-cloud-postgres"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=curl --fail http://127.0.0.1:9999/health || exit 1"
      "--health-interval=5s"
      "--health-retries=12"
      "--health-timeout=5s"
      "--network-alias=gotrue"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-gotrue" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-minio" = {
    image = "minio/minio";
    environment = {
      "MINIO_BROWSER_REDIRECT_URL" = "http://localhost/minio";
      "MINIO_ROOT_PASSWORD" = "minioadmin";
      "MINIO_ROOT_USER" = "minioadmin";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    volumes = [
      "appflowy-cloud_minio_data:/data:rw"
    ];
    cmd = [ "server" "/data" "--console-address" ":9001" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=minio"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-minio" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
      "docker-volume-appflowy-cloud_minio_data.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
      "docker-volume-appflowy-cloud_minio_data.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-nginx" = {
    image = "nginx";
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    volumes = [
      "/home/files/repos/AppFlowy-Cloud/nginx/nginx.conf:/etc/nginx/nginx.conf:rw"
      "/home/files/repos/AppFlowy-Cloud/nginx/ssl/certificate.crt:/etc/nginx/ssl/certificate.crt:rw"
      "/home/files/repos/AppFlowy-Cloud/nginx/ssl/private_key.key:/etc/nginx/ssl/private_key.key:rw"
    ];
    ports = [
      "80:80/tcp"
      "443:443/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=nginx"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-nginx" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-postgres" = {
    image = "pgvector/pgvector:pg16";
    environment = {
      "POSTGRES_DB" = "postgres";
      "POSTGRES_HOST" = "postgres";
      "POSTGRES_PASSWORD" = "password";
      "POSTGRES_USER" = "postgres";
      "SUPABASE_PASSWORD" = "root";
    };
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    volumes = [
      "/home/files/repos/AppFlowy-Cloud/migrations/before:/docker-entrypoint-initdb.d:rw"
      "appflowy-cloud_postgres_data:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=[\"pg_isready\", \"-U\", \"postgres\", \"-d\", \"postgres\"]"
      "--health-interval=5s"
      "--health-retries=12"
      "--health-timeout=5s"
      "--network-alias=postgres"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-postgres" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
      "docker-volume-appflowy-cloud_postgres_data.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
      "docker-volume-appflowy-cloud_postgres_data.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };
  virtualisation.oci-containers.containers."appflowy-cloud-redis" = {
    image = "redis";
    environmentFiles = [
      "/home/files/repos/AppFlowy-Cloud/.env"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=redis"
      "--network=appflowy-cloud_default"
    ];
  };
  systemd.services."docker-appflowy-cloud-redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
      RestartMaxDelaySec = lib.mkOverride 90 "1m";
      RestartSec = lib.mkOverride 90 "100ms";
      RestartSteps = lib.mkOverride 90 9;
    };
    after = [
      "docker-network-appflowy-cloud_default.service"
    ];
    requires = [
      "docker-network-appflowy-cloud_default.service"
    ];
    partOf = [
      "docker-compose-appflowy-cloud-root.target"
    ];
    wantedBy = [
      "docker-compose-appflowy-cloud-root.target"
    ];
  };

  # Networks
  systemd.services."docker-network-appflowy-cloud_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f appflowy-cloud_default";
    };
    script = ''
      docker network inspect appflowy-cloud_default || docker network create appflowy-cloud_default
    '';
    partOf = [ "docker-compose-appflowy-cloud-root.target" ];
    wantedBy = [ "docker-compose-appflowy-cloud-root.target" ];
  };

  # Volumes
  systemd.services."docker-volume-appflowy-cloud_minio_data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect appflowy-cloud_minio_data || docker volume create appflowy-cloud_minio_data
    '';
    partOf = [ "docker-compose-appflowy-cloud-root.target" ];
    wantedBy = [ "docker-compose-appflowy-cloud-root.target" ];
  };
  systemd.services."docker-volume-appflowy-cloud_postgres_data" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      docker volume inspect appflowy-cloud_postgres_data || docker volume create appflowy-cloud_postgres_data
    '';
    partOf = [ "docker-compose-appflowy-cloud-root.target" ];
    wantedBy = [ "docker-compose-appflowy-cloud-root.target" ];
  };

  # Builds
  systemd.services."docker-build-appflowy-cloud-admin_frontend" = {
    path = [ pkgs.docker pkgs.git ];
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = 300;
    };
    script = ''
      cd /home/files/repos/AppFlowy-Cloud
      docker build -t appflowyinc/admin_frontend:latest -f ./admin_frontend/Dockerfile .
    '';
  };
  systemd.services."docker-build-appflowy-cloud-appflowy_cloud" = {
    path = [ pkgs.docker pkgs.git ];
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = 300;
    };
    script = ''
      cd /home/files/repos/AppFlowy-Cloud
      docker build -t appflowyinc/appflowy_cloud:latest --build-arg FEATURES= .
    '';
  };
  systemd.services."docker-build-appflowy-cloud-appflowy_worker" = {
    path = [ pkgs.docker pkgs.git ];
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = 300;
    };
    script = ''
      cd /home/files/repos/AppFlowy-Cloud
      docker build -t appflowyinc/appflowy_worker:latest -f ./services/appflowy-worker/Dockerfile .
    '';
  };
  systemd.services."docker-build-appflowy-cloud-gotrue" = {
    path = [ pkgs.docker pkgs.git ];
    serviceConfig = {
      Type = "oneshot";
      TimeoutSec = 300;
    };
    script = ''
      cd /home/files/repos/AppFlowy-Cloud/docker/gotrue
      docker build -t appflowyinc/gotrue:latest .
    '';
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-appflowy-cloud-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
