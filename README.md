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
usage: goget [<option>] <package path>
usage: gopath <name>
usage: gogl <search text>
usage: goroot <go version>
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
```
$ gopath
usage: gopath <name>

$ gopath go-funcs
$ pwd
GOPATH/src/github.com/sikang99/go-funcs
```

To use `gogl`, install [sikang99/hub-search](https://github.com/sikang99/go-funcs).
```
$ goget https://github.com/sikang99/go-funcs
$ gogl
usage: gogl <search text>

$ gogl "github search"
...
```

To select a specific go version installed, use `goroot` with version number such as 1.10, 1.11
Currently my case for go versions is as following.
```
$ tree -L 1 $GOROOT/..
$HOME/root/go/..
├── bak
├── go -> go1.11beta2
├── go1.10.3
└── go1.11beta2
```
try to use `goroot`
```
$ goroot
usage: goroot <version>

$ goroot 1.10 # or 1.10.3, go1.10.3
go version go1.10.3 linux/amd64

$ goroot 1.11
go version go1.11beta2 linux/amd64
```



### Reference

- [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/index.html)

### LICENSE

MIT

