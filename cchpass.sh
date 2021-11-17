#!/bin/env bash

CCH_DIR="$HOME/.coctohug"
MNC_RAW_FILE="$HOME/.coctohug/mnc.txt"
MNC_ENC_FILE="$HOME/.coctohug/mnc.ek"
if [ -d "$CCH_DIR" ]; then
  ### Take action if $CCH_DIR exists ###
  if [ -e "$MNC_RAW_FILE" ]
  then
    echo "$MNC_RAW_FILE is right there"

    # check the mnc file should contain something
    minimumsize=80
    actualsize=$(wc -c <"$MNC_RAW_FILE")
    if [ $actualsize -ge $minimumsize ]; then
        echo "$MNC_RAW_FILE has something"
    else
        echo "$MNC_RAW_FILE does not contain the 24 words"
        echo "Please put your 24 words into file $MNC_RAW_FILE and then run cchpass again"
        exit 1
    fi
  else
    # check whether mnc file exists or not
    if [ -e "$MNC_ENC_FILE" ]
    then
      echo "$MNC_ENC_FILE is right there"
    else
      # create an empty file when it does not exist
      touch '' > "$MNC_RAW_FILE"
      echo "Please put your 24 words into file $MNC_RAW_FILE and then run cchpass again"
      exit 1
    fi
  fi
else
  # create empty folder and file when it does not exist
  mkdir "$CCH_DIR"
  touch '' > "$MNC_RAW_FILE"
  echo "Please put your 24 words into file $MNC_RAW_FILE and then run cchpass again"
  exit 1
fi

# get the userid of the key to encrypt 
GPG_CCH_USERID=`gpg --list-keys coctohug | grep "[A-Z0-9]\{10,\}"`
if [ ${#GPG_CCH_USERID} -ge 10 ]; then
    echo "find existing coctohug gpg key and will use it"
else
    echo "creating a new coctohug gpg key for you"
    gpg  --quick-generate-key coctohug

    echo "using previous created gpg key"
    GPG_CCH_USERID=`gpg --list-keys coctohug | grep "[A-Z0-9]\{10,\}"`
fi


if [ -e "$MNC_ENC_FILE" ]
then
    echo "$MNC_RAW_FILE is right there"
else
    # encrypt the file
    gpg --recipient $GPG_CCH_USERID --output "$MNC_ENC_FILE" --encrypt "$MNC_RAW_FILE"
fi


# decrypt the file and copy them to .coctohug-* files
gpg --output "$MNC_RAW_FILE" --decrypt "$MNC_ENC_FILE"

# call delete_mnemonic.sh in background to delete the keys in 5 minutes
nohup ./delete_mnemonic.sh &

# iterate all cocthug folders and cp mnt file to them
# for d in "$HOME"/.coctohug-*/ ; do
#     cp "$MNC_RAW_FILE" "$d"
#     echo "copied to $d"
# done

# rm -f "$MNC_RAW_FILE"
# echo "$MNC_RAW_FILE has been removed"

echo "all keys has been copied to coctohug hands and will be removed in 5 minutes automatically"
echo "****** now you may press Enter to work on other stuff... ******"

