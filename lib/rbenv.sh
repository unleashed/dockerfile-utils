gem_update_system()
{
    gem update --system --no-document
}

rbenv_ensure_ruby()
{
    ruby -v || {
        rbenv install && rbenv rehash && gem_update_system
    }
}

rbenv_ensure_bundler()
{
    bundler --version || gem install -N bundler
}

rbenv_ensure_platform()
{
    local dir="${1}"
    { test -z "${dir}" || cd "${dir}"; } && rbenv_ensure_ruby && rbenv_ensure_bundler
}

rbenv_ensure_ok()
{
    local dir="${1}"
    local with="${2-true}"

    rbenv_ensure_platform "${dir}" && eval "${with}" && bundle install
}

rbenv_exec()
{
    local dir="${1}"

    shift
    rbenv_ensure_ok "${dir}" && exec "${@}"
}

rbenv_bundle_exec()
{
    local dir="${1}"

    shift
    rbenv_ensure_ok "${dir}" && bundle exec "${@}"
}
