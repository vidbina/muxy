if [ -e "$MUXY_PATH/settings.bash" ]; then
  source "$MUXY_PATH/settings.bash"
fi
if [ -z $1 ]; then # first argument is nil
  select opt in $OPTIONS; do # present menu
    if [ -z $opt ]; then
      echo "Please specify the number of the project to load"
    else
      echo "opt is $opt"
      project="$PROJECTS_PATH/$opt"
      if [ -e "$project/$target" ] && [ -s "$file/$target" ]; then
        break
      else
        echo "Make sure there is something to load in $file/$target"
      fi
    fi
  done
else # first argument is give, so load project is exists
  echo "Not yet implemented"
fi
