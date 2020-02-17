# emacs_config_windows
THIS IS A GOOGLE-ORIENTED ELISP CUSTOMIZATION(I HAVE NO ELISP DEV EXPERIENCE), ANY SUGGESTIONS WILL BE SINCERELY APPRECIATED!

emacs config for windows with some useful feature


===============features================

1. Open windows explorer at current buffer path (files, dired, eshell), shortcut C-x e, copy path of current buffer, short C-x c

2. save/load eshell buffers on kill-emacs-hook/ startup

3. Open other file on existing emacs instance.

4. save eshell command history customization (no duplicate, filtered cd/ls etc.), your can use history items cross eshell buffers, all history in every eshell buffers will be saved to *history* and loaded after next start.

    (s s) sort by size

    (s x) sort by type

    (s t) sort by modified time

    (s n) sort by name
¹¤
5. copy all marked files in dired+, seperate file with ';' for Paraview Open

6. extend dired: sort with different strategy, use ")" to hide specific type of files

7. easy switch between windows

    (C-<) switch to up-left window

    (C->) switch to up-right window

    (C-,) switch to down-left window

    (C-.) switch to down-right window

8. markdown-mode Chinese support(need pandoc.exe), [C-c, C-c, p] to preview in chrome

9. octave/matlab mode initilization
===========3rd included:==============

google-c-style

dired+

cmake-mode

zenbrun-theme

auctex
===========working on: ===============

ftp for windows10
