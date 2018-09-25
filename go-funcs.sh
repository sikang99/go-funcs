#!/bin/bash
# --------------------------------------------------------------------
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/snap/bin:/usr/local/bin
PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig


alias update='sudo apt update && sudo apt -y upgrade && sudo apt autoremove && sudo apt autoclean'
alias bashrc='vi ~/.bashrc && source ~/.bashrc'
alias vimrc='vi ~/.vimrc'
alias cls='clear'
alias d='clear && ls -CF'
alias l2='tree -L 2'
alias l3='tree -L 3'
alias lr='tree'
alias lm='tree | less'
alias dirs='dirs -v'
alias nls='sudo netstat -ntlp | grep LISTEN'
alias em='vi Makefile'
alias er='vi README.md'

#alias goget="get go"
alias ccget="get cc"    # c and c++
alias pyget="get py"
alias rsget="get rs"
alias jsget="get js"
alias jvget="get jv"
alias dtget="get dt"    # dart
alias waget="get wa"    # wasm
alias hsget="get hs"    # wasm
alias scget="get sc"    # solidity, smart contract

#alias dthub='hub-search --lang=go'
alias dthub='hub-search --lang=dart'
alias jshub='hub-search --lang=javascript'
alias schub='hub-search --lang=solidity'
alias godig='hub-search'

if [ -d "$HOME/coding/go" ]; then
	export GOPATH=$HOME/coding/go
	export GOROOT=$GOPATH/root/go
	export GOSRC=$GOPATH/src
	export GOBIN=$GOPATH/bin
	export GOPKG=$GOPATH/pkg
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
	echo "Golang `go version` setting ..."
    #export GOPROXY=http://127.0.0.1:3000
fi

if [ -d "$HOME/.cargo" ]; then
	#source $HOME/.cargo/env
	export RSPATH=$HOME/.cargo
	export PATH=$PATH:$RSPATH/bin
    alias rshub='hub-search --lang=rust'
	echo "Rust `cargo --version` setting ..."
fi

if [ -d "$HOME/.local" ]; then
	export PYPATH=$HOME/.local
	export PATH=$PATH:$PYPATH/bin
	echo "`python --version` setting ..."
fi

if [ -d "$HOME/coding/dt" ]; then
	export DTPATH=/usr/lib/dart
	export PATH=$PATH:$DTPATH/bin:$HOME/.pub-cache/bin
    alias ddev='pub run dart_dev'
    # Flutter
	export FLUTTER=$HOME/coding/dt/flutter
	export PATH=$PATH:$FLUTTER/bin
	echo "Dart & Flutter setting ..."
fi

if [ -d "$HOME/coding/cc/src/stoney/emsdk-build/emsdk" ]; then
	export EMSDK=$HOME/coding/cc/src/stoney/emsdk-build/emsdk
	export EM_CONFIG=/home/stoney/.emscripten
	export LLVM_ROOT=$EMSDK/clang/e1.38.10_64bit
	export EMSCRIPTEN_NATIVE_OPTIMIZER=$EMSDK/clang/e1.38.10_64bit/optimizer
	export BINARYEN_ROOT=$EMSDK/clang/e1.38.10_64bit/binaryen
	export EMSDK_NODE=$EMSDK/node/8.9.1_64bit/bin/node
	export EMSCRIPTEN=$EMSDK/emscripten/1.38.10
	export PATH=$PATH:$EMSDK:$LLVM_ROOT:$EMSDK/node/8.9.1_64bit/bin:$EMSCRIPTEN
	echo "EMSDK setting ..."
fi

if [ -d "$HOME/.bazel" ]; then
	export BAZEL_HOME=$HOME/.bazel
	export PATH=$PATH:$BAZEL_HOME/bin
	echo "Bazel setting ..."
fi

if [ -d "$HOME/intel/computer_vision_sdk" ]; then
    export CVSHOME=$HOME/intel/computer_vision_sdk
    source $CVSHOME/bin/setupvars.sh
	echo "Intel CV SDK setting ..."
fi

