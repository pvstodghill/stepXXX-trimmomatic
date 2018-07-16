# Set `USE_PHRED64` if not PHRED33. Check the output of FastQC, and if
# it "Sanger / Illumina 1.8" or greater, then it should be PHRED33
# (the default). Otherwise, consult whomever ran the Illumina
# base-calling pipeline.

#USE_PHRED64=1

# The function `process_single_end` will process a file as single end
# reads. E.g.,
#
#     process_single_end input.fq.gz \
# 		   ILLUMINACLIP:adapters/TruSeq3-SE.fa:2:30:10 \
# 		   LEADING:3 \
# 		   TRAILING:3 \
# 		   SLIDINGWINDOW:4:15 \
# 		   MINLEN:36

# The function `process_paired_end` will process a file as paired end
# reads. E.g.,
#
#     process_paired_end input1.fq.gz input2.fq.gz \
# 		   ILLUMINACLIP:adapters/NexteraPE-PE.fa:2:30:10 \
# 		   LEADING:3 TRAILING:3 \
# 		   SLIDINGWINDOW:4:15 \
# 		   MINLEN:36
