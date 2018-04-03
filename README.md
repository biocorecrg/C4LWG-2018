# ![C4LWG-2018](https://github.com/CRG-CNAG/BioCoreMiscOpen/blob/master/logo/biocore-logo_small.png) C4LWG-2018
Hands-on tutorial on Nextflow and Containers (Docker and Singularity). Paris 2018.
For this tutorial we need to install Nextflow (https://www.nextflow.io/), Singularity (http://singularity.lbl.gov/) and Docker (https://www.docker.com/).

## Virtual appliance

For sake of simplicity we provide a virtual appliance in [OVA format](https://en.wikipedia.org/wiki/Open_Virtualization_Format). They can be imported in a virtual machine system such as [Virtualbox](https://www.virtualbox.org/) ([video instructions](https://www.youtube.com/watch?v=ZCfRtQ7-bh8)).

It is a Debian Stretch machine from OSBoxes project (ref: https://www.osboxes.org/debian/). Java, Docker, Singularity and Nextflow are already installed.


   * OVA: http://biocore.crg.eu/courses/C4LWG-2018/C4LWG-2018-full.ova
   * OVA md5: http://biocore.crg.eu/courses/C4LWG-2018/C4LWG-2018-full.ova.md5

### Check appliances download

Take care that files downloaded correctly (around 6GB). You can check with MD5 utilites from the terminal

In Linux:

    $ md5sum -c C4LWG-2018-full.ova.md5 
    C4LWG-2018-full.ova: OK
    
In Mac:

    $ md5 C4LWG-2018-full.ova 
    $ cat C4LWG-2018-full.ova.md5
Check both outputs show the same string.

### User login

* User: osboxes
* Password: osboxes.org

If you need to use the root user (e.g. via ```su -l```), it has the same password.

## Manual installation

### Software requirements

- For installing NextFlow we need Java version 1.8. You can check with "java -version". Then just type "curl -s https://get.nextflow.io | bash" for installing a local copy in your current directory. Finally type "./nextflow run hello" for testing. 
- Mac OS X users can consider installing [Homebrew](https://brew.sh) and [Homebrew-Cask](https://caskroom.github.io/).
- Docker (Community Edition): https://www.docker.com/community-edition . Download and install last stable version in your system.
    * Cask users: ```brew cask install docker```
- Singularity:
    * [Linux](https://singularity.lbl.gov/install-linux)
    * [Mac](https://singularity.lbl.gov/install-mac) (Homebrew and Homebrew-Cask are needed)
      * If using Vagrant with Singularity, Vagrant shared folder with the host is ```/vagrant```. That would be the best location to place generated images.


### Container installation

You can retrieve Docker image with all used software by doing:

    docker pull biocorecrg/c4lwg-2018

Alternately, you can always modify and build a Docker image yourself in your computer by doing:

    docker build -t myimagename .

#### Converting Docker image into Singularity image

    singularity build c4lwg-2018.simg docker://biocorecrg/c4lwg-2018


##### Notes

* If you experience problems executing the generated image, e.g., ```ERROR  : No valid /bin/sh in container```, try to change your umask (e. g., ```umask 000```) [Ref](https://github.com/singularityware/singularity/issues/1079)

#### Generating a Singularity image from a Singularity recipe

There are other ways to generate Singularity images from other [recipe approaches](http://singularity.lbl.gov/docs-recipes). As a example, using [Debootstrap](http://singularity.lbl.gov/build-debootstrap) (being root is required in [these cases](http://singularity.lbl.gov/docs-build-container)) 

    singularity build c4lwg-2018.xenial.simg Singularity.xenial


## Nextflow usage


We can reach the first folder **test0**

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
In the **work** folder we have subfolders containing this time a link to the input and the output file.
In **output** folder we have links to the final results. 

Third example where we launch two fastQC analysis and we run multiQC on their result:
***cd test2; ls***
* params.config: with parameters
* nextflow.config: with information about resources needed for each task and the container to be used
* test2.nf 

We can inspect the different files and launch te pipeline.

**nextflow run test2.nf -bg**
We can inspect the results in the different folders. 






