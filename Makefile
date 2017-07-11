
CHILDREN = $(shell _tools/relational_sorting.php)

# group children by level into CHILDREN<level_number>LEVEL vars
LEVELS = 1 2 3 4 5
$(foreach level,$(LEVELS), $(eval CHILDREN$$(level)LEVEL := $(shell _tools/relational_sorting.php $(level)) ))


COMMANDS = help all build test push publish publish-description clean status status-full calc-start calc-stop inheritance-status inheritance-status-full

.PHONY: $(COMMANDS)

help:
	@echo "Available commands: $(COMMANDS)"


all:
	for level in $(LEVELS); do \
		$(MAKE) all.$$level; \
	done


.FORCE: $(addprefix all.,$(LEVELS))
$(addprefix all.,$(LEVELS)):
	$(eval $@_level := $(subst .,,$(suffix $@)))
	$(MAKE) build.$($@_level) --output-sync
	$(MAKE) test.$($@_level)
	$(MAKE) push.$($@_level) --output-sync
	$(MAKE) clean.$($@_level) --output-sync


.FORCE: $(addprefix build.,$(LEVELS))
build.1: $(CHILDREN1LEVEL:=.build)
build.2: $(CHILDREN2LEVEL:=.build)
build.3: $(CHILDREN3LEVEL:=.build)
build.4: $(CHILDREN4LEVEL:=.build)
build.5: $(CHILDREN5LEVEL:=.build)


.FORCE: $(addprefix push.,$(LEVELS))
push.1: $(CHILDREN1LEVEL:=.push)
push.2: $(CHILDREN2LEVEL:=.push)
push.3: $(CHILDREN3LEVEL:=.push)
push.4: $(CHILDREN4LEVEL:=.push)
push.5: $(CHILDREN5LEVEL:=.push)


.FORCE: $(addprefix clean.,$(LEVELS))
clean.1: $(CHILDREN1LEVEL:=.clean)
clean.2: $(CHILDREN2LEVEL:=.clean)
clean.3: $(CHILDREN3LEVEL:=.clean)
clean.4: $(CHILDREN4LEVEL:=.clean)
clean.5: $(CHILDREN5LEVEL:=.clean)


.FORCE: $(addprefix test.,$(LEVELS))
$(addprefix test.,$(LEVELS)):
	$(eval $@_level := $(subst .,,$(suffix $@)))
	for dir in $(CHILDREN$($@_level)LEVEL); do \
		$(MAKE) test -C $$dir; \
	done


.FORCE: $(CHILDREN:=.build) $(CHILDREN:=.push) $(CHILDREN:=.clean)
%.build %.push %.clean:
	$(MAKE) $(subst .,,$(suffix $@)) -C $(basename $@)



build:
	for dir in $(CHILDREN); do \
		$(MAKE) build -C $$dir; \
	done

.SILENT: test
test:
	for dir in $(CHILDREN); do \
		echo -n $$dir '... ' ; \
		$(MAKE) test -s -C $$dir 2>&1 | fgrep "Tests passed" || echo _FAIL_; \
	done

push:
	for dir in $(CHILDREN); do \
		$(MAKE) push -C $$dir; \
	done

publish:
	for dir in $(CHILDREN); do \
		$(MAKE) publish -C $$dir; \
	done

.SILENT: publish-description
publish-description:
	for dir in $(CHILDREN); do \
		$(MAKE) -s publish-description -C $$dir; \
	done

clean:
	for dir in $(CHILDREN); do \
		$(MAKE) clean -C $$dir; \
	done

status:
	for dir in $(CHILDREN); do \
		$(MAKE) -s registry-status -C $$dir; \
	done

status-full:
	for dir in $(CHILDREN); do \
		$(MAKE) -s registry-status-full -C $$dir; \
	done

inheritance-status:
	@for dir in $(CHILDREN) $(DATA_CHILDREN); do \
		$(MAKE) -s inheritance-status -C $$dir; \
	done

inheritance-status-full:
	@for dir in $(CHILDREN) $(DATA_CHILDREN); do \
		$(MAKE) -s inheritance-status-full -C $$dir; \
	done

calc-start:
	for dir in $(CHILDREN); do \
		$(MAKE) -s calc-start -C $$dir; \
	done

calc-stop:
	for dir in $(CHILDREN); do \
		$(MAKE) -s calc-stop -C $$dir; \
	done

