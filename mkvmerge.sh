# options select only french audio from vid mkv
# ie, -D no video, -T no tracks tags, -B no buttons, -M no attachements
-a fr,!ru -D -T -B -M --no-chapters --no-global-tags

# set track language to $lang (fre, eng, rus,..)
--language TID:$lang

# set track name
--track-name '1:French (AC3 5.1)'

# audio delay
-y TID:d[,o[/p]] # o/p can be fps
-y 1:1500 # add 1500 delay

#others
--title