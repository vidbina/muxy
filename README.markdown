# Muxy
Setting up tmux session and pulling them down again is becoming a bit less of
a hassle with muxy.

I wrote this script to help me out after deciding that I didn't want a gem to
do that stuff for me. Haven't looked around too much as I though it would have
been a nice puzzle for me to solve while waiting here.

BTW: I've only tested this in bash.

## Setup
Wherever you choose to download or clone the muxy project. Make sure that
you load it in whichever script is called when you start a teminal session.

OSX users will find the `~/.bash_profile` the place to be, unless you've
changed your default shell in which case you should know where to find it.
Linux users will most likely find the `~/.bashrc` to place to be, unless
they too are using another shell (in which case, they too should know where
to find the right script).
Mind you that I have only tried muxy in bash.

Simply load muxy by adding the following line to the loading script
```
#bin/bash
PATH_TO_MUXY=/Home/yoda/.muxy # you decide ;)
source $PATH_TO_MUXY/muxy.bash
```

## Usage
Muxy defines two bash functions ```load``` and ```unload``` which will present
you a list of options enroute to your destiny.

You add projects to muxy by adding directories in the muxy directory.

These directories should contains the following files:
 - ```base.bash``` an optional script which may contain variables and logic to be used to setup and destroy projects
 - ```up.bash``` the script to load up a project
 - ```down.bash``` the script to close down a project

When looking into the muxy directory your structure should bear some 
similarities to the following example.
```
.
├── README.markdown
├── awesome_project
│   ├── base.bash
│   ├── down.bash
│   └── up.bash
├── kewl_project
│   ├── base.bash
│   ├── down.bash
│   └── up.bash
├── lame_project
│   ├── base.bash
│   ├── down.bash
│   └── up.bash
├── muxy.bash
└── settings.bash
```

All muxy files are in the root directory, while your project definitions are
setup in the appropriately named subdirectories. The names of the 
subdirectories represent the names used by you to reference these projects in
muxy so please make these names as unambiguous as possible.

Upon running ```load``` in the terminal, muxy will present a list of projects
to choose from:
```
~ $ load
1) awesome_project
2) kewl_project
3) lame_project
#?
```
Typing 1 and pressing enter will source the ```base.bash``` from the 
```awesome_project``` subdirectory followed by the ```up.bash``` script from the
```awesome_project``` subdirectory.

Unloading works in a similar fashion but calls ```down.bash``` instead of 
```up.bash```.

Because ```base.bash``` is always called first it is a very convenient place
to define variables that you may need to both load and unload projects :wink:.

### Base
The optional ```base.bash``` file for a project can simply contain a few
variable definitions and some other helpers to be used trying to setup or 
pull down a project session.

```
#/bin/bash
NAME="another_kewl_project"
BASE="$HOME/dev/kewl_project"
```

### Up
The ```up.bash``` file does whatever specified everytime a load request is
issued for a project. Since I'm using tmux it creates a new session
creates the necessary windows and runs some commands in the created windows
to get me all setup to get to business.

Some projects start daemons in some windows, run ```git log``` in other windows
just to help me jar my memory of what it was I last worked on and even load up
the source files I need in my editor of choice (vim, not that its relevant 
:smile:).

```
#/bin/bash
cd $BASE
tmux start-server

# Create 3 windows in tmux named git, base and playground
tmux new-session -d -s $NAME -n git
tmux new-window -t $NAME:1 -n base
tmux new-window -t $NAME:2 -n playground

# Split the git window and show the log in one pane and the status in another
tmux send-keys -t $NAME:0 "git log --oneline --graph" C-m
tmux split-window -h -t $NAME:0
tmux send-keys -t $NAME:10 "git status" C-m

# List all directories in the base window before I get to editing
tmux send-keys -t $NAME:1 "ls" C-m
```

### Down
The ```down .bash``` file just tears down the house. For me as a tmux user it
simply means wrecking the tmux session to pieces :smirk:. I don't have anything
intelligent setup for my default down scripts.

```
#/bin/bash

# Kill the session
tmux kill-session -t $NAME
```
