# this is basically just using the matrix printout to compute things from on the command line
$ perl solution_part_1.pl input_part_1.txt   | chomp | unjoin --delim ' ' | grep -v ^0 | grep -v ^1 | wc -l
