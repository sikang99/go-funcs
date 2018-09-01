#!/bin/bash
#---------------------------------------------------------------------
# Utility Functions for Gophers
# https://www.tldp.org/LDP/abs/html/string-manipulation.html
#---------------------------------------------------------------------
# direct directory jump
function goto() {
	if [ "$1" = "" ]; then
		echo "usage: $FUNCNAME [.|..|root|path|stoney|sikang|wasm|webcam|http|go|rs|py|js|dt]"
		return
	fi
	case $1 in
    .)
        pushd . ;;
    ..)
        popd ;;
    path) 
		cd $GOPATH ;;
    root) 
		cd $GOPATH/root ;;
	bin | gobin)
		cd $GOPATH/bin ;;
	src | gosrc)
		cd $GOPATH/src ;;
	pkg | gopkg)
		cd $GOPATH/pkg ;;
	mod | gomod)
		cd $GOPATH/pkg/mod ;;
	stoney)
		cd $GOPATH/src/stoney ;;
	wasm)
		cd $HOME/coding/cc/src/start-wasm ;;
	webcam)
		cd $HOME/coding/go/src/github.com/blackjack/webcam ;;
	sikang*)
		cd $HOME/coding/go/src/github.com/sikang99 ;;
	http*)
		cd $HOME/coding/go/src/stoney/httpserver2/server ;;
	opencv* | ocv)
		cd $HOME/coding/cc/src/stoney/opencv ;;
	openvino* | vino)
		cd $HOME/coding/cc/src/stoney/openvino ;;
	go | golang)
		cd $HOME/coding/go/src ;;
	dt | dart)
		cd $HOME/coding/dt/src ;;
	rs | rust)
		cd $HOME/coding/rs/src ;;
	py | python)
		cd $HOME/coding/py/src ;;
	js | javascript)
		cd $HOME/coding/js/src ;;
	cc | cpp)
		cd $HOME/coding/cc/src ;;
	media)
		cd $HOME/coding/media ;;
	p2p*)
		cd $HOME/coding/js/src/github.com/P2PSP ;;
	*)
		echo "> '$1' is unknown" ;;
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
    #flag=""
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

    export GO111MODULE=off
    if [ "$option" = "" ]; then
	    echo "go get $package"
        go get $package
    else 
	    echo "go get $option $package"
        go get $option $package
    fi
    cd $GOPATH/src/${package%/...}
    export GO111MODULE=on
}

# Select a go version to use among installed
function gover() {
	if [ $# -eq 0 ]; then
        echo "usage: $FUNCNAME <go version>: 1.9, 1.10(stable), 1.11(latest)"
        return
    fi

    pushd . > /dev/null
    cd $HOME/coding/go/root
    if [ ! -L "go" ]; then 
        ln -s go1.10.4 go
    fi

    case $1 in
    *1.9*)
        #CGO_ENABLED=0
        if [ -d "go1.9.7" ]; then
            unlink go
            ln -s go1.9.7 go
        fi
        ;;
    *1.10* | stable)
        #GOcACHE={on|off}
        if [ -d "go1.10.4" ]; then
            unlink go
            ln -s go1.10.4 go
        fi
        ;;
    *1.11* | latest)
        #GO111MODULE={auto|on|off}
        #GOPROXY=file://home/stoney/coding/go/proxy
        if [ -d "go1.11" ]; then
            unlink go
            ln -s go1.11 go
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

function gomod() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <auto|on|off> [`env | grep GO111MODULE`]"
		return
	fi
    case $1 in
    on) 
        export GO111MODULE=on ;;
    off) 
        export GO111MODULE=off ;;
    auto) 
        export GO111MODULE=auto ;;
    *)
        echo "> $1 is an unknown mod type."
    esac
    echo `env | grep GO111MODULE`
}

# search repos of github.com with the given text
function gohub() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <search text> written golng in github.com"
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
    . | cwd)
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
    github.com*)
        xdg-open https://$1 >/dev/null
        ;;
    *)
        echo "https://github.com/$1"
        xdg-open https://github.com/$1 >/dev/null
        ;;
    esac
}

# git cloning with various source types
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
        echo "> $1 is not a url to git"
        return
        ;;
    esac
    package=${package%.git} 
    result=$(git clone $1 $package)
    cd $package
}

# git clone by language type
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
    dt | dart)
        cd $HOME/coding/dt/src ;;
    cc | cpp)
        cd $HOME/coding/cc/src ;;
    *) 
        echo "> $1 is the unknown language type"
        return
        ;;
    esac
    gclone $2
}

# general web page open
function open-page() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <URL>"
		return
    fi
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        xdg-open $1
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open $1
    else
        echo $1
    fi
}

# Open the docker page of repo
function dopage() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <docker image repo> on hub.docker.com"
		return
	fi
    open-page https://hub.docker.com/r/$1
}

# usage for internal utility functions
function usage() {
    goto
    goget
    gofile
    gopath
    gover
    gohub
    gopage
    gclone
    get
    open-page
    dopage
}
# CAUTION: don't use gvm as following
#[[ -s "/home/stoney/.gvm/scripts/gvm" ]] && source "/home/stoney/.gvm/scripts/gvm"
