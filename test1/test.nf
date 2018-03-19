#!/usr/bin/env nextflow

/*
 * Copyright (c) 2018, Centre for Genomic Regulation (CRG) and the authors.
 *
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

// Pipeline version
version = '1.0'

/*
 * Input parameters: read pairs
 * by using the command line options. Params are stored in the params.config file
 */

params.help            = false

log.info "BIOCORE@CRG - N F TESTPIPE  ~  version ${version}"
log.info "========================================"
log.info "reads                 		: ${params.reads}"
log.info "\n"


if (params.help) {
    log.info 'This is the Biocore\'s NF test pipeline'
    log.info 'Enjoy!'
    log.info '\n'
    exit 1
}


outputfolder    = "ouptut_1"


Channel
    .fromPath( params.reads )                                             
    .ifEmpty { error "Cannot find any reads matching: ${params.reads}" }
    .set {reads_for_fastqc} 



/*
 * Step 0. Run FastQC on raw data
*/
process fastqc {
	tag { read }

    input:
    file(read) from reads_for_fastqc

     output:
   	 file("*_fastqc.*") into raw_fastqc_files

     script:

    """
		fastqc ${read} 
    """
}



