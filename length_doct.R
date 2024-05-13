# R script for making the scaffold lengths input file for consensify and -rf file for angsd

# You make the input file like this:
#cat reference.fasta | awk '{print $1}' | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' > scaffold_lengths.txt 

# call script like this:
# Rscript length_doct.R scaffold_lengths.txt
args = commandArgs(trailingOnly=TRUE)

# read data
my_lengths <- read.table(args)

# filter scaffold lengths > 1Mb, output list to file for use in angsd (-rf)
over_1mb <- my_lengths[my_lengths$V2 > 999999,]
write.table(over_1mb$V1, file="list_over_1mb.txt", row.names=FALSE, col.names=FALSE, quote=FALSE)

# add column names, add start position column (always 1), reorder, and output for consensify
colnames(over_1mb) <- c("name", "end")
over_1mb$start <- rep.int(1, length(over_1mb$name))
over_1mb <- over_1mb[, c(1,3,2)]
write.table(over_1mb, file="lengths_over_1mb.txt", row.names=FALSE, col.names=TRUE, quote=FALSE, sep="\t")

# report complete
cat("\nProcessing of file complete\n")
cat("\nYour -rf file for use in angsd is: list_over_1mb.txt\n")
cat("\nYour lengths file file for use in consensify_c is: lengths_over_1mb.txt\n\n")