#. /home/stoney/coding/c/emsdk-build/emsdk/emsdk_env.sh
. /usr/share/autojump/autojump.sh
eval "$(fasd --init auto)"
#alias a='fasd -a'        # any
#alias s='fasd -si'       # show / search / select
#alias d='fasd -d'        # directory
#alias f='fasd -f'        # file
#alias sd='fasd -sid'     # interactive directory selection
#alias sf='fasd -sif'     # interactive file selection
#alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# Personal (private) setting
export DOWNLOAD=$HOME/다운로드
#export DOWNLOAD=$HOME/Downloads

# Private Personal Information
# Github Repo Access Token
export GITHUB_ACCESS_TOKEN=5c0b5e7e19123f06e1f7ba5c422d9ca709cbd8e9

#!/bin/bash
#---------------------------------------------------------------------
# Utility Functions for Gophers
# https://www.tldp.org/LDP/abs/html/string-manipulation.html
#---------------------------------------------------------------------
# general web page open
function openpage() {
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

function goshow() {
    case $OSTYPE in
    darwin)
        open $1
        ;;
    linux-gnu)
        shotwell $1
        ;;
    linux-gnueabihf) # Raspberry Pi
        gpicview
        ;;
    *)
        echo $1
    esac
}


# direct directory jump
function goto() {
	if [ "$1" = "" ]; then
		echo "usage: $FUNCNAME [.|..|root|path|stoney|sikang|webcam|http|go|rs|py|js|jv|dt|wa]"
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
	bin )
		cd $GOPATH/bin ;;
	src )
		cd $GOPATH/src ;;
	pkg )
		cd $GOPATH/pkg ;;
	mod )
		cd $GOPATH/pkg/mod ;;
	stoney)
		cd $GOPATH/src/stoney ;;
	webcam)
		cd $HOME/coding/go/src/github.com/blackjack/webcam ;;
	sikang*)
		cd $HOME/coding/go/src/github.com/sikang99 ;;
	http*)
		cd $HOME/coding/go/src/stoney/httpserver2/server ;;
	packt | book)
		cd $HOME/coding/go/src/stoney/PacktBooks ;;
	opencv* | ocv)
		cd $HOME/coding/cc/src/stoney/opencv ;;
	openvino* | vino)
		cd $HOME/coding/cc/src/stoney/openvino ;;
	webrtc | rtc)
		cd $HOME/coding/cc/src/github.com/aisouard/libwebrtc ;;
	make)
		cd $HOME/coding/sh/src/stoney/makefiles ;;
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
	jv | java)
		cd $HOME/coding/jv/src ;;
	cc | cpp)
		cd $HOME/coding/cc/src ;;
	hs | haskell)
		cd $HOME/coding/hs/src ;;
	wa | wasm)
		cd $HOME/coding/wa/src ;;
	sh | shell)
		cd $HOME/coding/sh/src ;;
	media)
		cd $HOME/coding/media ;;
	p2p*)
		cd $HOME/coding/js/src/github.com/P2PSP ;;
	*)
		echo "$FUNCNAME> '$1' is unknown" ;;
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
        echo "$FUNCNAME> package '$1' not found in $GOPATH/src"
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
    echo "$FUNCNAME> '$1' not found in $GOPATH/src"
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
    . | current) 
        #go version
        ;;
    *)
        echo "$FUNCNAME> '$1' is not installed. select 1.9, 1.10 or 1.11"
        ;;
    esac

    popd > /dev/null
    go version
    gocode
}

# change the version of python
function pyver() {
	if [ $# -eq 0 ]; then
        echo "usage: $FUNCNAME> <2|3>"
        return
    fi

    pushd . > /dev/null
    cd /usr/bin
    if [ -s python ]; then
        sudo unlink python
        sudo unlink pip
    fi

    case $1 in
    2)
        sudo ln -s python2 python
        sudo ln -s pip2 pip
        ;;
    3)
        sudo ln -s python3 python
        sudo ln -s pip3 pip
        ;;
    *)
        echo "$FUNCNAME> $1 is unknown, choose <2|3>"
        ;;
    esac

    if [ ! -s python ]; then
        sudo ln -s python3 python
        sudo ln -s pip3 pip
    fi
    python --version
    pip --version
    popd > /dev/null
}

