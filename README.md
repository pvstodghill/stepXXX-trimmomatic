# stepXXX-fixme

Module to run [Trimmomatic](www.usadellab.org/cms/?page=trimmomatic) a
package for trimming Illumina-specific adapters from the 3' end of
reads in FASTQ files. It also handles adapters at the 5' end of
paired-end reads. It also filters on length and quality scores.

Here's the citation to use,


> Bolger, A. M., Lohse, M., & Usadel, B. (2014). Trimmomatic: A
> flexible trimmer for Illumina Sequence Data. Bioinformatics, btu170.

The directory `adapters` is a copy from the Trimmomatic's
source. These files contain the adapter sequences that can be used as
targets for trimming.

To use this module, first create a configuration file from the
template.

    $ cp config-template.bash config.bash

Then update `config.bash` according to your needs.

Finally, run the module

    $ ./doit.bash

By default, this module uses the [Docker](https://www.docker.com/) image,

<https://hub.docker.com/r/pvstodghill/fixme/>

To use a use a native executables, uncomment the "HOWTO" assignment in
the configuration file.

By default, this modules uses all available threads. To use a
different thread count, uncomment and update the "THREADS=..."
assignment in the configuration file.

------------------------------------------------------------------------

## Issues

- This module should be parallelized using GNU `parallel`.
