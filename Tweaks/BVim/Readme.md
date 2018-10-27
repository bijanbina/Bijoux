#BVIM
BVim is a customized bijoo remix version of vim.

## Keyboard Shortcut:

ALT + f : Fullscreen

ALT + b : run build.sh script*

*:a sample for gtk and qt is embeded


### keyboard shortcut
gnome-terminal --full-screen --working-directory="<SOURCE DIRECTORY>" -e "bvim main.c"

### shortcut script
```
#! /bin/sh
cd /home/bijan/Project/OpenCV/Source/
bvim -p mainwindow.cpp mainwindow.h main.cpp .
```

### compile option


## VIM Configuration FAQ
In the rest of this document a memo written for later consideration

#### Q: What is inoremap and whats the difference with imap
imap is a command to map key only in insert mode. inoremap is a imap with a *non recursive* behaviour thus insert + non recursive + map = inoremap. On contrary you can use simple `map` function to map a key to all modes

#### Special Key in Map function
- `<CR>`: is short form of clear or return. It means "Enter" key on keyboard. It uses on end of commands that required execution.
- `<C-R>`: mean CTRL+R
- `<M-f> ` :  mean ALT+F
- `<A-f>`: Another way to define ALT+F
- `<S-f>`: mean SHIFT+F
- ` <C-S-F3>`: mean CTRL+SHIFT+F3
- `<D-A>`: mean WIN + A

#### Q: What CTRL+Y or CTRL+E do?
CTRL+Y scroll screen one line up and CTRL+E scroll one line down. Till now no command has been found to replace this shortcut. moreover `<C-y>` mean 3 line scroll to up
