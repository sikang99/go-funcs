#---------------------------------------------------------------------
# Utility Functions for Gophers
# https://www.tldp.org/LDP/abs/html/string-manipulation.html
#---------------------------------------------------------------------
# direct directory jump
function goto() {
	if [ "$1" = "" ]; then
		echo "usage: goto [.|..|root|path|stoney|sikang|wasm|webcam|http|dart]"
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
	javascript | js)
		cd $HOME/coding/js/src ;;
	c | cpp)
		cd $HOME/coding/c/src ;;
	*)
		echo "'$1' is unknown" ;;
	esac
}

# fast file finder from HOME
function gofile() {
	if [ $# = 0 ]; then
		echo "usage: gofile <filename>"
		return
	fi
    # case insensitive search
	find ~ -iname $1 -type f -print
}

# fast package finder from GOPATH
function gopath() {
	if [ $# = 0 ]; then
		echo "usage: gopath <package name>"
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
    echo "> package '$1' not found in $GOPATH/src"
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
        -n | --nocd)	
            flag="nocd" 
            ;;
        -*)	
            option="$option $1" 
            ;;
        *) 	package=$1 ;;
		esac
		shift
	done
	echo "> go get $option $package"
	go get $option $package
    if [ "$flag" = "" ]; then
        #pushd .
        cd $GOPATH/src/${package%/...}
    fi
}

# Select a go version to use among installed
function gover() {
	if [ $# -eq 0 ]; then
        echo "usage: gover <go version>: 1.9, 1.10(stable), 1.11(beta2,beta3)"
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
        if [ -d "go1.10.3" ]; then
            unlink go
            ln -s go1.10.3 go
        fi
        ;;
    *1.11* | latest | beta3)
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
		echo "usage: gopage <.|url|github repo path>"
		return
	fi
    case $1 in
    . | current)
        dir=`pwd`
        package=${dir#*/src/}
        IFS='/' array=($package)
        page=${array[0]}/${array[1]}/${array[2]}
        IFS=''
        echo "https://$page"
        xdg-open https://$page
        ;;
    http*)
        echo $1
        xdg-open $1
        ;;
    *)
        echo "https://github.com/$page"
        xdg-open https://github.com/$1
        ;;
    esac
}

# github.com cloning
function gclone() {
	if [ $# = 0 ]; then
		echo "usage: gclone <package folder> on {github,gitlab}.com"
		return
	fi
    package=""
    case $1 in
    https://github.com/*)
        site=https://github.com/
	    package=${1#$site} 
        ;;
    https://gitlab.com/*)
        site=https://gitlab.com/
	    package=${1#$site}
        ;;
    *)  # default on github.com
        site=https://github.com/
        package=$1
        ;;
    esac
    result=$(git clone $site/$package $package)
    #pushd .
    cd $package
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

