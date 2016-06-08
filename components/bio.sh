build_component() {
    if [ -z "$bio" ]
    then
        echo "No bio defined!"
        exit 4
    fi
    
    "${erb[@]}" -r "${comp_base}/${bio}" "${template_dir}/bio.erb"
}
