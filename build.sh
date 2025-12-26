namespace=z_q
registry=registry.cn-hangzhou.aliyuncs.com

function build_jdk17_image () {
    docker_file=files/jdk17

    tag=${registry}/${namespace}/jdk17

    context_path=.

    docker build --platform linux/amd64 --force-rm \
         -f ${docker_file} \
         -t ${tag} \
         ${context_path}

    docker push ${tag}
}

function build_jdk21_image () {
    docker_file=files/jdk21

    tag=${registry}/${namespace}/jdk21

    context_path=.

    docker build --platform linux/amd64 --force-rm \
         -f ${docker_file} \
         -t ${tag} \
         ${context_path}

    docker push ${tag}
}

function build_package_image () {
    docker_file=files/build_node14_jdk21

    tag=${registry}/${namespace}/build-mvn-node14-amd64

    context_path=.

    docker build --platform linux/amd64 --force-rm \
         -f ${docker_file} \
         -t ${tag} \
         ${context_path}

    # docker push ${tag}
}

cmds=( \

build_jdk21 \

build_jdk17 \

build_package_image

)

function do_command () {

    case $1 in

        build_jdk21)
           build_jdk21_image
           ;;

        build_jdk17)
            build_jdk17_image
            ;;

        build_package_image)
            build_package_image
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