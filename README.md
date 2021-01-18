## Description
Tmux script to create a "scratchpad" for quickly writing/running throwaway Node code. Alternative to starting a repl, an online service like repl.it, or writing code in your browser console, etc.

### Why it's Useful
I often find myself wanting to write and run some throwaway code as I reason about various problems. I will sometimes open up the Chrome Console to write code, but this can get annoying if you use `const`, as re-running your code will cause `Identifier has already been declared` errors.

Other times, I'll just create a new file called `foo.js` and manually run `node foo.js` after every save, which can be cumbersome.

`node-scratchpad` will script a tmux session, with two vertically split windows: your code on the left (in vim), and a file watcher on the write to run and print the console output of your code after every save.

### Dependencies
- https://github.com/watchexec/watchexec
- https://github.com/nvm-sh/nvm

### Installation and Usage
- Clone this repository
- Create a symlink to somewhere in your `PATH`
  * Ex: `ln -s <path_to_scratch.sh> /usr/local/bin/scratch`
- Run `scratch`
- If no `Scratch` session is already running, tmux will script a new one, and prompt you to enter your desired node version
  * You can run `CTRL+b` followed by `d` to detach from your current session without ending it (assuming your tmux "prefix" key is `CTRL+b`)
- If a `Scratch` session already exists, tmux will attach to existing session

### Other Notes
- This creates a file in the location of `~/scratchpad/scratch.js`
- The file is _not_ erased after closing the session
- You can copy the file contents to another location if you watch to save your scratchpad code
