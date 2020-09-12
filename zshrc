# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/stoney/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="gozilla"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#-------------------------------------------------------------------------------
# Stoney user-defined
#alias bshrc="vi ~/.bshrc; source ~/.bshrc"
#alias bshrcx="source ~/.bshrc"

alias zshrc="vi ~/.zshrc; source ~/.zshrc"
alias zshrcx="source ~/.zshrc"

alias vimrc="vi ~/.vimrc"

alias dir="ls -alF"
alias cls="clear"

alias ll="ls -al"
alias lr="f() { tree $1 | less }; f"
alias l2="f() { tree -L 2 $1 | less }; f"
alias l3="f() { tree -L 3 $1 | less }; f"

alias em="vi Makefile"
alias ec='vi Caddyfile'
alias ed="vi Dockerfile"
alias ei="vi .gitignore"
alias ey="vi docker-compose.yml"
alias er="vi README.md"
alias index='vi index.html'

alias aiget="gitget ai"    # AI, ML, DL
#alias goget="gitget go"    # go
alias ccget="gitget cc"    # c and c++
alias pyget="gitget py"    # python
alias rsget="gitget rs"    # rust
alias jlget="gitget jl"    # julia
alias jsget="gitget js"    # javascript
alias jvget="gitget jv"    # java
alias dtget="gitget dt"    # dart
alias hsget="gitget hs"    # haskell
alias scget="gitget sc"    # solidity, smart contract
alias waget="gitget wa"    # wasm
alias zgget="gitget zg"    # zig
alias nmget="gitget nm"    # nim
alias elget="gitget el"    # erlang, elixir
alias vlget="gitget vl"    # vlang

export LANG=en_US.UTF-8
export PATH=/sbin:/bin:/usr/bin:/usr/local/bin

export C_INCLUDE_PATH=/usr/local/include
#export CPLUS_INCLUDE_PATH=/usr/local/include
#export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib

if [[ -x $HOME/coding/go ]] {
	export GOHOME=$HOME/coding/go
	export GOROOT=$GOHOME/root/go
	export GOPATH=$GOHOME
	export PATH=$PATH:/$GOROOT/bin:$GOPATH/bin
}

#-------------------------------------------------------------------------------
# go to the some directory
#
function goto() {
    if [[ $# == 0 ]] {
        print "usage: $0 [sikang|spider|mantis|pion]"
        return
    }
    case $1 in
    .) 
        pushd . ;;
    ..)
        popd ;;
    sikang | stoney)
        cd $GOPATH/src/github.com/sikang99 ;;
    spider)
        cd $GOPATH/src/github.com/sikang99/spider ;;
    mantis)
        cd $GOPATH/src/github.com/sikang99/mantis ;;
    pion)
        cd $GOPATH/src/github.com/pion ;;
    media)
        cd $HOME/coding/media ;;
    go | root)
        cd $GOHOME/root ;;
    home)
        cd $GOHOME ;;
    esac
}


# go version setting
#
function gover() {
    if [[ $# == 0 ]] {
        print "usage: $0 [1.13|1.14|1.15]"
        return
    }
    case $1 in
    1.13)
        cd $GOHOME/root
        unlink go
        ln -s go1.13.15 go
        ;;
    1.14)
        cd $GOHOME/root
        unlink go
        ln -s go1.14.9 go
        ;;
    1.15)
        cd $GOHOME/root
        unlink go
        ln -s go1.15.2 go
        ;;
    list)
        ls -al $GOHOME/root
        ;;
    esac
    go version
}

# go mod setting
#
function gomod() {
    if [[ $# == 0 ]] {
        print "usage: $0 [.|init|vendor|mod|sum|clean|clobber]"
        return
    }
    case $1 in
    . | check)
        print "$0> `go version` [`env | grep GO111MODULE`]" ;;
    on | off | auto) 
        export GO111MODULE=$1
        $0 . ;;
    mod)
        vi go.mod ;;
    sum)
        vi go.sum ;;
    init)
       go mod init ;;
    vendor)
        go mod vendor ;;
    rebuild)
        rm -rf go.mod go.sum vendor/
        go mod init
        go mod tidy
        go mod vendor
        go build ./...
        ;;
    clean)
        rm -f Gopkg.toml Gopkg.lock glide.yaml glide.lock vendor/vendor.json ;;
    clobber)
        go clean -modcache ;;
    *)
        go mod $@ ;;
    esac
}

## search file and directory by the given string
#
function gofind() {
	if [[ $# == 0 ]] {
		print "usage: $0 <search string> [path to start]"
		return
    }
    # search with string inclusion starting from the given folder
	if [ $2 ]; then
        find $2 -name "*$1*" -print
    else
        find . -name "*$1*" -print
    fi
}

function openpage() {
	if [[ $# == 0 ]] {
		print "usage: $0 <URL>"
		return
    }
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        xdg-open $1
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        open $1
    else
        echo $1
    fi
}

## show web page for the current directory
#
function gopage() {
	if [[ $# == 0 ]] {
		print "usage: $0 <.|url|github path|teamgrit|sikang>"
		return
    }
    case $1 in
    . | cwd)
        local dir=`pwd`
        local package=${dir#*/src/}
        IFS='/' array=($package)
        local page=${array[0]}/${array[1]}/${array[2]}
        IFS=''
        echo "https://$page"
        openpage https://$page >/dev/null
        ;;
    http*)
        echo $1
        openpage $1 >/dev/null ;;
    *.com*)
        openpage https://$1 >/dev/null ;;
    teamgrit**)
        openpage https://github.com/teamgrit-lab ;; 
    sikang*)
        openpage https://github.com/sikang99 ;;
    stoney*)
        openpage https://sikang99.github.io/ ;;
    docker*)
        openpage https://hub.docker.com/orgs/cojam/repositories ;;
    *)
        echo "https://github.com/$1"
        openpage https://github.com/$1 >/dev/null
        ;;
    esac
}

