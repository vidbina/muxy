if [ -e "$MUXY_PATH/settings.bash" ]; then
  source "$MUXY_PATH/settings.bash"
fi

if [ -z $1 ]; then # first argument is nil
  PROJECTS=$( ls -d $PROJECTS_PATH/*/ )
  if [[ -n $ZSH_NAME ]]; then
    OPTIONS=($(sed "s:$PROJECTS_PATH/\([a-zA-Z0-9_-]*\)/:\1:g" <<< $PROJECTS));
  elif [[ -n $BASH ]]; then
    OPTIONS=$(sed "s:$PROJECTS_PATH/\([a-zA-Z0-9_-]*\)/:\1:g" <<< $PROJECTS);
  else
    OPTIONS=$(sed "s:$PROJECTS_PATH/\([a-zA-Z0-9_-]*\)/:\1:g" <<< $PROJECTS);
  fi

  select opt in $OPTIONS; do # present menu
    if [ -z $opt ]; then
      echo "Please specify the number of the project to load"
    else
      echo "opt is $opt"
      project="$PROJECTS_PATH/$opt"
      if [ -e "$project/$target" ] && [ -s "$project/$target" ]; then
        break
      else
        echo "Make sure there is something to load in $project/$target"
      fi
    fi
  done
else # first argument is give, so load project is exists
  echo "Not yet implemented"
fi
