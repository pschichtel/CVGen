#!/bin/bash

target="${1?Missing argument: the CV to build!}"
template="${2?Missing argument: the template to use!}"

here="$(readlink -f "$(dirname "$0")")"
component_dir="${here}/components"
cv_dir="${here}/cvs"
template_dir="${here}/templates/${template}"
erb=(erb -T -)

cv="${cv_dir}/${target}"
if ! test -f "$cv"
then
    echo "CV '${target}' not defined!"
    exit 1
fi

source "$cv"

if [ -z "$components" ]
then
    echo "No components defined by the CV!"
    exit 2
fi

tmp="$(mktemp -d)"
echo "Generating components to ${tmp}"
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
    output="$(build_component)"
    echo "$output" > "${tmp}/${component}"
    echo "$output"
    unset -f build_component
    
done
