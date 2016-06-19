#!/usr/bin/env bash

# Synchronise symbolic links in ~/bin with shell scripts in ~/src.

shopt -s nullglob  # Don’t take ‘*’ literally if there are no matches.

allowed_types=( pl py rb sh )

(( additions = 0, deletions = 0 ))


echo "Updating user binaries:"
echo "  (only executable scripts will be added)"
echo
for file_type in "${allowed_types[@]}"; do
    for script in ~/src/*.$file_type; do
        binary=$(echo $script | sed -e "s|$HOME/src/\(.*\).$file_type|\1|")
        link="$HOME/bin/$binary"
        if [[ ! -e $link && ! -L $link ]]; then
            if [[ -x $script ]]; then
                # Executable script has no corresponding link in ~/bin.
                ln -rs "$script" "$link"
                echo -e "\033[32m\033\tadded:      $binary\033[0m"
                (( additions++ ))
            else
                # Non-executable script has no corresponding link in ~/bin.
                echo -e "\033[33m\033\tnot added:  $binary\033[0m"
            fi
        fi
    done
done
echo


echo "Removing stale symlinks:"
echo "  (source scripts moved or no longer executable)"
echo
for link in ~/bin/*; do
    binary=$(echo $link | sed -e "s|$HOME/bin/\(.*\)$|\1|")
    if [[ ! -e $link || ! -x $link ]]; then
        # Link exists for deleted or no longer executable script.
        rm "$link"
        echo -e "\033[31m\033\tdeleted:    $binary\033[0m"
        (( deletions++ ))
    fi
done
echo


# Summarise action.
echo "$additions additions(+), $deletions deletions(–)"
