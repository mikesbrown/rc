SHELL             = bash
.SHELLFLAGS       = -c -eu -o pipefail

OUT               = out

APPEND_FILES      = $(shell find append -type f)
REPLACE_FILES     = $(shell find replace -type f)
GITFILES          = git-completion.bash git-prompt.sh

BASE_APPEND_FILES = $(subst append/,,$(APPEND_FILES))
OUT_APPEND_FILES  = $(addprefix $(OUT)/,$(APPEND_FILES))
OUT_REPLACE_FILES = $(addprefix $(OUT)/,$(REPLACE_FILES))
OUT_GITFILES      = $(addprefix $(OUT)/replace/.git/,$(GITFILES))

all: $(OUT_APPEND_FILES) $(OUT_REPLACE_FILES) $(OUT_GITFILES)

$(OUT)/append/%: append/%
	@mkdir -p $(@D)
	@echo -e "\n# Appended to by https://github.com/mikesbrown/rc.git\n" > $@
	cat $< >> $@

$(OUT)/replace/%: replace/%
	@mkdir -p $(@D)
	cp -af $< $@

$(OUT_GITFILES): bin/getgit.bash
	$< $(@D)

clean:
	@rm -rf $(OUT)

replace: $(OUT_REPLACE_FILES)
	rsync -av --progress $(OUT)/replace/ $(HOME)

append: $(OUT_APPEND_FILES)
	cd $(OUT)/append &&            \
	for f in $(BASE_APPEND_FILES); \
	do                             \
	    cat $$f >> $(HOME)/$$f;    \
	done

install: all append replace

.PHONY: all clean install append replace
