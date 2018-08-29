#
# Makefile by Stoney
#
all: usage

SCRIPT=go-funcs.sh
EDITOR=vim

usage:
	@echo ""
	@echo "usage: make [edit|run|git]"
	@echo ""

# ---------------------------------------------------------------------------
edit e:
	@echo ""
	@echo "make (edit) [sh|readme|make]"
	@echo ""

edit-sh es:
	$(EDITOR) $(SCRIPT)

edit-readme er:
	$(EDITOR) README.md

edit-make em:
	$(EDITOR) Makefile

# ---------------------------------------------------------------------------
run r:
	./$(SCRIPT)

cp:
	cp ~/.bashrc go-funcs.sh
	vi go-funcs.sh

# ---------------------------------------------------------------------------
git g:
	@echo ""
	@echo "make (git) [update|login|tag|status]"
	@echo ""

git-update gu:
	git add README.md Makefile go.mod go-funcs.sh
	git commit -m "add dopage() to open the web page for docker"
	git push

git-login gl:
	git config credential.helper store

git-tag gt:
	git tag v1.0.2
	git push --tags

git-status gs:
	git status
	git log --oneline -5

# ---------------------------------------------------------------------------
