# Shell Functions for Go Development

Some utility shell script functions useful in the go development environment


## Installation

To use shell functions, download and exec the shell script.

```sh
$ go get github.com/sikang99/go-funcs
$ cd $GOPATH/src/github.com/sikang99/go-funcs
$ source ./go-funcs.sh # or include . <path>/go-funcs.sh in ~/.bashrc
```

## Usage

To see help message of usage after installation, 

```sh
usage: setlang [kr|en]
usage: gitclone <package folder> on {github,gitlab}.com
usage: gitupdate <.>
usage: openpage <URL>
usage: get [<language> <url of package>] are required.
usage: goto [.|..|root|path|stoney|sikang|webcam|http|go|rs|py|js|jv|dt|wa|hb]
usage: get [<language> <url of package>] are required.
usage: gofile <filename> [path to start]
usage: gofind <search string> [path to start]
usage: gopath <package name>
usage: gover <go version>: 1.9(.7), 1.10(.8), 1.11(.12), 1.12(.7)
usage: gohub <search text> written golng in github.com
usage: gopage <.|url|github path>
usage: gomod [auto|on|off|<command>...]
usage: gopkg [mod|src|vendor] [<package>]
usage: gotrd [<all|go|rs|js|py|dt|dk|week|month>:go]
usage: goport [<port number>|ip|scan|axis]
usage: godkr <compose|machine|layer|open|clean|run> <params...>
usage: gotoken <coin:c|market:m|binance:b|btc|eth|eos>
usage: govnc <info|list|play|search|version>
usage: pyver <2|3>
usage: futter [open|build|force|upgrade|clean|yaml|desktop|...]
usage: datter [update|yaml|format|web|...]
usage: gst <info|list|play|search|version>
usage: genkey <local|quic>
usage: kube <start|stop|info> - Kubenates v1.15.0
usage: pion <open|update|mod|src|doc|home|back> - WebRTC media system, v2.0.23
usage: wasm <copy|bin|install|open|run|update>
```

To see the source of the shell function, type like this.
```sh
$ type openpage
openpage is the function
openpage ()
{
    if [ $# = 0 ]; then
        echo "usage: $FUNCNAME <URL>";
        return;
    fi;
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        xdg-open $1;
    else
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open $1;
        else
            echo $1;
        fi;
    fi
}
```

### goto
To change a specific directory, use `goto`.

```sh
$ goto
usage: goto [.|..|root|path|stoney|wasm|webcam|http]

$ goto . # save the current directory
$ goto .. # return to the saved directory
```

### goget
To download go sources from open repos, use `goget` regardless of includng http scheme or .git tail.

```sh
$ goget
usage: goget [<option>] <package path>

$ goget https://github.com/sikang99/go-funcs.git
$ goget https;//github.com/sikang99/go-funcs -u
$ goget github.com/sikang99/go-funcs/... -u -v
$ goget -u github.com/sikang99/go-funcs/... -v
$ pwd
GOPATH/src/github.com/sikang99/go-funcs
```

To change to the directory that you check the go sources downloaded, use `gopath` as following.  
`/vendor` and `/_` directories are excluded in search

```sh
$ gopath
usage: gopath <package name>

$ gopath go-funcs
GOPATH/src/github.com/sikang99/go-funcs

$ gopath github.com
GOPATH/src/github.com
```

### gohub
To use `gohub`, install the package [sikang99/hub-search](https://github.com/sikang99/hub-search).

```sh
$ goget https://github.com/sikang99/go-funcs
$ gohub
usage: gohub <search text>

$ gohub wasm
  sbinet/wasm
  tools to interact with WASM files
  2018-07-19T14:09:41Z  Go  162  65.25
  https://github.com/sbinet/wasm

  go-interpreter/wagon
  wagon, a WebAssembly-based Go interpreter, for Go.
  2018-08-04T08:55:25Z  Go  363  59.09
  https://github.com/go-interpreter/wagon

  ontio/ontology-wasm
  Ontology wasm is a VM for ontology block chain, it can also be used for other stand-alone environment not only for block chains.
  2018-07-30T08:13:26Z  Go  438  55.99
  https://github.com/ontio/ontology-wasm
...

$ gohub "github search"
...
```

### gover
To select a specific go version installed in your environment, 
use `gover` with version number such as 1,9, 1.10, 1.11
Currently my case with two go versions is as following. 
If your want to support more versions, plz edit the script. 

```sh
$ tree -L 1 $GOROOT/..
$HOME/root/go/..
├── bak
├── go -> go1.11beta2
├── go1.9.7
├── go1.10.3
└── go1.11beta3
```

Before using, check `gocode` and install it if not exist.
```
$ go get -u github.com/nsf/gocode
```

Let's try to use `gover`.

```sh
$ gover
usage: gover <go version>

$ gover 1.10 # or 1.9, 1.10.3, go1.10.3
go version go1.10.3 linux/amd64

$ gover 1.11
go version go1.11beta3 linux/amd64
```

### gopage
To open a web page corresponding to the current source directory, type `gopage .`.
```
$ pwd
$GOPATH/src/github.com/sikang99/go-funcs

$ gopage .
https://github.com/sikang99/go-funcs
```

### gitclone
To clone the repo like as its web path, use `gitclone` as following.
```
$ gitclone https://github.com/yurydelendik/wasmtext
git clone https://github.com/yurydelendik/wasmtext
...
$ pwd
.../src/github.com/yurydelendik/wasmtext

```

### get
Function for downloading git sources of a package
```
$ get <py|go|rs|dt|js> <package repo>
```

### godkr
Utility functions for docker
```
$ godkr page golang
https://hub.docker.com/r/golang/

$ godkr clean
cleaning .... images
```
### gomod
This is for seting the environment variable of GO111MODULE.
```
$ gomod
usage: gomod <auto|on|off> [GO111MODULE=auto]

$ gomod on
[GO111MODULE=on]
```

### gotrd
Display trending in github.com by using [sikang99/hub-trend](https://github.com/sikang99/hub-trend)
```
$ gotrd -h
gotrd [<all|go|rs|js|py|dt|week|month>:go]

$ gotrd rs
...
```
### goport
To find the processes using the given port.
```
$ goport 8080
```
### gotoken
Display prices of the crypto tokens such as bitcoin, ethereum, eos by using [polyrabbit/token-ticker](https://github.com/polyrabbit/token-ticker)
```
$ gotoken
usage: gotoken <all:a|market:m|binance:b>

$ gotoken market
...
```

### pyver
Changer the python version and tool to use
```
$ pyver
usage: pyver <2|3>

$ pyver 3
Python 3.6.5
pip 9.0.1 from /usr/lib/python3/dist-packages (python 3.6)
```

### gowasm
```
$ type gowasm
gowasm is aliased to `GOOS=js GOARCH=wasm go'
```

## Reference

- [Bash 입문자를 위한 핵심 요약 정리 (Shell Script)](https://blog.gaerae.com/2015/01/bash-hello-world.html)
- [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/index.html)
- [How To Build Go Executables for Multiple Platforms on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-build-go-executables-for-multiple-platforms-on-ubuntu-16-04)
- [A Good Makefile for Go](https://azer.bike/journal/a-good-makefile-for-go/)

### Books
- From Bash to Z Shell: Conquering the Command Line, Packt, 2005


## LICENSE

MIT
