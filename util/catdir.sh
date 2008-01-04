#!/bin/bash
find -H "$1" -type l -printf '%p -> %l\n' | sort
find -H "$1" -type f -print0 | sort -z | xargs -0 cat
