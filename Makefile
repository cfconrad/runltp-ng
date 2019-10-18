perl_src = 	$(wildcard *.pm)\
		runltp-ng

define check_perl_file
    perl -I . -c $(1)
    perlcritic -p .perlcriticrc $(1)
    perltidy --pro=.perltidyrc $(1)
    diff $(1) $(1).tdy

endef

all: check

.PHONY: check
check:
	$(foreach file, $(perl_src), $(call check_perl_file ,$(file)))

.PHONY: tags
tags:
	ctags -f tags --recurse --totals --extras=+q \
	    --languages=Perl --langmap=Perl:+.t \
	    $(perl_src)

