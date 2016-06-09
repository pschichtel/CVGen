#!/bin/bash

target="${1?Missing argument: the CV to build!}"
template="${2?Missing argument: the template to use!}"

here="$(readlink -f "$(dirname "$0")")"
component_dir="${here}/components"
cv_dir="${here}/cvs"
template_dir="${here}/templates/${template}"
out_dir="${here}/out"

erb=(erb -T -)

cv="${cv_dir}/${target}"
if ! test -f "$cv"
then
    echo "CV '${target}' not defined!"
    exit 1
fi

test -d "$out_dir" || mkdir "$out_dir"

compile_cv() {
    
    cp "$1" "${out_dir}/${title}"
}

source "$cv"

if [ -z "$components" ]
then
    echo "No components defined by the CV!"
    exit 2
fi

c=$(
    for component in "${components[@]}"
    do
        script="${component_dir}/${component}.sh"
        if ! test -f "$script"
        then
            echo "Component '${component}' is not defined!"
            exit 3
        fi
        comp_base="${component_dir}/${component}"
        source "$script"
        build_component
        unset -f build_component
        
    done
)

tmp=$(mktemp)
CONTENT="$c" "${erb[@]}" "${template_dir}/base.erb" > "$tmp"
compile_cv "$tmp"


