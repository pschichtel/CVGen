build_component() {
    if [ -z "$activities" ]
    then
        echo "No activities defined!"
        exit 4
    fi
    
    for i in "${activities[@]}"
    do
        "${erb[@]}" -r "${comp_base}/${i}" "${template_dir}/activity.erb"
    done
}
