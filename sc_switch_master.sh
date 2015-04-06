#!/bin/bash
git checkout master

if [ "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')" = " (master)" ]
then
    echo "****master****"

    cp gitignore_master .gitignore
    grunt build-dev

    rm public/system
    ln -s ../_system public/system

    echo "ON BRANCH: 'master'."
fi

