---
layout: post
category : lessons
title: "Submitting Transcriptomes to NCBI"
tagline: "demystifying a confusing process" 
tags : [bioinformatics]
---
{% include JB/setup %}

##TSA Submissions

TSA stands for Transcription Shotgun Assembly. These are the assembled products of short reads typical of Illumina runs.
It works OK, but there are still many issues and quirks associated with sequence assembly, so milage may vary when it comes to TSA quality.

This is an attempt to document my experience when submitting a TSA dataset to NCBI. Hopefully someone reading this will
avoid the problems I painfully slogged through on my own.

Not many papers I've been reading actually do this step. They submit their raw data and walk away. Unfortunately
nobody in their right mind will ever use those reads again. Assembled sequences are much more useful, but the process for 
doing this is overly painful.

##Correct Headers

Say you have two files: transcriptome.fasta and transcriptome.gff. The first looks something like this:

    >comp1_c0_seq1 len=349 path=[1:0-348]
    CGCCCAGGGAACGTCCCAGCAGAGCCAAATCCCATCAATGGAGGATTGTTTCATGAGAGG
    GTTCGGGGCACCTTTGGTTAACACTGACGTGACGGGAAACCGGAACGGAGAGTGGGAAAA
    GTGGTGGCGGAGAATAGTAAAGCTGAGGGGGAAACAGTACACTGTTCCGTTCGGACCAAT
    TGGGCGTCGATGGGTTTCTCTCTTGGCAGAAGAAATCCAAAATGTGGTGGATGGAAGACA
    GGGTTCGGAACGAATCTTCGTGCTTTGCTCCACAGGTCTCCAAAGAGTAAGGATGATTTC
    CTCGTGGGCTGACATCCAGCGATTGCTGAATAGAAGGATGGATATGTGG
    >comp3_c0_seq1 len=327 path=[1:0-97 99:98-139 141:140-163 785:164-189 191:190-326]
    TGAAGGTCAAGAATTTGATCATTGATGAGTTTCTTTCAAATGTGCTAAGTGCCTTCCCCT
    TTCGGTGGTACTGAGTTGTGGAGATCACTTCTGAACGAAATCCTATCACAAGGAAAGAAA
    ATAAAATGTATCGACATGTAGGAACGGAAGGAGGTGGCCAAAAACGCACTCAACATCTCA
    TCAGGCGGTGAAGAATCGACTCACTGGGGGGCAACTCTTGAAGGGGAAGAAAGGAACTTG
    ATGTTCTCACGGTGAAAATAGGAAGAAAAGTTGAAAAAAATGACGAAGGGTCGAGGGTGG
    TGGCAGCCACTTTTTACTCGGTCATAG
    >comp3_c0_seq2 len=314 path=[1:0-97 733:98-126 141:127-150 165:151-176 191:177-313]
    TGAAGGTCAAGAATTTGATCATTGATGAGTTTCTTTCAAATGTGCTAAGTGCCTTCCCCT
    TTCGGTGGTACTGAGTTGTGGAGATCACTTCTGAACGAGGAAAGAAAATGAACTGTGTCG
    ATAAGTGGGAACGGAAGGAGGTGGCCAAAAATGCACTCAACATCTCATCAGACGGACAAG
    AATCGACTCACTGGGGGGCAACTCTTGAAGGGGAAGAAAGGAACTTGATGTTCTCACGGT
    GAAAATAGGAAGAAAAGTTGAAAAAAATGACGAAGGGTCGAGGGTGGTGGCAGCCACTTT
    TTACTCGGTCATAG

It's got spaces in the identifiers, and things are not formatted properly for NCBI's tastes. Unfortunately, it is up to you, 
the bioinformatics guy/gal, to fix this.

##Transvestigator

