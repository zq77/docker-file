namespace=z_q
registry=registry.cn-hangzhou.aliyuncs.com

function build_jdk17_image () {
    docker_file=debain_files/jdk17

    tag=${registry}/${namespace}/jdk17

    context_path=.

    docker build --force-rm \
         -f ${docker_file} \
         -t ${tag} \
         ${context_path}

    docker push ${tag}
}

cmds=( \

#build_node14 \

build_jdk17

)

function do_command () {

    case $1 in

#        build_node14)
#            build_jdk17_image
#            ;;

        build_jdk17)
            build_jdk17_image
            ;;

        *)

            echo "Please select what you want to do:"

            ;;

    esac

}



# functional codes for this shell, you can ignore

function select_cmd () {

    echo "Please select what you want to do:"

    select CMD in ${cmds[*]}; do

        if [[  $(in_array $CMD ${cmds[*]}) = 0 ]]; then

            do_command $CMD

            break

        fi

    done

}

function select_arg () {

    cmd=$1

    shift 1

    options=("$@")



    echo "Please select which arg you want:"

    select ARG in ${options[*]}; do

        if [[  $(in_array ${ARG} ${options[*]}) = 0 ]]; then

            ${cmd} ${ARG}

            break

        fi

    done

}

function in_array () {

    TARGET=$1

    shift 1

    for ELEMENT in $*; do

        if [[ "$TARGET" == "$ELEMENT" ]]; then

            echo 0

            return 0

        fi

    done

    echo 1

    return 1
}

function main () {
    if [[ $1 != "" && $(in_array $1 ${cmds[*]}) = 0 ]]; then
        do_command $*
    else
        select_cmd
    fi
}

main $*