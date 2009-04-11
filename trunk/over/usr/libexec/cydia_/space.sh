#!/usr/libexec/cydia_/bash
export PATH=/usr/libexec/cydia_
. /usr/libexec/cydia/space.sh
[[ $(df_ /) -gt 35651584 && $(df_ /var) -gt 35651584 ]]
