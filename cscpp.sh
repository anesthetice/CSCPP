#!/bin/bash

function cscpp {
    GREEN='\033[1;32m'
    NC='\033[0m'
    if [ $# -gt 0 ]
    then
        echo -e -n "${GREEN}   Compiling${NC} '"$1"'"
        if [ $# -gt 1 ]
        then
            echo -n " --> linked with : "
            for ARGUMENT in $@
            do
                if [ $ARGUMENT != $1 ]
                then
                    echo -n "'"$ARGUMENT"' "
                fi
            done
        fi
        echo ""
        g++ -std=c++11 -Wall "$@" -o "$1".out && \
        echo -e "${GREEN}     Running${NC} '"$1".out'" && \
        ./"$1".out
    else
    echo -e "cscpp \"g++ -std=c++11 -Wall\""
    echo "Usage :"
    echo "  * cscpp [FILE]"
    echo "  * cscpp [MAIN_FILE] [FILE2] [FILE3] if your main c++ file is dependent on others"
    echo "csccp clean"
    fi
}

function newcscpp {
    GREEN='\033[1;32m'
    NC='\033[0m'

    if ! [ $# -gt 0 ]
    then 
        echo "CSCPP Version 1.0"
        echo "use 'cscpp --help' for more information"
        return
    fi
    
    if [ $1 == "clean" ]
    then
        FILE_LIST=($(find . -type f -name '*.cpp.out' -print))
        if [ FILE_LIST=="" ]
        then
            echo "There is nothing to clean"
            return
        fi
        FILE_LIST_SIZE=$((0))
        for ELEMENT in "${FILE_LIST[@]}"
        do
            FILE_LIST_SIZE=$(("$FILE_LIST_SIZE" + 1))
            echo ">> "$ELEMENT""
        done
        echo ""
        read -p "Are you sure you wish to delete these "$FILE_LIST_SIZE" files? (y/n) " RESPONSE
        if [[ "$RESPONSE" == "y" || "$RESPONSE" == "Y" || "$RESPONSE" == "yes" || "$RESPONSE" == "Yes" ]]
        then
            rm --interactive='never' "${FILE_LIST[@]}" 
            echo "Successfully deleted "${FILE_LIST_SIZE}" files"
        else
            echo "Operation cancelled by user"
        fi
        return
    fi


    



<<comment
    echo "CSCPP Version 1.0"
    echo ""
    echo "Usage : cscpp [OPTIONS] [SUBCOMMAND]"
    echo ""
    echo "OPTIONS:"
    echo "      -h, --help"
    echo ""
    echo "SUBCOMMANDS:"
    echo "      build, b    compiles but does not execute a .cpp or .cc file"
    echo "      run, r      default subcommand, compiles and executes a .cpp or .cc file"
    echo "      clean       finds and removes all *.cpp.out in the current directory and sub-directories"
comment
}

#cscpp solotest.cpp
#cscpp test.cpp test2.cpp test3.cpp
#cscpp solotest2.cpp
#cscpp solotest3.cpp
#echo ""
newcscpp clean