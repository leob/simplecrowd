#!/bin/bash
rm public/system
git checkout with_public

if [ "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')" = " (with_public)" ]
then
    echo "****with_public****"

    cp gitignore_with_public .gitignore
   
    rm -rf public/fonts public/images public/javascripts public/stylesheets
    git merge --no-commit master
    grunt build-prod

    git status

    echo "ON BRANCH: 'with_public'."

    echo "Directory 'public' was cleaned, changes were merged from master, and 'grunt build-prod' was executed."

    echo DONT FORGET TO DO: 'gc -m "updated public folder for heroku"'
    echo and: 'git push heroku with_public:master'

    echo "WHEN FINISHED DONT FORGET TO INVOKE: 'sc_switch_master.sh' !!"
else
    rm public/system    
fi

