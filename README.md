## Overview

```bash
# Clone directly into ~/.config/nvim
git clone git@github.com:pgr0ss/vim_dotfiles ~/.config/nvim

# Install plugins
~/.config/nvim/activate.sh
```

Uses `vim-plug` to manage bundles.

## Default Shortcuts

The file explorer - NERD Tree:

```
\nt - open/close NERD Tree
\nf - reveal the current file in NERD Tree
\nr - refresh the contents of NERT Tree (can also use r or R to refresh a folder)
? - in NERD Tree to see all its shortcuts
```

File search - fzf:

```
\ff - find a file
\fg - find a file that is committed to git
\fb - find an open buffer
\ft - find ctags
```

Comments (watch out for \'s):

```
gc<motion> - toggle comments
gcc - toggle comments on the current line
\cc - toggle comments
\uc - toggle comments
```

Vimux (must be inside a tmux)

```
\vp - prompt for a command to run in vimux
\vs - send the block of code to the vimux window
\vl - run the last command
```

Jump to definition - CTags

```
CTRL+] - jump to definition
g CTRL+] - pop up a selector if there is more than one definition; if there is only one, jump there
\rt - rebuild tags
```

Git

```
\gw - git grep for the word under the cursor

:GitHubURL - get the github url for the current file at the current line
```

Test Mappings

```
\rb - run all tests in current buffer
\rf - run the test under the cursor
\rl - run the last test
```

Searching

```
\nh - :nohlsearch - stop highlighting the last search
```
