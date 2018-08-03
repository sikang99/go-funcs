#!/bin/bash

# source ./go-funcs.sh

#---------------------------------------------------------------------
# direct directory jump
function t() {
	if [ "$1" = "" ]; then
		echo "usage: t [root|git|stoney|wasm|webcam|http]"
		return
	fi
	case $1 in
	root)
		cd `echo $GOROOT` ;;
	git*)
		cd `echo $GOPATH`/src/github.com ;;
	stoney)
		cd `echo $GOPATH`/src/stoney ;;
	wasm)
		cd /home/stoney/coding/c/src/start-wasm ;;
	webcam)
		cd /home/stoney/coding/go/src/github.com/blackjack/webcam ;;
	http*)
		cd /home/stoney/coding/go/src/stoney/httpserver2/server ;;
	*)
		echo "$1 is unknown" ;;
	esac
}

# fast file finder from HOME
function f() {
	if [ $# = 0 ]; then
		echo "usage: f <name> $@"
		return
	fi
	find ~ -iname $1 -type f -print
}

# fast file finder from GOPATH
function gopath() {
	if [ $# = 0 ]; then
		echo "usage: gopath <name>"
		return
	fi
    list=$(eval find $GOPATH/src -iname $1 -type d -print)
    if [ "$list" = "" ]; then
        echo "> $1 not found in $GOPATH/src"
        return
    fi
    for dir in $list; do
        cd $dir
        return
    done
}

# go get a package and goto its directory
# https://www.tldp.org/LDP/abs/html/string-manipulation.html
function goget() {
	if [ $# = 0 ]; then
		echo "usage: goget [<option>] <package path>"
		return
	fi
	package=""
	option=""
	while [ "$1" != "" ]; do
		case $1 in
		http*://*.git)	
			package=${1#http*://} 
			package=${package%.git} 
			;;
		http*://*)	
			#echo ${1#http*://} 
			package=${1#http*://} 
			;;
        *.git) 
            package=${1%.git} 
            ;;
        -u | -v)	
            option="$option $1" 
            ;;
		*) 	package=$1 ;;
		esac
		shift
	done
	echo "> go get $option $package"
	go get $option $package
    cd $GOPATH/src/${package%/...}
}

# search repos of github.com with the given text
function gog() {
	if [ $# = 0 ]; then
		echo "usage: gog <search text>"
		return
	fi
    hub-search --lang=go $1
}

# usage for internal functions
function usage() {
    goget
    gopath
    gogl
}

