#!/bin/sh

# make nvm available
export NVM_DIR=$HOME/.nvm;
source $NVM_DIR/nvm.sh;

SESSION="Scratch"

tmux has-session -t $SESSION 2>/dev/null

if [ $? = 0 ]
then
  echo "Session exists, attaching"
else
  echo "Starting new scratchpad session"
  echo "Enter node version, leave blank for LTS:"
  read VERSION

  NODE_VERSION=${VERSION:-"--lts"}

  nvm install "$NODE_VERSION"
  NODE_SOURCE=$(which node)

  tmux new-session -d -s $SESSION

  tmux rename-window -t 0 "main"

  tmux send-keys -t "main" \
    "cd ~/scratchpad" C-m \
    "touch scratch.js" C-m \
    "vim scratch.js" C-m

  tmux split-window -h
  tmux send-keys -t "main" \
    "cd ~/scratchpad" C-m \
    "watchexec -i ~/scratchpad/scratch.js -c $NODE_SOURCE scratch.js" C-m

  tmux selectp -t 0
fi

tmux attach-session -t $SESSION:0
