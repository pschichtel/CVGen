build_component() {
    if [ -z "$experiences" ]
    then
        echo "No experiences defined!"
        exit 4
    fi
    
    local c=$(
        for i in "${experiences[@]}"
        do
            "${erb[@]}" -r "${comp_base}/${i}" "${template_dir}/experience.erb"
        done
    )
    
    CONTENT="$c" "${erb[@]}" "${template_dir}/experiences.erb"
}
