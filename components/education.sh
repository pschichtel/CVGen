
build_component() {
    if [ -z "$educations" ]
    then
        echo "No educations defined!"
        exit 4
    fi
    
    local c=$(
        for i in "${educations[@]}"
        do
            "${erb[@]}" -r "${comp_base}/${i}" "${template_dir}/education.erb"
        done
    )
    
    CONTENT="$c" "${erb[@]}" "${template_dir}/educations.erb"
}
