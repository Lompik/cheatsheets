# kill from program list
ps aux | percol | awk '{ print $2 }' | xargs kill

# Copy history element to clipboard 
cat .zsh_history| percol | xsel -ob

# Select files/folder to delete from sorted list by size with spaces  
# find . -maxdepth 1 -type d -exec du -sh {}   \; | sort -h > info.txt
echo $(percol info.txt | cut -f 2 | sed 's/\ /\\\ /g')

