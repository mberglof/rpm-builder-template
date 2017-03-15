#!/bin/bash
if [ -f ~/.config/copr ]; then
    echo "export COPR_LOGIN=${COPR_LOGIN:-$(awk '/login/ {print $3}' ~/.config/copr)}"
    echo "export COPR_USERNAME=${COPR_LOGIN:-$(awk '/username/ {print $3}' ~/.config/copr)}"
    echo "export COPR_TOKEN=${COPR_LOGIN:-$(awk '/token/ {print $3}' ~/.config/copr)}"
else
    echo "echo err"
    exit 1
fi
