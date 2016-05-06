dockerfile_utils_templateddir = $(bindir)
dockerfile_utils_templated_SCRIPTS = df-run df-enable df-update

install-exec-am: install-dockerfile_utils_templatedSCRIPTS
	(FILES='$(dockerfile_utils_templated_SCRIPTS)'; \
	for file in $${FILES}; do \
	sed -e "s%@SCRIPT_PREFIX_PATH@%$(prefix)%g" \
	    -e "s%@SCRIPT_BIN_PATH@%$(bindir)%g" \
	    -e "s%@SCRIPT_LIB_PATH@%$(libdir)/dockerfile-utils%g" \
	    -i "$(DESTDIR)$(dockerfile_utils_templateddir)"/$${file}; \
	done)
