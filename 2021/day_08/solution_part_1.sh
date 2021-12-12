cut -d\| -f 2 input_part_1.txt | unjoin --delim ' ' | chomp | perl -n -e '$sum += 1 if length == 4 or length == 5 or length == 3 or length == 8; END { print "Sum was $sum\n";}'
