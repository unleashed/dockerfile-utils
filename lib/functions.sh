for f in "@SCRIPT_LIB_PATH@"/*.sh; do
    if test "$(basename ${f})" != "functions.sh"; then
        . ${f}
    fi
done
