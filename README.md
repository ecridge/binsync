# binsync

A simple tool for managing user scripts.

The line between source code and binary is a blurry one when it comes to
scripting. If you frequently find yourself running `./foobar.sh`, it is
tempting to rename the script to “foobar” and place it somewhere in your path.
This makes execution easier – now you can just run `foobar` as you would any
other binary – but is less than ideal when it comes to editing. A much cleaner
approach is to keep all your script sources together in one directory (with
descriptive extensions like .sh or .rb) and symlink ‘binary’ versions of them
into your path as necessary.

binsync can take care of this for you: for every executable script you place in
`~/src` it will create a corresponding ‘binary’ in `~/bin`. You can control
which scripts get symlinked simply by the setting of the executable bit on the
source file.

## Installation

1.  Create `~/bin` and `~/src` if you don’t have them already:

    ```bash
    mkdir ~/bin ~/src && chmod 700 ~/bin ~/src
    ```

    Hide them from Finder on OS X:

    ```bash
    chflags hidden ~/bin ~/src
    ```

    Or from Nautilus on Ubuntu:

    ```bash
    printf 'bin\nsrc\n' >> ~/.hidden
    ```

2.  Make sure that `~/bin` is in your PATH – run `echo $PATH | grep -c ~/bin`
    and check for a `1`. If you get `0`, you can add it using:

    ```bash
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc
    ```

3.  Save `binsync.sh` into `~/src` and make it executable:

    ```bash
    cd ~/src && curl -sSL cridge.co/1dWPW6p -o binsync.sh
    chmod +x binsync.sh
    ```

4.  Run `./binsync.sh` to invoke binsync for the first time. binsync will now
    symlink itself into `~/bin` so that you can call it using `binsync` in the
    future.

5.  You’re good to go! Next time you write a script and save it into `~/src`,
    you can invoke binsync to create an easy access symlink of it for you.
    binsync will also notify you if you forgot to make the script executable,
    and will remove any stale symlinks for scripts that you’ve moved or made
    non-executable. If you regularly add or remove scripts from `~/src`, you
    can have binsync automatically run (silently) whenever you open a new
    terminal window:

    ```bash
    echo 'binsync > /dev/null' >> ~/.bashrc
    ```

## License

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.

In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>.
