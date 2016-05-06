git_remote_branches()
{
    git branch -r
}

git_origin_tracking_branch()
{
    local origin="${1-origin}"
    basename $(git_remote_branches | grep ${origin}/HEAD | awk '{ print $NF }')
}

git_clone()
{
    local url="${1}"
    local dest="${2}"
    git clone --recursive --single-branch ${1} ${2}
}

git_clone_full()
{
    local url="${1}"
    local dest="${2}"
    git clone --recursive ${1} ${2}
}

git_pull()
{
    local origin="${1-origin}"
    local tracking_branch="$(git_origin_tracking_branch ${origin})"
    git_checkout ${tracking_branch} \
    && git pull ${origin}
}

git_latest_version()
{
    local tag=$(git tag | grep -P "^v?\d[\d.]*$" | sed -e "s/^v//g" | sort -V | tail -n 1)

    if git rev-parse "${tag}" > /dev/null; then
        echo "${tag}"
    else
        echo "v${tag}"
    fi
}

git_checkout()
{
    local committish="${1}"

    test "${committish}" != "latest-version" || committish=$(git_latest_version)
    git checkout -f ${committish} \
    && git submodule update --checkout
}

git_checkout_latest_version()
{
    git_checkout "$(git_latest_version)"
}

git_update()
{
    local origin="${1-origin}"
    local committish="${2-latest-version}"

    git_pull ${origin} \
    && git_checkout ${committish}
}
