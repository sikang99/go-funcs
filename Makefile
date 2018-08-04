# Makefile for
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
	cp ~/.bashrc bashrc

# ---------------------------------------------------------------------------
git g:
	@echo ""
	@echo "make (git) [update|status]"
	@echo ""

git-update gu:
	git add README.md Makefile go-funcs.sh
	git commit -m "Update functions"
	#git commit -m "add goroot function changing go version to use"
	#git push -u https://sikang99@github.com/sikang99/go-funcs
	git push

git-status gs:
	git status
	git log --oneline -5

# ---------------------------------------------------------------------------
