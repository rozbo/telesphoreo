#!/bin/bash
echo "$@" | grep -- --atleast >/dev/null && exit 0
exec pkg-config "$@"
