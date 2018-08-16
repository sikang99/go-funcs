# Go-Funcs

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
$ usage
usage: goto [.|..|root|path|stoney|sikang|wasm|webcam|http|dart]
usage: goget [<option>] <package path>
usage: gofile <filename>
usage: gopath <package name>
usage: gover <go version>: 1.9, 1.10(stable), 1.11(beta2,beta3)
usage: gohub <search text> written golng in github.com
usage: gopage <.|url|github repo path>
usage: gclone <package folder> on {github,gitlab}.com
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

### gclone
To clone the repo like as its web path, use `gclone` as following.
```
$ gclone https://github.com/yurydelendik/wasmtext
git clone https://github.com/yurydelendik/wasmtext
...
$ pwd
.../src/github.com/yurydelendik/wasmtext

```


## Reference

- [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/index.html)

## LICENSE

MIT
