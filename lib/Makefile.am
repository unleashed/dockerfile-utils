dockerfile_utils_libdir = $(libdir)/dockerfile-utils
dockerfile_utils_lib_DATA = apt.sh build.sh functions.sh git.sh rbenv.sh

install-exec-am: install-dockerfile_utils_libDATA
	(FILES='$(dockerfile_utils_lib_DATA)'; \
	for file in $${FILES}; do \
	sed -e "s%@SCRIPT_LIB_PATH@%$(libdir)/dockerfile-utils%g" \
	    -i "$(DESTDIR)$(dockerfile_utils_libdir)"/$${file}; \
	done)
