# IGV snapshot automation 
## Description
This snakemake pipeline can be used to automatically create IGV snapshots for multiple samples. The final output is a pdf file containing all the snapshots for all samples.
## Dependencies
* [Snakemake](https://snakemake.readthedocs.io/en/stable/)
* [IGV Snapshot Automator](https://github.com/stevekm/IGV-snapshot-automator) : Check "Software Requirements"
* [ImageMagick](https://imagemagick.org/)
## user's guide
### I. Input requirements
* Edited config.yaml in directory: config/
* bam files: {sample-ID}*.bam, multiple files allowed for each sample
* bed files: {sample-ID}.bed, only one file allowed for each sample
* reference fasta file
### II Bed file format
Three headerless columns: chromosome, start position, end position
