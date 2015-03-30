MAKEFILEDIR = $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

ifeq ($(shell uname -o),Cygwin)
win_path = $(shell cygpath -ma "$(1)")
uri = $(shell echo file:///$(call win_path,$(1))  | sed -r 's/ /%20/g')
else
win_path = $(shell readlink -fm "$(1)")
uri = $(shell echo file:$(abspath $(1))  | sed -r 's/ /%20/g')
endif

JAVA := java
DEBUG := yes
UI_LANG = en
HEAP = 1024m
CODE := $(MAKEFILEDIR)
CALABASH = $(CODE)/calabash/calabash.sh -D
CONF = $(CODE)/conf/transpect-conf.xml
DEVNULL = $(call win_path,/dev/null)
LC_ALL = en_US.UTF-8
FRONTEND_PIPELINES = adaptions/common/xpl/idml2html.xpl

OUT_DIR    = out
WORK_DIR_REL = 
BASENAME   = $(basename $(notdir $(IN_FILE)))
# Less transient storage for idml files and unzipped archives:
WORK_DIR   = $(shell readlink -m $(OUT_DIR)/../../$(BASENAME))
OUT_BASE   = $(OUT_DIR)/$(BASENAME)
IN_FILE_COPY = $(WORK_DIR)/$(notdir $(IN_FILE))
ifeq ($(suffix $(IN_FILE)),.idml)
	IN_FILE_COPY = $(WORK_DIR)/idml/$(notdir $(IN_FILE))
endif
HTMLREPORT = $(OUT_BASE).report.xhtml
HTML 	   = $(OUT_BASE).xhtml
HUB 	   = $(OUT_BASE).hub.xml
EPUB	   = $(OUT_BASE).epub
DEBUG_DIR  = $(WORK_DIR)/debug
DEBUG_DIR_URI = $(call uri,$(DEBUG_DIR))
PROGRESSDIR= $(OUT_DIR)/debug/status
ACTIONLOG  = $(PROGRESSDIR)/action.log

# need to be defined by default, in order to avoid cygpath warnings:
IN_FILE=nodoc

export
unexport out_base out_path win_path uri out_replace

default: usage


check_input:
ifeq ($(IN_FILE),)
	@echo Please specifiy IN_FILE
	@exit 1
endif

mkdirs:
	mkdir -p $(dir $(HTMLREPORT) $(HUB) $(HTML) $(IN_FILE_COPY)) $(PROGRESSDIR)


conversion: check_input mkdirs 
	-rm $(PROGRESSDIR)/*
	echo "$(BASENAME)" > $(PROGRESSDIR)/$(BASENAME).txt
	if [ $(IN_FILE) != $(IN_FILE_COPY) ]; then cp $(IN_FILE) $(IN_FILE_COPY); fi
	chmod 664 $(IN_FILE_COPY)
ifeq ($(suffix $(IN_FILE_COPY)),.idml)
	$(MAKE) idml2epub
else
ifeq ($(suffix $(IN_FILE_COPY)),.zip)
	$(MAKE) unzip
	-rm $(IN_FILE_COPY)
endif
endif

idml2epub:
	UI_LANG=$(UI_LANG) HEAP=$(HEAP) \
		$(CALABASH) -D \
		-i conf=$(call uri,$(CONF)) \
		-o hub=$(HUB) \
		-o html=$(HTML) \
		-o htmlreport=$(HTMLREPORT) \
		-o result=$(DEBUG_DIR)/result.xml \
		$(call uri,$(MAKEFILEDIR)/adaptions/common/xpl/idml2html.xpl) \
		input=$(call win_path,$(IN_FILE_COPY)) \
		interface-language=$(UI_LANG) \
		debug-dir-uri=$(DEBUG_DIR_URI) \
		status-dir-uri=$(call uri,$(PROGRESSDIR)) \
		debug=yes \
		$(XPROCPARAMS)
	-find $(WORK_DIR) -name '*.epub' -cnewer $(IN_FILE_COPY) -exec /bin/cp {} $(OUT_DIR) ';'
	$(MAKE) tree

transpectdoc: $(addprefix $(MAKEFILEDIR)/,$(FRONTEND_PIPELINES))
	-mkdir $(MAKEFILEDIR)/doc/transpectdoc
	$(CALABASH) $(foreach pipe,$^,$(addprefix -i source=,$(call uri,$(pipe)))) \
		$(call uri,$(MAKEFILEDIR)/transpectdoc/xpl/transpectdoc.xpl) \
		output-base-uri=$(call uri,$(MAKEFILEDIR)/doc/transpectdoc) \
		project-name=Unionsverlag \
		debug=$(DEBUG) 	debug-dir-uri=$(call uri,$(MAKEFILEDIR)/doc/transpectdoc/debug)

tree:
	tree -H "../../$(BASENAME)" $(WORK_DIR) > $(OUT_DIR)/filelist.html

unzip: 
	-mkdir -p $(PROGRESSDIR)
	@echo unzipping $(notdir $(IN_FILE_COPY)) >> $(PROGRESSDIR)/unzip.txt
	unzip -o $(IN_FILE_COPY) -x '__MACOSX*' -d $(WORK_DIR)
	$(MAKE) tree
#	mkdir -p $(dir $(IN_FILE_COPY))/unzipped && unzip -o $(IN_FILE_COPY) -x '__MACOSX*' -d $(dir $(IN_FILE_COPY))/unzipped
#	for f in $(shell find $(dir $(IN_FILE_COPY))/unzipped); do if [[ "$$f" =~ ' ' ]] ; then echo "$$f": Filename must not contain spaces >> $(PROGRESSDIR)/unzip.txt; exit 11; fi; done
#	$(MAKE) process_unzipped IN_FILE=$(dir $(IN_FILE_COPY))/unzipped


testi: check_input
	@echo $(EPUB)
	@echo $(call out_path,$(IN_FILE),,)/epub

progress:
	@ls -1rt "$(PROGRESSDIR)"/*.txt | xargs -d'\n' -I § sh -c 'date "+%H:%M:%S " -r § | tr -d [:cntrl:]; cat §'

usage:
	@echo "Usage: tbd"