# set the value of GO111MODULE variable
function gomod() {
    case $1 in
    . | check)
        echo "$FUNCNAME> `go version` [`env | grep GO111MODULE`]" ;;
    on) 
        export GO111MODULE=on
        gomod check ;;
    off) 
        export GO111MODULE=off
        gomod check ;;
    auto) 
        export GO111MODULE=auto
        gomod check ;;
    init | tidy | vendor | verify | graph | why | edit)
        go mod $1 $2 $3 ;;
    build | install | test | list)
        go $1 $2 $3 ;;
    tag)
        git describe --always ;;
    mod)
        vi go.mod ;;
    sum)
        vi go.sum ;;
    read)
        vi *.md ;;
    make)
        vi Makefile ;;
    vbuild)
        go build --mod=vendor ./... ;;
    rebuild)
        rm -rf go.mod go.sum vendor/
        go mod init
        go mod tidy
        go mod vendor
        go build ./...
        ;;
    clean)
        rm -f Gopkg.toml Gopkg.lock glide.yaml glide.lock vendor/vendor.json ;;
    help | *)
		echo "usage: $FUNCNAME <check|auto|on|off|init|vendor|verify|clean|vbuild|rebuild>"
    esac
}

# show installed states of the package
function gopkg() {
	if [ $# -eq 0 ]; then
        echo "usage: $FUNCNAME <package>"
        return
    fi

    case $1 in
    mod)
    if [ -d $GOPATH/pkg/mod/$2 ]; then
        echo "$FUNCNAME> $GOPATH/pkg/mod/$2"
        ls $GOPATH/pkg/mod/$2 
    fi
    ;;
    src)
    if [ -d  $GOPATH/src/$2 ]; then
        echo "$FUNCNAME> $GOPATH/src/$2"
        ls $GOPATH/src/$2
    fi
    ;;
    vendor)
    if [ -d  ./vendor/$2 ]; then
        echo "$FUNCNAME> ./vendor/$2"
        ls ./vendor/$2
    fi
    ;;
    esac
}

# Ubuntu package handling
function ubpkg() {
    case $1 in 
    remove)
        sudo dpkg --remove --force-remove-reinstreq $1
        ;;
    *)
        echo "usage: $FUNCNAME <command> <package>"
    esac
}

# show github treading for the given language
function gotrd() {
    case $1 in
    -h | --help)
        echo "usage: $FUNCNAME [<all|go|rs|js|py|dt|dk|week|month>:go]" ;;
    all)
        hub-trend ;;
    go | golang)
        hub-trend --lang=go ;;
    rs | rust)
        hub-trend --lang=rust ;;
    py | python)
        hub-trend --lang=python ;;
    js | javascript)
        hub-trend --lang=javascript ;;
    dt | dart)
        hub-trend --lang=dart ;;
    dk | dockerfile)
        hub-trend --lang=dockerfile ;;
    week | month)
        hub-trend --lang=go --time=$1 ;;
    *)
        hub-trend --lang=go
    esac
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
function gitclone() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <package folder> on {github,gitlab}.com"
		return
	fi
    case $1 in
    http*://*)
	    local package=${1#http*://} 
        ;;
    *)  # default on github.com
        echo "$FUNCNAME> $1 is not a url to git"
        return
        ;;
    esac
    package=${package%.git} 
    result=$(git clone --recursive $1 $package)
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
    rs | rust)
        cd $HOME/coding/rs/src ;;
    py | python)
        cd $HOME/coding/py/src ;;
    js | javascript)
        cd $HOME/coding/js/src ;;
    jv | java)
        cd $HOME/coding/jv/src ;;
    dt | dart)
        cd $HOME/coding/dt/src ;;
    cc | cpp)
        cd $HOME/coding/cc/src ;;
    hs | haskell) 
        cd $HOME/coding/hs/src ;;
    sh | shell) 
        cd $HOME/coding/sh/src ;;
    wa | wasm)
        cd $HOME/coding/wa/src ;;
    sc | smart)
        cd $HOME/coding/sc/src ;;
    *) 
        echo "$FUNCNAME> $1 is the unknown language type in [go|rs|py|js|jv|dt|hs|cc|wa|sh|sc]"
        return
        ;;
    esac
    gitclone $2
}