## Pion webrtc repos
#
function pion() {
	if [[ $# = 0 ]] {
		print "usage: $0 <open|update|mod|src|doc|home|back> - WebRTC media system, v2.2.3 >"
		return
    }
    PION="github.com/pion"
    GOGET="go get -u"
    PKGS=(\
        webrtc/v2 webrtc/v3 sdp/v2 ice ice/v2 rtp rtcp srtp sctp dtls quic udp stun turn turnc mdns \
        datachannel transport rtpengine signaler mediadevices msapi codec \
        logging ion rtwatch webt offline-browser-communication obs-wormhole rtsp-bench \
        example-webrtc-applications awesome-pion
        )
    case $1 in
    update | new)
        for value in ${PKGS[*]}
        do
            GO111MODULE=on go get -u $PION/$value
        done
        ;;
   list)
        for value in ${PKGS[*]}
        do
            GO111MODULE=on go list -m -versions $PION/$value
        done
        ;;
    doc)
        go doc $GOPATH/src/$PION/$2
        ;;
    pkg | mod)
        echo "$0> $GOPATH/pkg/mod/$PION"
        ls -cF $GOPATH/pkg/mod/$PION
        echo "$0> $GOPATH/pkg/mod/$PION/sdp"
        ls -cF $GOPATH/pkg/mod/$PION/sdp
        echo "$0> $GOPATH/pkg/mod/$PION/ice"
        ls -cF $GOPATH/pkg/mod/$PION/ice
        echo "$0> $GOPATH/pkg/mod/$PION/webrtc"
        ls -cF $GOPATH/pkg/mod/$PION/webrtc
        ;;
    src | dir)
        ls -alF $GOPATH/src/$PION
        ;;
    home)
        pushd .
        cd $GOPATH/src/$PION
        ;;
    back)
        popd
        ;;
    open)
        openpage https://$PION/webrtc
        ;;
    *)
		echo "$0> '$1' is an unknown command"
        ;;
    esac
}

# Git cloning with various source types
function gitclone() {
    if [[ $# == 0 ]] {
        print "usage: $0 <package folder> on {github,gitlab}.com"
		return
    }

    local url=$1
    local package=${url%.git} 

    case $url in
    http*://*)
	    package=${url#http*://} 
        ;;
    github.com* | *golang.org* | tinygo.org* | gopkg.in* | gocv.io*)
	    url=https://$1 
        ;;
    *)  # default on github.com
        echo "$0> $url is not a url to git"
        return
        ;;
    esac
    result=$(git clone --recursive $url $package)
    cd $package
}

## git clone by language type
#
function gitget() {
	if [ $# -lt 2 ]; then
		echo "usage: $0 [<language> <url of package>]"
		return
	fi
    if [ -d $HOME/coding/$1/src ]; then
        cd $HOME/coding/$1/src
        gitclone $2
    fi
}

## git update simply
#
function gitupdate() {
    git add .
    if [[ $1 != "" ]] {
        git commit -m $1
    } else {
        git commit -m update
    }
}


function goget() {
    if [[ $# == 0 ]] {
        print "usage: $0 [repo]"
        return
    }
    gitget go $@
}

## docker utility operation beside of basic commands
#
function dkr() {
	if [[ $# == 0 ]] {
		print "usage: $0 <taglist|compose|machine|layer|open|clean|run> <params...>"
		return
    }
    case $1 in
    compose)
        docker-compose $2 $3 $4
        ;;
    machine)
        docker-machine $2 $3 $4
        ;;
    layer)
        echo "$0> display layer informaton of the image $2"
        docker save -o image.tar $2
        dlayer -f image.tar -n 1000 | less
        rm -f image.tar
        ;;
    open)
        if [ "$2" = "" ]; then
            echo "$0> $1 <repo name>"
        else
            echo "$0> open the dockerhub page ..."
            openpage https://hub.docker.com/r/$2
        fi
        ;;
    clean) 
        echo "$0> docker cleaning ..."
        docker container prune -f
        docker network prune -f
        docker system prune -f
        docker volume prune -f
        docker images
        ;;
    lint)
        godolint $2 $3
        ;;
    run)
        case $2 in
        rust)
            # https://hub.docker.com/r/wasm/toolchain/
            docker run -it --rm -v $PWD:/project wasm/toolchain:latest /bin/bash --login
            ;;
        *)
            echo "$0> $1 <rust>"
            ;;
        esac
        ;;
    taglist | tag)
	    if [[ $# == 1 ]] {
            echo "$0> $1 <image name> [version]"
            return
        }
        image=$2
        tags=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O - \
            | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`
        #   | jq -r '.[] | select(.name=="${version}") | .name'`
        if [[ ${tags} == ""  ]] {
            echo "$0> image $2 is not found"
            return
        }
        if [[ $# == 2 ]] {
            echo "${tags}"
        } else {
            version=$3
            for vtag in ${tags}; do
                if [[ ${vtag} == *${version}* ]]; then
                    echo ${vtag}
                fi
            done
        }
        ;;
    *)
        docker $@
        ;;
    esac
}


#-------------------------------------------------------------------------------
function usage() {
    gitclone
    gitget
    goto
    gover
    gomod
    goget
    gofind
    gopage
    dkr
}
#-------------------------------------------------------------------------------
