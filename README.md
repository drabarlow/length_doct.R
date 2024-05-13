# length_doct.R

This is my `R` script for making the scaffold lengths input file for `consensify` (see https://github.com/jlapaijmans/Consensify) and -rf file for `angsd`

I make the input file using `awk` like this:

```
cat reference.fasta | awk '{print $1}' | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > scaffold_lengths.txt 
```

Then call script like this:

```
Rscript length_doct.R scaffold_lengths.txt
```

The following files are generated

```
Your -rf file for use in angsd is: list_over_1mb.txt

Your lengths file file for use in consensify_c is: lengths_over_1mb.txt
```

I hope you find my code useful,

Axel
