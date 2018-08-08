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
		cd `echo $GOROOT/..` ;;
	path)
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
	opencv*)
		cd $HOME/coding/c/src/opencv ;;
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
        cd $GOPATH/src/${package%/...}
    fi
}

# search repos of github.com with the given text
function gohub() {
	if [ $# = 0 ]; then
		echo "usage: gohub <search text>"
		return
	fi
    hub-search --lang=go $1
}

# Select a go version to use among installed
function gover() {
    pushd . > /dev/null
    cd $HOME/coding/go/root
    if [ ! -L "go" ]; then 
        ln -s go1.10.3 go
    fi
	if [ $# = 0 ]; then
        echo "usage: gover <go version>: 1.9, 1.10(stable), 1.11(beta2,beta3)"
    else
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
        *)
            echo "> '$1' is not installed. select 1.9, 1.10 or 1.11"
            ;;
        esac
	fi
   popd > /dev/null
   go version
}

# usage for internal functions
function usage() {
    goto
    goget
    gofile
    gopath
    gover
    gohub
}

