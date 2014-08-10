EXT=".bash"
  
MUXY_PATH="$HOME/.bin/muxy"
PROJECTS_PATH="$MUXY_PATH"
PROJECTS=$( ls -d $PROJECTS_PATH/*/ )
OPTIONS=$(sed "s:$PROJECTS_PATH/\([a-zA-Z0-9_-]*\)/:\1:g" <<< $PROJECTS);

function load
{
  if [ -e "$MUXY_PATH/settings.bash" ]; then
    source "$MUXY_PATH/settings.bash"
  fi
  if [ -z $1 ]; then # first argument is nil
    select opt in $OPTIONS; do # present menu
      if [ -z $opt ]; then
        echo "Please specify the number of the project to load"
      else
        echo "opt is $opt"
        file="$PROJECTS_PATH/$opt"
        if [ -e "$file/up$EXT" ] && [ -s "$file/up$EXT" ]; then
          source "$file/base$EXT"
          source "$file/up$EXT"
          break
        else
          echo "Make sure there is something to load in $file/up$EXT"
        fi
      fi
    done
  else # first argument is give, so load project is exists
    echo "Not yet implemented"
  fi
}

function unload
{
  if [ -e "$MUXY_PATH/settings.bash" ]; then
    source "$MUXY_PATH/settings.bash"
  fi
  if [ -z $1 ]; then # first argument is nil
    select opt in $OPTIONS; do # present menu
      if [ -z $opt ]; then
        echo "Please specify the number of the project to unload"
      else
        echo "opt is $opt"
        file="$PROJECTS_PATH/$opt"
        if [ -e "$file/down$EXT" ] && [ -s "$file/down$EXT" ]; then
          source "$file/base$EXT"
          source "$file/down$EXT"
          break
        else
          echo "Make sure there is something to unload in $file/down$EXT"
        fi
      fi
    done
  else # first argument is give, so load project is exists
    echo "Not yet implemented"
  fi
}
