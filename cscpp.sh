function cscpp {
    BRed='\033[1;31m'
    BGreen='\033[1;32m'
    NC='\033[0m'

    if ! [[ "$#" -gt 0 ]]
    then 
        echo "CSCPP Version 1.1"
        echo "use 'cscpp --help' for more information"
        return
    fi

    if [[ "$1" == "-h" || "$1" == "--help" ]]
    then
        echo "CSCPP Version 1.1"
        echo ""
        echo "currently using 'g++ -std=c++11 -Wall' to compile"
        echo ""
        echo "Usage : cscpp [OPTIONS] [SUBCOMMAND]"
        echo ""
        echo "OPTIONS:"
        echo "      -h, --help"
        echo ""
        echo "SUBCOMMANDS:"
        echo "      build, b    compiles but does not execute a .cpp or .cc file"
        echo "      debug, d    compiles with debug information but does not execute a .cpp or .cc file"
        echo "      run, r      default subcommand, compiles and executes a .cpp or .cc file"
        echo "      clean       finds and removes all *.cpp.out in the current directory and sub-directories"
        return
    fi

    if [[ -e "$1" ]]
    then
        echo -e -n "${BGreen}   Compiling${NC} '"$1"'"
        if [[ "$#" -gt 1 ]]
        then
            echo -n " --> linked with : "
            for ARGUMENT in ${@:2}
            do
                echo -n "'"$ARGUMENT"' "
            done
        fi
        echo ""
        g++ -std=c++11 -Wall "$@" -o "$1".out && \
        echo -e "${BGreen}     Running${NC} '"$1".out'" && \
        ./"$1".out
    
    elif [[ "$1" == "run" || "$1" == "r" ]]
    then
        echo -e -n "${BGreen}   Compiling${NC} '"$2"'"
        if [[ "$#" -gt 2 ]]
        then
            echo -n " --> linked with : "
            for ARGUMENT in "${@:3}"
            do
                echo -n "'"$ARGUMENT"' "
            done
        fi
        echo ""
        g++ -std=c++11 -Wall "${@:2}" -o "$2".out && \
        echo -e "${BGreen}     Running${NC} '"$2".out'" && \
        ./"$2".out
    
    elif [[ "$1" == "build" || "$1" == "b" ]]
    then
        echo -e -n "${BGreen}   Compiling${NC} '"$2"'"
        if [[ "$#" -gt 2 ]]
        then
            echo -n " --> linked with : "
            for ARGUMENT in "${@:3}"
            do
                echo -n "'"$ARGUMENT"' "
            done
        fi
        echo ""
        g++ -std=c++11 -Wall "${@:2}" -o "$2".out
    
    elif [[ "$1" == "debug" || "$1" == "d" ]]
    then
        echo -e -n "${BGreen}   Compiling${NC} '"$2"'"
        if [[ "$#" -gt 2 ]]
        then
            echo -n " --> linked with : "
            for ARGUMENT in "${@:3}"
            do
                echo -n "'"$ARGUMENT"' "
            done
        fi
        echo ""
        g++ -std=c++11 -g -Wall "${@:2}" -o "$2".out

    elif [[ "$1" == "clean" ]]
    then
        FILE_LIST=($(find . \( -name '*.cpp.out' -or -name '*.cc.out' \) -print))
        if [[ "$FILE_LIST" = "" ]]
        then
            echo "there is nothing to clean"
            return
        fi
        FILE_LIST_SIZE=$((0))
        for ELEMENT in "${FILE_LIST[@]}"
        do
            FILE_LIST_SIZE=$(("$FILE_LIST_SIZE" + 1))
            echo ">> "$ELEMENT""
        done
        read -p "confirm deletion? (y/n) " RESPONSE
        if [[ "$RESPONSE" == "y" || "$RESPONSE" == "Y" || "$RESPONSE" == "yes" || "$RESPONSE" == "Yes" ]]
        then
            rm --interactive='never' "${FILE_LIST[@]}" 
            echo "opertion completed"
        else
            echo "operation cancelled"
        fi
        return
    
    else
        echo -e "${BRed}error${NC} invalid subcommand and or argument"
        echo "try 'cscpp --help' for more information"
    fi
}
