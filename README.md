# Lipen's dotfiles

> Managed by [chezmoi](https://github.com/twpayne/chezmoi).

Previous version of dotfiles (managed by [GNU Stow](https://www.gnu.org/software/stow/)) can be found in the folder [old](old).

---

-   Checkout and apply:

    ```shell
    chezmoi init --apply --verbose https://github.com/Lipen/dotfiles.git
    ```

-   `chezmoi`s folder: `~/.local/share/chezmoi`. You can symlink it as follows:

    -   On Unix:

        ```shell
        ln -s ~/.local/share/chezmoi ~/dotfiles
        ```

    -   On Windows (in home directory):
        ```shell
        mklink /J dotfiles ".local/share/chezmoi"
        ```

-   Example `~/.gitconfig.local`:

    ```ini
    [user]
        name = Your Name
        email = your@email.com
        signingKey = Y0UR-GPG-K3Y
    [core]
        autocrlf = true
        longpaths = true
        editor = code --wait
        sshCommand = 'C:/Program Files/OpenSSH-Win64/ssh.exe'
    [gpg]
        program = C:/Program Files (x86)/GnuPG/bin/gpg.exe
    ```
