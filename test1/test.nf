#!/usr/bin/env nextflow

/*
 * Copyright (c) 2018, Centre for Genomic Regulation (CRG) and the authors.
 * These are comments :)
 *
 */

/* 
 * NextFlow test pipe
 *
 * @authors
 * Luca Cozzuto <lucacozzuto@gmail.com>
 *
 * 
 */

// Pipeline version. Also these are comments!
version = '1.0'

/*
 * Input parameters: read pairs
 * by using the command line options. Params are stored in the params.config file
 */

// this prevents a warning of undefined parameter
params.help            = false

// this prints the input parameters
log.info "BIOCORE@CRG - N F TESTPIPE  ~  version ${version}"
log.info "============================================="
log.info "reads                 		: ${params.reads}"
log.info "\n"

// this prints the help in case you use --help parameter in the command line and it stops the pipeline
if (params.help) {
    log.info 'This is the Biocore\'s NF test pipeline'
    log.info 'Enjoy!'
    log.info '\n'
    exit 1
}

/*
 * Defining the output folders.
 */
fastqcOutputFolder    = "ouptut_1_fastqc"
multiqcOutputFolder   = "ouptut_1_multiQC"


/* Reading the file list and creating a "Channel": a queue that connects different channels.
 * The queue is consumed by channels, so you cannot re-use a channel for different processes. 
 * If you need the same data for different processes you need to make more channels.
 */
 
Channel
    .fromPath( params.reads )  											 // read the files indicated by the wildcard                            
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" } // if empty, complains
    .set {reads_for_fastqc} 											 // make the channel "reads_for_fastqc"


/*
 * Process 1. Run FastQC on raw data. A process is the element for executing scripts / programs etc.
 */
process fastqc {
    publishDir fastqcOutputFolder  			// where (and whether) to publish the results
    
	tag { read }  							// during the execution prints the indicated variable for follow-up

    input:
    file(read) from reads_for_fastqc  		// it defines the input of the process. It sets values from a channel

    output:										// It defines the output of the process (i.e. files) and send to a new channel (raw_fastqc_files)
   	file("*_fastqc.*") into raw_fastqc_files

    script:									// here you have the execution of the script / program. 
    """
		fastqc ${read} 
    """
}

/*
 * Process 2. Run multiQC on fastQC results
 */
process multiQC {
	    publishDir multiqcOutputFolder, mode: 'copy' 	// this time do not link but copy the output file

	    input:
	    file '*' from raw_fastqc_files.collect()		// collect the fastqc results from different executions in a single place

	    output:
 	    file("multiqc_report.html") 					// do not send the results to any channel
	
	    script:
 	    """
	    multiqc .
	    """
}


