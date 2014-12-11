#!/usr/bin/env bash
EXT=".bash"
  
MUXY_PATH="$HOME/.bin/muxy"
PROJECTS_PATH="$MUXY_PATH"

function load
{
  setup="base$EXT"
  target="up$EXT"
  source "$MUXY_PATH/menu.bash"

  if [ -e "$project/$target" ] && [ -s "$project/$target" ]; then
    source "$project/$setup"
    source "$project/$target"
  else
    echo "Make sure there is something to load in $project/$target"
  fi
}

function unload
{
  setup="base$EXT"
  target="down$EXT"
  source "$MUXY_PATH/menu.bash"

  if [ -e "$project/$target" ] && [ -s "$project/$target" ]; then
    source "$project/$setup"
    source "$project/$target"
  else
    echo "Make sure there is something to unload in $project/$target"
  fi
}

function muxify
{
  target=""
  source "$MUXY_PATH/menu.bash"

  if [ -e "$project" ]; then
    $EDITOR $project
  else
    echo "muxification not possible"
  fi
}
