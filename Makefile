# Makefile for
all: usage

SCRIPT=go-funcs.sh
EDITOR=vim

usage:
	@echo ""
	@echo "usage: make [edit|build|run]"
	@echo ""

# ---------------------------------------------------------------------------
edit e:
	$(EDITOR) $(SCRIPT)

edit-go eg:
	$(EDITOR) $(PROGRAM).go

edit-readme er:
	$(EDITOR) README.md

edit-makefile em:
	$(EDITOR) Makefile

build b:
	go build $(PROGRAM).go
	@ls -alF --color=auto

run r:
	./$(PROGRAM)

test t:
	./$(PROGRAM) tugboat 

rebuild:
	rm -f ./$(PROGRAM)
	go build $(PROGRAM).go
	@ls -alF --color=auto

install i:
	go install

clean:
	rm -f ./$(PROGRAM)

# ---------------------------------------------------------------------------
git-update gu:
	git add README.md Makefile *.sh
	git commit -m "Update some contents"
	git push -u https://sikang99@github.com/sikang99/go-funcs

git-status gs:
	git status
	git log --oneline -5

# ---------------------------------------------------------------------------
