#---------------------------------------------------------------------
# Utility Functions for Gophers
#---------------------------------------------------------------------
# direct directory jump
function goto() {
	if [ "$1" = "" ]; then
		echo "usage: goto [.|..|root|path|stoney|wasm|webcam|http]"
		return
	fi
	case $1 in
    .)
        pushd . ;;
    ..)
        popd ;;
	root)
		cd `echo $GOROOT` ;;
	path)
		cd `echo $GOPATH`/src ;;
	stoney)
		cd `echo $GOPATH`/src/stoney ;;
	wasm)
		cd /home/stoney/coding/c/src/start-wasm ;;
	webcam)
		cd /home/stoney/coding/go/src/github.com/blackjack/webcam ;;
	http*)
		cd /home/stoney/coding/go/src/stoney/httpserver2/server ;;
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
        -u | -v)	
            option="$option $1" 
            ;;
        -n | --nocd)	
            flag="nocd" 
            ;;
        *) 	package=$1 ;;
		esac
		shift
	done
	echo "> go get $option $package"
	go get $option $package
    if [ "$flag" = "" ]; then
        cd $GOPATH/src/${package%/...}
    fi
}

# search repos of github.com with the given text
function gogl() {
	if [ $# = 0 ]; then
		echo "usage: gogl <search text>"
		return
	fi
    hub-search --lang=go $1
}

# Select a go version to use among installed
function gover() {
	if [ $# = 0 ]; then
		echo "usage: gover <go version>"
		return
	fi
    case $1 in
    *1.9*)
        unlink $HOME/coding/go/root/go
        ln -s $HOME/coding/go/root/go1.9.7 $HOME/coding/go/root/go
        ;;
    *1.10*)
        unlink $HOME/coding/go/root/go
        ln -s $HOME/coding/go/root/go1.10.3 $HOME/coding/go/root/go
        ;;
    *1.11*)
        unlink $HOME/coding/go/root/go
        ln -s $HOME/coding/go/root/go1.11beta3 $HOME/coding/go/root/go
        ;;
    *)
       echo "> '$1' is not installed. select 1.9, 1.10 or 1.11"
       return
       ;;
   esac
   go version
}

# usage for internal functions
function usage() {
    goto
    goget
    gofile
    gopath
    gover
    gogl
}