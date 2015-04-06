#!/bin/bash
rm public/system
git checkout with_public

if [ "$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')" = " (with_public)" ]
then
    echo "****with_public****"

    cp gitignore_with_public .gitignore
   
    rm -rf public/fonts public/images public/javascripts public/stylesheets
    grunt build-prod

    echo "ON BRANCH: 'with_public'."

    echo "Directory 'public' was cleaned and 'grunt build-prod' was executed."

    echo "DON'T FORGET TO DO: 'git merge --no-commit master' !!"

    echo After that you can do: 'gc -m "updated public folder for heroku:"'
    echo and: 'git push heroku with_public:master'

    echo "WHEN FINISHED DON'T FORGET TO INVOKE: 'sc_switch_master.sh' !!"
else
    rm public/system    
fi

