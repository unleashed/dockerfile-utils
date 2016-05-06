apt_install()
{
    local pkgs="${@}"

    apt-get install -y -q ${pkgs} \
    && apt-get clean -y -q
}

apt_update()
{
    apt-get update -y -q
}

apt_up_install()
{
    apt_update && apt_install "$@"
}

apt_dist_upgrade()
{
    apt-get dist-upgrade -y -q
}
