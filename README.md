# ![C4LWG-2018](https://github.com/CRG-CNAG/BioCoreMiscOpen/blob/master/logo/biocore-logo_small.png) C4LWG-2018
Hands-on tutorial on Nextflow and Containers (Docker and Singularity). Paris 2018.
For this tutorial we need to install Nextflow (https://www.nextflow.io/), Singularity (http://singularity.lbl.gov/) and Docker (https://www.docker.com/).

- For installing NextFlow we need Java version 1.8. You can check with "java -version". Then just type "curl -s https://get.nextflow.io | bash" for installing a local copy in your current directory. Finally type "./nextflow run hello" for testing. 

We go in the first folder **test0**

***cd test0; ls***
* test0.nf

We can have a look at the code and launch it:

**nextflow run test0.nf**

Nextflow creates a directory named **work** with different subfolders. Each one contains the input, output and some hidden files:

* .exitcode
* .command.log
* .command.out
* .command.err
* .command.begin
* .command.run
* .command.sh

In this case there is neither input nor output file.

Second example where we read a fasta file, split it in several ones and tests on them.

***cd test1; ls***
* test1.nf

**nextflow run test1.nf**
* 

Third example where we launch two fastQC analysis and we run multiQC on their result:
***cd test2; ls***
* test2.nf

**nextflow run test2.nf**
* 






