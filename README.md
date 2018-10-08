# YAMLtoGHOST (Scheme)

A simple python script for converting YAML Timeline rules to GHOST

## Usage

```
python Scripts/YAMLtoJSON.py

(load "Scripts/JSONtoGHOST.scm")
```

### TODO

Computing further tests and code review

Doing the YAMLtoJson with Scheme (a commit later today)

###  Issues

**Expression** tags are not handled because there is no rules for them in [https://github.com/singnet/ghost-bridge]

**magnitude** takes two values in YAML but there is only one (float value) node allocated in both gesture and emote methods of ghost_bridge

**blend** node is part of emote method in ghost_bridge but there is none defined in YAML entries

There are **<usel variant="2">** tags in YAML for speech parts that probably could be interpreted some way in GHOST(?)

