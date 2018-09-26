# YAMLtoGHOST

A simple python script for converting YAML Timeline rules to GHOST

## Usage

```
python yaml_to_ghost.py path_to_YAML_file #default to output.ghost
```
OR

```
python yaml_to_ghost.py path_to_YAML_file path_to_GHOST_file 
```

###  Issues

**Expression** tags are not handled because there is no rules for them in [https://github.com/singnet/ghost-bridge]

**magnitude** takes two values in YAML but there is only one (float value) node allocated in both gesture and emote methods of ghost_bridge

**blend** node is part of emote method in ghost_bridge but there is none defined in YAML entries

There are **<usel variant="2">** tags in YAML for speech parts that probably could be interpreted some way in GHOST(?)