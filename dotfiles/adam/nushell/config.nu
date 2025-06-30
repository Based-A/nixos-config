$env.config.hooks = {
    env_change: {
        PWD: [{ ||
            if (which direnv | is-empty) {
                return
            }
            direnv export json | from json | default {} | load-env
            $env.PATH = $env.PATH | split row (char env_sep)
        }]
    }
}

$env.config.show_banner = false
$env.config.buffer_editor = "/etc/links/zed-editor"
source ~/.zoxide.nu
