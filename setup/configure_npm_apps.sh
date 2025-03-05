#!/bin/bash

CMD=npm
if ! command -v ${CMD} 2>&1 >/dev/null
then
    echo "${CMD} could not be found. Install ${CMD} with asdf."
    exit 1
fi

# Installs tools into ~/node_modules/bin
${CMD} install prettier -g
${CMD} install jsonlint -g
