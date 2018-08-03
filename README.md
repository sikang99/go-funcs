## Go-Funcs

Some utility shell script functions useful in the go development environment


## Installation

```
$ go get github.com/sikang99/go-funcs
$ cd $GOPATH/src/github.com/sikang99/go-funcs
$ source ./go-funcs.sh
```

### Usage

To see help message of usage after installation, 
```
$ usage
usage: goget [<option>] <package path>
usage: gopath <name>
usage: gogl <search text>
```

To download go sources from open repos, use `goget` regardless of includng http scheme or .git tail.
```
$ goget
usage: goget [<option>] <package path>

$ goget https://github.com/sikang99/go-funcs.git
$ goget https;//github.com/sikang99/go-funcs -u
$ goget github.com/sikang99/go-funcs/... -u -v
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
```

### Reference

- [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/index.html)

### LICENSE

MIT

