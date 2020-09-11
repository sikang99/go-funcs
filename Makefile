#
# Makefile by Stoney
#
all: usage

SCRIPT=go-funcs.sh
EDITOR=vim
# ---------------------------------------------------------------------------
usage:
	@echo "usage: make [edit|run|copy|git]"
# ---------------------------------------------------------------------------
edit e:
	@echo "make (edit) [sh|readme|make]"

edit-make em:
	$(EDITOR) Makefile

edit-readme er:
	$(EDITOR) README.md

edit-history eh:
	$(EDITOR) HISTORY.md

edit-sh es:
	$(EDITOR) $(SCRIPT)

# ---------------------------------------------------------------------------
run r:
	./$(SCRIPT)

copy cp:
	cp ~/.bashrc go-funcs.sh
	vi go-funcs.sh
# ---------------------------------------------------------------------------
git g:
	@echo "make (git) [update|login|tag|status]"

git-update gu:
	git add .
	git commit -m "update contents /config"
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
