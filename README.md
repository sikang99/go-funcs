## Go-Funcs

Some utility shell script functions useful in the go development environment


## Installation

```
$ go get github.com/sikang99/go-funcs
$ cd $GOPATH/src/github.com/sikang99/go-funcs
$ source ./go-funcs.sh # or include . <path>/go-funcs.sh in ~/.bashrc
```

### Usage

To see help message of usage after installation, 
```
$ usage
usage: goto [.|..|root|path|stoney|wasm|webcam|http]
usage: goget [<option>] <package path>
usage: gopath <package name>
usage: gogl <search text>
usage: gover <go version>
```

To change a specific directory, use `goto`.
```
$ goto
usage: goto [.|..|root|path|stoney|wasm|webcam|http]

$ goto . # save the current directory
$ goto .. # return to the saved directory
```

To download go sources from open repos, use `goget` regardless of includng http scheme or .git tail.
```
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
```
$ gopath
usage: gopath <package name>

$ gopath go-funcs
GOPATH/src/github.com/sikang99/go-funcs

$ gopath github.com
GOPATH/src/github.com
```

To use `gogl`, install [sikang99/hub-search](https://github.com/sikang99/go-funcs).
```
$ goget https://github.com/sikang99/go-funcs
$ gogl
usage: gogl <search text>

$ gogl wasm
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

$ gogl "github search"
...
```

To select a specific go version installed in your environment, 
use `gover` with version number such as 1,9, 1.10, 1.11
Currently my case with two go versions is as following. 
If your want to support more versions, plz edit the script. 
```
$ tree -L 1 $GOROOT/..
$HOME/root/go/..
├── bak
├── go -> go1.11beta2
├── go1.9.7
├── go1.10.3
└── go1.11beta3
```
try to use `gover`
```
$ gover
usage: gover <go version>

$ gover 1.10 # or 1.9, 1.10.3, go1.10.3
go version go1.10.3 linux/amd64

$ gover 1.11
go version go1.11beta3 linux/amd64
```


### Reference

- [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/index.html)

### LICENSE

MIT