Luckily, there is a tool called [Transvestigator](https://github.com/genomeannotation/transvestigator) written by the good folks at 
the USDA which can help you out. It tries to correct a number of errors associated with just-assembled sequences.

Go to the link and follow the instructions. When you are done, your new FASTA file should look something like this:

    >comp17715_c0_seq1
    AACTCTAAGTACGTCGTCCAAAACCGAATCTCCTACAACTTCTAAGCAAAGTGTTAAGTTGCAAAAGTCCTCAACCCTAGTGCCGCCGAAACTCAAAAATCCCGAACTCAGTAATCCAGAGGGTGAATTCATAGAGTTTGACATCCCCGCTCCAAAACCAATTACCAAGAAACTTGATACGAAGCAACTCTGTACGTCAAACAACAAAACTACTAAACGATCTGTGGAAAAGAAATCCCAAAACAAATTCAATAGTTTGATCAACCTGAAGAGCGATTCTCCGAAAGATGCGACTTCTGGATACAGTCTAAAAACTGAGAAAAGCGTTTCTGCAGTGTCTTCTATCGTAAGCACTCTGGAGAAGGAAAAGAGGAATGTATCAGTGACCGATGCGAAAATGACTGGTGAAGACGAGGAAAATATAAAGAAACTTCAGGAAAGATCTCCCAGTACTGTGAATGCATTGCCTGTGAAGGGTGAAGAAACGATTCGGATTATGGTAGATACAGTCACACGATCACCGACGTCTCGACTCTCAAAAGCTAAATTGCGAGCACTCCAAGTTGTGAAGAAGAATGGTGGGATTACTCGAGAAAATCCCAGAGGAGTGACGAGGGAAGAGGTGGTGAACCGCGGATTGAAGAGGCAGTTCCAGGAAGAGGAAGATGATGCTAAAGAAGAGCTGAAAAACAGCGTCCTGTCTGCTCGGTTCCTCGAATTGATGAATATGGAATCAAAACATTCAGACCTGTTGGAGGCGTTTGATCGTCAGGTGGAGGACGCGTACTACGAGAAGTTGGAAAAGAAAGAACAGATGGAAGAGAAGATGATGAGCATTTACAAACTTGAATGTAAAGCAGTTCGATGCATGAAGTGCCGCTACACTTGGTTTTCTGCTTCGGACGCGTGCAAAGCTGACAGACACCCGCTCAAAGTGGTGGATGCCTTGAAGCGGTTTTTCAAATGCAATGACTGCGGGAACAGGACCGTCAGCCTCAGCATACTCCCTCTCCTGCCTTGCAAGAAATGTTCTTCCACGAGTTGGGTCAAAACAGCGATGATGAAGGAAAGAATCGTGAAAAACAGCCACGAACTCAGCATCAGAGGAGGGGAACAGAAGTATATCAACTCGGTTGCCACCAACACCAGCATCAATCTACTAGTGCCGGAATAAGGTTCGTTTTCTATTACAAAGATTGTATTGTTTGTATTTTTATATCCAAG
    >comp27182_c0_seq1
    CTCTTAGATGATACGTGGTGCGTTCAATGAGTTTCTTACGTAGGTAGTTAAAATCGTATACAACAAACTATTCAGGTTCGTGTGTTAGTAATACGACCGTTCATCGTTTGGTCAGGACCCCAATATGGAACCTTTTACAGTTTTGACCGCCAGTTTCATCGGCATCATCGTATTGGCGTTCTTGTTCGCCTTCAAGAGGAATAAATACTGGGCAGATCGCGGAATCCACCAATACAAACCCCTACCATTCATGGGAGACATGCTTCCAGTCATTCTTCGACAGAAAACTCTCGGAGAACTTTTGATGGAAATGTGCAGAGCTTTGCCCAACGAAAAGGTAATCGGATTTTATTTCTTCATGAAACCGTCATTGTTGGTGAACGACATTGAATTGGTTGAGAAAGTGTTCATCAAAGACTTCCCCCATTTCTCTGATCGCGGCCCACCAGCCGAATGTGGAAACAGAAACTATGCATATGAACCTTTTCAACACCGGTGGAAATCTCTGGCGAGCTGTGCGTAATCGATTTTCACCCATGTTCACAACGGGAAAGCTACGGTTCATGTTCCCTCAGGTTTCAGGAATCGGAGAGGGTTTCATGGACCTGTTGAATACCAAGAACGAAAAAGTCGATATGGTGGATTATTTTGGGAAATTCGCAATGGAAGTCATTGGAGCCACTGCGTTCGGATTAGAGGGACGAGCTATGGAAGAAAACAGTGAATTCAGGGAAAAAGGAAAGAAGATATTTGAGCCTTCATTTTCAAATTTTATGAGGTTTACTTTGGGACCATCACTGTTGAGGGCATTAGGAGTACCACCAACTCCTAAAGAAATGTTGCAGTATTTTGGTCCTGCTGTAAAGAATGCGTTGAAATACAGAAGGGAAAATGGAGTTATAAGACATGATTTCATTCAACATATGGTCACTTTGCAACAGAAAGGGTCTATCGAGGTGGACAAGGATGATGTGTCAGACGAAATATTAATGATGGATCATGTTCCAGAAATGAAAGTCGAGATGTCCGATGAGTTGATGATTGGGCAGTCGATGGGGTTCATGGTTGCTGGATTTGATGCCACGGCGTTGTCCATGGGTTGGCTCTGCTACGAGCTAGCAAGGCACCCTGATATCCAGTCCAAAGCCAGACAAGAAGTCAAGGAAGTGATGGAGAAACACGGCAACCGCCTGGACTACGATACTGTCAGAGAGATGAAGTTCCTCAGCTACTGTTTGAAGGAAAACGGCAGACTCCACTCGGCCTTGGACTCCAACTTCCGGATGGTCACCAAGCCTTACAAAGTTCCTGACACATCTGCTGTTCTCGAACGCGGCGCCTTCGTTTACATTCCGATCCTCAGCGTTCACATGGATCCCAAGTTCTACCCGGAACCGGAAAGGTTCCTTCCGGAAAGATGGGGACCGGAAAATGACAGGCCGAGCTGCACGTACCTCCCATTCGGTACAGGACCACGCATGTGCATCGCTATGAGATTTGCCAATATGGAAATGATGTGTGCCATATCTAAACTTCTAATGAACTTTGAAGTTAGTCTTCACCCCTCAGTGCGCCTGCCTCCTCGGATTGAACCGTTCTCATTTTTCACGTACCCTCGAGAAAAAATCTACTTTAACCTAAAAAAAATCAGCCCTTGAAGTTCTATAAGAATACATCACTTGTGCTGTTTTTGTTTTTGTACGTTATCAATAGGTATTGACTTTTCTCGACGCTGTCTTTCGCTTCTTACATTTAATTCTTTATCTAATTGTTCTCTCATTTCATCTAAAATCCACCCGCTTTTCAGTGTTTGTAGTGAGTAAAACACATTCACTGACTATAGTGTCCATTGCGTTAACTACATGTCCTGATTAGGTCAATGTGCATACCCACCTGGTTACTCCTATAAACAAAGTTATATGCGTTGAATCATACTATTGCACTAATCAAACATTTAAAAAGTTAATTTCATCTAGGACGAATTTGCTTGTGAGTTAAGAAGAAACCATTTCCTACCTCTTTTGTGCGGTTAAACAATGTTTAGCGAGTTTTGACTGACGTGATTCAATTTCTTTTGAATTGTTTTCCTTGTATGCTCACGTTTTTGGTGTTCATTCGTGCTCAGATCTCCAGTACATGTTACTTCTGTATCCTTTGTCCTTTGTCCTGCTAGTGACGTTGGGCTTCTGTAGAGGGTCTCTTCTATTTTCTCTCTAGATTCTCTT

Yes, the sequences are not as prettily formatted, but NCBI doesn't care, and neither do I.

##Are we done?

No, of course not! Much too easy. There are a myriad of other errors that could crop up during the submission process. You need to run [tbl2asn](http://www.ncbi.nlm.nih.gov/genbank/tbl2asn2)
in order to get the sqn file required to submit.

To save the reader some trouble, here is the command I used. The moltype and tech source qualifiers are REQUIRED for submission, as is a [template.sbt](http://www.ncbi.nlm.nih.gov/WebSub/template.cgi). Replace the organism tag with whatever yours is. This will be appended to the FASTA header for each sequence.

    tbl2asn -t template.sbt -p . -a s -j "[organism=Lygus hesperus] [moltype=transcribed_RNA] [tech=TSA]" -V v

Make sure you run this command in the directory with your transvestigator modified files:

    transcriptome.new.fsa
    transcriptome.new.gff
    template.sbt

##Dealing with Errors

tbl2asn produces three files:

    -rw-rw-r-- 1 admin admin        72 Aug 27 16:30 errorsummary.val
    -rw-rw-r-- 1 admin admin 203029729 Aug 27 16:29 transcriptome.new.sqn
    -rw-rw-r-- 1 admin admin   2727327 Aug 27 16:30 transcriptome.new.val

Now we need to investigate transcriptome.new.val for errors:

    cat transcriptome.new.val|grep ERROR

This will print a list of errors (unless you have no errors):

    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp4071_c0_seq1:<1-314] [lcl|comp4071_c0_seq1: raw, rna len= 314] -> [lcl|comp4071_c0_seq1_1]
    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp14123_c0_seq2:<1-449] [lcl|comp14123_c0_seq2: raw, rna len= 449] -> [lcl|comp14123_c0_seq2_1]
    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp17300_c0_seq1:<1-568] [lcl|comp17300_c0_seq1: raw, rna len= 568] -> [lcl|comp17300_c0_seq1_1]
    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp29070_c0_seq1:<1-605] [lcl|comp29070_c0_seq1: raw, rna len= 605] -> [lcl|comp29070_c0_seq1_1]
    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp17686_c0_seq1:<1-1073] [lcl|comp17686_c0_seq1: raw, rna len= 1073] -> [lcl|comp17686_c0_seq1_1]
    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp5271_c0_seq1:<1-398] [lcl|comp5271_c0_seq1: raw, rna len= 398] -> [lcl|comp5271_c0_seq1_1]
    ERROR: valid [SEQ_FEAT.NoStop] Missing stop codon FEATURE: CDS: hypothetical protein [lcl|comp24041_c0_seq2:<1-905] [lcl|comp24041_c0_seq2: raw, rna len= 905] -> [lcl|comp24041_c0_seq2_1]

We must correct these errors before NCBI will take our data. 

In my case there were 53 errors like these, out of over 20,000 sequences in the transcriptome.
At less than 0.1% of overall expression, these are not worth my time. I chose to simply
remove them.

You can extract the responsible sequence with some awk-fu:

    cat transcriptome.new.val|grep ERROR|awk -F"|" '{print $2}'|awk -F":" '{print $1}' > transcriptome.blacklist

This creates a file, transcriptome.blacklist, listing all the sequences we want to exclude from submission.

Now re-run transvestigator including this blacklist file, and recreate the .sqn file with tbl2asn

Now it is time for submission to NCBI

##Submission

Follow NCBI's [TSA Submission Guide](http://www.ncbi.nlm.nih.gov/genbank/tsaguide) for instructions on how to get to the point where you upload files.
You will need to create a BioProject and BioSamples corresponding to each sample included in the assembly..

Finally you will upload your (hopefully) error free .sqn file, and perhaps the bioinformatics gods will accept your offering (but they probably won't). If you get more errors, well, you'll just have to investigate them.

Iterate on the above procedures until the errors go away, then go home and cry yourself to sleep.
