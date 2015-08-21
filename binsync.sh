#!/usr/bin/env bash

# Synchronise symbolic links in ~/bin with scripts in ~/src

(( additions = 0 ))
(( deletions = 0 ))
allowed_types=( sh rb )
shopt -s nullglob
echo "Updating user binaries:"
echo "  (only executable scripts will be added)"
echo
for file_type in "${allowed_types[@]}" ; do
  for script in ~/src/*.$file_type ; do
    binary=$(echo $script | sed -e "s|$HOME/src/\(.*\).$file_type|\1|")
    if [[ -x "$script" ]] ; then
      if [[ ! -e "$HOME/bin/$binary" && ! -L "$HOME/bin/$binary" ]] ; then
        # If no corresponding link/file in ~/bin for an EXECUTABLE script
        ln -rs "$script" "$HOME/bin/$binary"
        echo -e "\033[32m\tadded:      $binary\033[0m"
        (( additions++ ))
      fi
    else
     if [[ ! -e "$HOME/bin/$binary" && ! -L "$HOME/bin/$binary" ]] ; then
       # If no corresponding link/file for a NON-executable script
       echo -e "\033[33m\tnot added:  $binary\033[0m"
      fi
    fi
  done
done
echo
echo "Removing stale symlinks:"
echo "  (source scripts moved or no longer executable)"
echo
for link in ~/bin/* ; do
  binary=$(echo $link | sed -e "s|$HOME/bin/\(.*\)$|\1|")
  if [[ -e "$link" ]] ; then
    if [[ ! -x "$link" ]] ; then
      # If there is a link in ~/bin to a NON-executable
      rm "$link"
      echo -e "\033[31m\tdeleted:    $binary\033[0m"
      (( deletions++ ))
    fi
  else
    # If link in ~/bin is orphaned
    rm "$link"
    echo -e "\033[31m\tdeleted:    $binary\033[0m"
    (( deletions++ ))
  fi
done
echo
echo "$additions additions(+), $deletions deletions(–)"
