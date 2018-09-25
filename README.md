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

