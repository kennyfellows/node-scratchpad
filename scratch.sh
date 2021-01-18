#!/bin/sh

# start new tmux session
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

  echo "using version $NODE_VERSION"

  tmux new-session -d -s $SESSION

  tmux rename-window -t 0 "main"
  tmux send-keys -t "main" \
    "cd ~/scratchpad" C-m \
    "nvm install $NODE_VERSION; tmux wait-for -S node-version-ready" C-m \
    "nvm use $NODE_VERSION" C-m \
    "touch scratch.js" C-m \
    "vim scratch.js" C-m

  tmux wait-for "node-version-ready"

  tmux split-window -h
  tmux send-keys -t "main" \
    "cd ~/scratchpad" C-m \
    "nvm use $NODE_VERSION" C-m \
    "watchexec -i ~/scratchpad/scratch.js -c node scratch.js" C-m

  tmux selectp -t 0
fi

tmux attach-session -t $SESSION:0
