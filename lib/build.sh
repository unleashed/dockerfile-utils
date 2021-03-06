build_autoconf()
{
    local configure="${1}"

    { test -r ./configure || \
        { test -r ./autogen.sh && chmod +x ./autogen.sh && ./autogen.sh; } || \
        { aclocal && autoconf && automake --foreign --add-missing --copy; } || \
        autoreconf -fvi || \
        { touch ./configure && chmod +x ./configure; }; } \
    && echo "Calling ./configure ${configure}" \
    && eval "./configure ${configure}" \
    && make \
    && make install
}

build_git_autoconf_no_rm()
{
    local repo="${1}"
    local version="${2}"
    local configure="${3}"
    local dest="${4-$(build_dest_checkout_dir ${repo})}"
    local currdir="$(pwd)"

    git_clone_full ${repo} ${dest} \
    && cd ${dest} \
    && git_checkout ${version-latest-version} \
    && build_autoconf "${configure}" \
    && cd ${currdir}
}

build_git_autoconf()
{
    local repo="${1}"
    local dest="${4-$(build_dest_checkout_dir ${repo})}"
    build_git_autoconf_no_rm "${repo}" "${2}" "${3}" "${dest}" \
    && rm -rf ${dest}
}

build_tarball_autoconf_no_rm()
{
    local link="${1}"
    local tarballdir="${2}"
    local configure="${3}"
    local extension="${4}"
    local dest="${5-$(build_dest_tarball_dir)}"
    local currdir="$(pwd)"

    if test -z "${extension}"; then
        extension="${link}"
    fi

    extension="${extension##*.t}"
    extension="${extension##*ar.}"

    local cmd

    case "${extension}" in
        "bz2"|"bz")
            cmd="j"
            ;;
        "gz")
            cmd="z"
            ;;
        "xz")
            cmd="J"
            ;;
        *)
            echo "Unknown tarball compression format, got '${extension}'." >&2
            return false
            ;;
    esac
    mkdir ${dest} \
    && wget -qO- "${link}" | tar xv${cmd} -C ${dest} \
    && cd "${dest}/${tarballdir}" \
    && build_autoconf "${configure}" \
    && cd ${currdir}
}

build_tarball_autoconf()
{
    local repo="${1}"
    local dest="${5-$(build_dest_tarball_dir)}"
    build_tarball_autoconf_no_rm "${repo}" "${2}" "${3}" "${4}" "${dest}" \
    && rm -rf ${dest}
}

build_dest_checkout_dir()
{
    local repo="${1}"
    echo "/tmp/build_autoconf_$(basename ${repo%.git})"
}

build_dest_tarball_dir()
{
    echo "/tmp/build_autoconf_tarball"
}
