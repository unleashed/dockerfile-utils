#!/bin/bash
test -f Makefile && make distclean
rm -rf config.* configure autom4te.cache aclocal.m4 NEWS AUTHORS \
    INSTALL depcomp install-sh missing
find . -type f -name "*.in" | grep -v '^\./create/' | xargs rm -f
find . -type f -name "Makefile" | grep -v '^\./create/' | xargs rm -f
