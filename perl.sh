# http://www.catonmat.net/download/perl1line.txt

# s/...// applies to $_ (current line if -n flag)

# NOTE use `r` flag to not modify a variable AND return the value
echo -n abc | perl -ne 's/a/b/r ; print'  # prints abc
echo -n abc | perl -ne 'print $_ =~ s/a/b/r'  # prints bbc, without /r => prints 1 as operator `=~` returns bool

# Print the total number of fields (words) on each line followed by the line
perl -alne 'print scalar @F, " $_"'

# Print the total number of fields that match a pattern
perl -alne 'map { /regex/ && $t++ } @F; END { print $t }'
perl -alne '$t += /regex/ for @F; END { print $t }'

# Print lines that match regex AAA followed by regex BBB followed by CCC
perl -ne '/AAA.*BBB.*CCC/ && print'

# Print all unique lines
perl -ne 'print unless $a{$_}++'

# Activate paragraph mode (-0 record separator)
# print type.* until '\n\n' is found (with /s)
perl  -000ne 'print if /(^type.*)/s '  file
