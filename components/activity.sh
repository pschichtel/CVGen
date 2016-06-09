build_component() {
    if [ -z "$activities" ]
    then
        echo "No activities defined!"
        exit 4
    fi
    
    local c=$(
        for i in "${activities[@]}"
        do
            "${erb[@]}" -r "${comp_base}/${i}" "${template_dir}/activity.erb"
        done
    )
    
    CONTENT="$c" "${erb[@]}" "${template_dir}/activities.erb"
}
