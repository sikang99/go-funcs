#
# Makefile by Stoney
#
all: usage

SCRIPT=go-funcs.sh
EDITOR=vim

usage:
	@echo ""
	@echo "usage: make [edit|run|copy|git]"
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

copy cp:
	cp ~/.bashrc go-funcs.sh
	vi go-funcs.sh

# ---------------------------------------------------------------------------
git g:
	@echo ""
	@echo "make (git) [update|login|tag|status]"
	@echo ""

git-update gu:
	git add README.md Makefile go-funcs.sh config/
	git commit -m "update contents"
	git push

git-login gl:
	git config --global user.email "sikang99@gmail.com"
	git config --global user.name "Stoney Kang"
	git config --global push.default simple
	git config credential.helper store

git-tag gt:
	git tag v1.0.5
	git push --tags

git-status gs:
	git status
	git log --oneline -5

# ---------------------------------------------------------------------------
