# http://www.catonmat.net/download/perl1line.txt

# Print the total number of fields (words) on each line followed by the line
perl -alne 'print scalar @F, " $_"'

# Print the total number of fields that match a pattern
perl -alne 'map { /regex/ && $t++ } @F; END { print $t }'
perl -alne '$t += /regex/ for @F; END { print $t }'
perl -alne '$t += grep /regex/, @F; END { print $t

# Print lines that match regex AAA followed by regex BBB followed by CCC
perl -ne '/AAA.*BBB.*CCC/ && print'

# Print all unique lines
perl -ne 'print unless $a{$_}++'

# Activate paragraph mode (-0 record separator)
# print type.* until '\n\n' is found (with /s)
perl  -000ne 'print if /(^type.*)/s '  file