# docker utility operation beside of basic commands
function godkr() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <compose|machine|layer|open|clean> <params...>"
		return
	fi

    case $1 in
    compose)
        docker-compose $2 $3 $4
        ;;
    machine)
        docker-machine $2 $3 $4
        ;;
    layer)
        echo "$FUNCNAME> display layer informaton of the image $2"
        docker save -o image.tar $2
        dlayer -f image.tar -n 1000 | less
        rm -f image.tar
        ;;
    open)
        if [ "$2" = "" ]; then
            echo "$FUNCNAME> $1 <repo name>"
        else
            echo "$FUNCNAME> open the dockerhub page ..."
            openpage https://hub.docker.com/r/$2
        fi
        ;;
    clean) 
        echo "$FUNCNAME> docker cleaning ..."
        docker container prune -f
        docker network prune -f
        docker system prune -f
        docker volume prune -f
        docker images
        ;;
    *)
        docker $@
        ;;
    esac
}

# Find process(es) using the given port
function goport() {
    case $1 in
    [[:digit:]]*) # [1-9]*
        lsof -i -P | grep $1
        ;;
    *)
		echo "usage: $FUNCNAME <port number>"
        ;;
    esac
}

# Show price of the cryptocurrencies such as Bitcoin, Ethereum, Eos
# github.com/miguelmota/cryptocharts
function gotoken() {
    case $1 in
    a | all | .)
        $FUNCNAME market
        $FUNCNAME binance
        ;;
    m | market)
        token-ticker CoinMarketCap.Bitcoin CoinMarketCap.Ethereum CoinMarketCap.Eos
        ;;
    b | binance)
        token-ticker Binance.BTCUSDT binance.ETHUSDT binance.EOSUSDT
        ;;
    global | g)
        cryptocharts -global ;;
    bitcoin | btc)
        cryptocharts -coin bitcoin ;;
    ethereum | eth)
        cryptocharts -coin ethereum ;;
    eos)
        cryptocharts -coin eos ;;
    *)
		echo "usage: $FUNCNAME <market:m|binance:b|btc|eth|eos>"
        ;;
    esac
}

# Move the files of the download directory to the currenct directory
function godown() {
	if [ $# = 0 ]; then
		echo "usage: $FUNCNAME <file names>"
		return
	fi

    case $1 in
    .)
        ls -F ./$2 ;;
    ..) 
        ls -F $HOME/다운로드/$2 ;;
    *)
        mv "$HOME/다운로드/${1}" .
        ls -al "./${1}"
        ;;
    esac
}

# show installed hardware information
function goinfo() {
    case $1 in
    linux)
        uname -a
        cat /etc/lsb-release
        ;;
    hw)
        lshw ;;
        #hwinfo ;; # sudo apt install hwinfo
    cpu) 
        lscpu ;;
    usb)
        lsusb ;;
    video)
        for video in /dev/video* ; do
            ls $video
            #v4l2-ctl --all  # sudo apt install v4l-utils
            v4l2-ctl -V --device=$video
        done
        ;;
    service)
        service --status-all
        ;;
    *)
		echo "usage: $FUNCNAME <linux|hw|cpu|usb|video|service>"
        ;;
    esac
}

# usage for internal utility functions
function usage() {
    gitclone
    openpage
    get
    goto
    goget
    gofile
    gopath
    gover
    gohub
    gopage
    gomod
    gopkg
    gotrd -h
    goport
    godkr
    gotoken
    pyver
}
# CAUTION: don't use gvm as following
#[[ -s "/home/stoney/.gvm/scripts/gvm" ]] && source "/home/stoney/.gvm/scripts/gvm"
