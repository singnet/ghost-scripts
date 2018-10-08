<<<<<<< HEAD
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

=======
# Performance scripts to GHOST converter. 

# Objective
We can author robot performances utilizing the Hanson Robotics's [ webui ]( https://github.com/hansonrobotics/webui ) to deliver prepared speeches similar to a human presenter. On a different note also, we can script behaviors for artificial characters utilizing [GHOST](https://github.com/opencog/opencog/tree/master/opencog/ghost) which allows to author that cover wider range of situations in more flexible and intelligent way.

This project aims to import performance scripts authored using the aforementioned webui app to the ghost domain to enable control of our characters from GHOST pipeline most of the time.  

# Task list
The set of things to done for this endeavor are outlined in our [projects ] (https://github.com/singnet/ghost-scripts/projects/1) page. 
>>>>>>> 8dc6e97b4a91563d815a65fe48a1cf9915c88222
