## Go-Funcs

Some utility shell script functions useful in the go development environment


## Installation

```
$ go get github.com/sikang99/go-funcs
$ cd $GOPATH/src/github.com/sikang99/go-funcs
$ source ./go-funcs.sh
```

### Usage

To see help message of usage, 
```
$ usage
usage: goget [<option>] <package path>
usage: gopath <name>
usage: gogl <search text>
```

To download go sources from open repos, use goget regardless of includng http scheme or .git tail.
```
$ goget 

$ goget https://github.com/sikang99/go-funcs.git
$ goget https;//github.com/sikang99/go-funcs -u
$ goget github.com/sikang99/go-funcs/... -u -v
```


### Reference

- [Advanced Bash-Scripting Guide](https://www.tldp.org/LDP/abs/html/index.html)

### LICENSE

MIT

