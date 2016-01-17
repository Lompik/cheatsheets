# handling spaces in names 
# http://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
# http://www.dwheeler.com/essays/filenames-in-shell.html
# avoid processing ls outputs 

# best 
find .  -iname "*.mp3" -print0 | while read -d $'\0' file
do
  mplayer "$file"
done

beet ls --path raintime | while read  var 
do 
  if [ -e "$var" ]
  then
    echo "yes"
  else
    echo "no"
  fi 
done
