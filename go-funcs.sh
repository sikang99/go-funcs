export DOWNLOAD=$HOME/다운로드

#!/bin/bash
#---------------------------------------------------------------------
# Utility Functions for Gophers
# https://www.tldp.org/LDP/abs/html/string-manipulation.html
#---------------------------------------------------------------------
# direct directory jump
function goto() {
	if [ "$1" = "" ]; then
		echo "usage: $FUNCNAME [.|..|root|path|stoney|sikang|wasm|webcam|http|dart]"
		return
	fi
	case $1 in
    .)
        pushd . ;;
    ..)
        popd ;;
	root | go)
		cd `echo $GOROOT/..` ;;
	bin | gobin)
		cd `echo $GOPATH`/bin ;;
	src | gosrc)
		cd `echo $GOPATH`/src ;;
	stoney)
		cd `echo $GOPATH`/src/stoney ;;
	wasm)
		cd $HOME/coding/c/src/start-wasm ;;
	webcam)
		cd $HOME/coding/go/src/github.com/blackjack/webcam ;;
	sikang*)
		cd $HOME/coding/go/src/github.com/sikang99 ;;
	http*)
		cd $HOME/coding/go/src/stoney/httpserver2/server ;;
	opencv* | ocv)
		cd $HOME/coding/c/src/opencv ;;
	dart*)
		cd $HOME/coding/dart/src ;;
	rust | rs)
		cd $HOME/coding/rs/src ;;
	python | py)
		cd $HOME/coding/py/src ;;
	javascript | js)
		cd $HOME/coding/js/src ;;
	c | cpp)
		cd $HOME/coding/c/src ;;
	media)
		cd $HOME/coding/media ;;
	p2p*)
		cd $HOME/coding/js/src/github.com/P2PSP ;;
	*)
		echo "'$1' is unknown" ;;
	esac
}

# fast file finder from HOME
function gofile() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <filename>"
		return
	fi
    # case insensitive search
	find ~ -iname $1 -type f -print
}

# fast package finder from GOPATH
function gopath() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <package name>"
		return
	fi
    list=$(eval find $GOPATH/src -iname $1 -type d -print)
    if [ "$list" = "" ]; then
        echo "> package '$1' not found in $GOPATH/src"
        return
    fi
    for dir in $list; do
        # exclude /vendor or /_ diectories
        if [[ $dir = *"/vendor/"* ]] || [[ $dir = *"/_"* ]]; then
            continue
        else
            cd $dir
            return
        fi
    done
    echo "> $FUNCNAME: '$1' not found in $GOPATH/src"
}

# go get a package and goto its directory
# https://www.tldp.org/LDP/abs/html/string-manipulation.html
function goget() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME [<option>] <package>"
		return
	fi
	package=""
	option=""
    flag=""
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
        -?)	
            if [ "$option" = "" ]; then
                option="$1"
            else
                option="$option $1"
            fi
            ;;
        *) 	package=$1 
            ;;
		esac
		shift
	done
	echo "go get $option $package"
    go get $option $package
    #if [ $? = 0 ]; then
    #    cd $GOPATH/src/${package%/...}
    #fi
    cd $GOPATH/src/${package%/...}
}

# Select a go version to use among installed
function gover() {
	if [ $# -eq 0 ]; then
        echo "usage: $FUNCNAME <go version>: 1.9, 1.10(stable), 1.11(beta2,beta3)"
        return
    fi

    pushd . > /dev/null
    cd $HOME/coding/go/root
    if [ ! -L "go" ]; then 
        ln -s go1.10.3 go
    fi

    case $1 in
    *1.9*)
        if [ -d "go1.9.7" ]; then
            unlink go
            ln -s go1.9.7 go
        fi
        ;;
    *1.10* | stable)
        #GOcACHE={on|off}
        if [ -d "go1.10.3" ]; then
            unlink go
            ln -s go1.10.3 go
        fi
        ;;
    *1.11* | latest | rc1)
        #GO111MODULE={auto|on|off}
        export GO111MODULE=on
        if [ -d "go1.11rc1" ]; then
            unlink go
            ln -s go1.11rc1 go
        fi
        ;;
    beta3)
        if [ -d "go1.11beta3" ]; then
            unlink go
            ln -s go1.11beta3 go
        fi
        ;;
    beta2)
        if [ -d "go1.11beta2" ]; then
            unlink go
            ln -s go1.11beta2 go
        fi
        ;;
    current | .) 
        #go version
        ;;
    *)
        echo "> '$1' is not installed. select 1.9, 1.10 or 1.11"
        ;;
    esac

    popd > /dev/null
    go version
    gocode
}

# search repos of github.com with the given text
function gohub() {
	if [ $# = 0 ]; then
		echo "usage: gohub <search text> written golng in github.com"
		return
	fi
    hub-search --lang=go $@
}

# show web page for the current directory
function gopage() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <.|url|github repo path>"
		return
	fi
    case $1 in
    . | current)
        local dir=`pwd`
        local package=${dir#*/src/}
        IFS='/' array=($package)
        local page=${array[0]}/${array[1]}/${array[2]}
        IFS=''
        echo "https://$page"
        xdg-open https://$page >/dev/null
        ;;
    http*)
        echo $1
        xdg-open $1 >/dev/null
        ;;
    *)
        echo "https://github.com/$page"
        xdg-open https://github.com/$1 >/dev/null
        ;;
    esac
}

# github.com cloning
function gclone() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <package folder> on {github,gitlab}.com"
		return
	fi
    case $1 in
    http*://*)
	    local package=${1#http*://} 
        ;;
    *)  # default on github.com
        echo "$1 is not a url to git"
        return
        ;;
    esac
    result=$(git clone $1 $package)
    package=${package%.git} 
    cd $package
}

function get() {
	if [ $# -lt 2 ]; then
		echo "usage: $FUNCNAME [<language> <url of package>]"
		return
	fi
    case $1 in 
    go | golang)
        cd $HOME/coding/go/src ;;
    py | python)
        cd $HOME/coding/py/src ;;
    rs | rust)
        cd $HOME/coding/rs/src ;;
    js | javascript)
        cd $HOME/coding/js/src ;;
    c | cpp)
        cd $HOME/coding/c/src ;;
    dart)
        cd $HOME/coding/dart/src ;;
    *) 
        echo "> $1 is unknown language type"
        return
        ;;
    esac
    gclone $2
}

# usage for internal functions
function usage() {
    goto
    goget
    gofile
    gopath
    gover
    gohub
    gopage
    gclone
}

