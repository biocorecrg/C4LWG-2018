#!/usr/bin/env nextflow

/* 
 * HERE YOU HAVE THE COMMMENTS
 * NextFlow example from their website 
 */
 
params.inputFile = "$baseDir/../testdata/test.fa"	// this can be overridden by using --inputFile OTHERFILENAME

sequencesFile = file(params.inputFile)				// the "file method" returns a file system object given a file path string  

if( !sequencesFile.exists() ) exit 1, "Missing genome file: ${genome_file}" // check if the file exists


/*
 * split a fasta file in multiple files
 */
 
process splitSequences {

    input:
    file 'input.fa' from sequencesFile // nextflow creates a link to the original file called "input.fa" in a folder
 
    output:
    file ('seq_*') into records    // send output files to a new channel (in this case is a collection)
 
 	// simple command

    """
    awk '/^>/{f="seq_"++d} {print > f}' < input.fa
    """ 
}


/*
 * Simple reverse the sequences
 */
 
process reverse {
  	tag { seq }  					// during the execution prints the indicated variable for follow-up

 	publishDir "output"
 	
    input:
    file seq from records.flatten()  // flatten operator emits each item separately as a new channel

	output:
    file "*.rev" into reverted_seqs
 
    """
    cat $seq | awk '{if (\$1~">") {print \$0} else system("echo " \$0 " |rev")}' > $seq".rev"
    """
}


