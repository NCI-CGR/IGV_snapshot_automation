# IGV snapshot automation 
## Description
This snakemake pipeline is for automatically creating IGV snapshots of multiple samples. The final output is a pdf file including all the snapshots for all samples. The pipeline may be run on an HPC or in a local environment. 

## Dependencies
* [Snakemake](https://snakemake.readthedocs.io/en/stable/)
* [IGV Snapshot Automator](https://github.com/stevekm/IGV-snapshot-automator) : Check "Software Requirements"
* [ImageMagick](https://imagemagick.org/)

## User's guide
### I. Input requirements
* Edited config.yaml in directory: config/
* Bam files: {sample-ID}*.bam, multiple files allowed for each sample
* Bed files: {sample-ID}.bed, only one file allowed for each sample
* Reference genome file
### II. Bed file format
Three headerless columns: chromosome, start position, end position
Example:
```bash
HPV31_Ref 4319 4339
HPV52_Ref 2161 2181
```
### III. Editing the config.yaml
Basic parameters:
* path_to_software: Path to the IGV-snapshot-automator installed directory
* reference: Path to the reference genome file
* bam_directory: Path to the bam files
* bed_direcotry: Path to the bed files

Optional parameters:
* output_directory: Output directory. Default: output/ in workding directory
* ht: Height of the snapshots. Default: 100
* tile: Layout of snapshots in final pdf. Default: 1x4
* mem: Memory for running IGV-snapshot-automator. Default: 16g
### IV. Output
```bash
|--- user/defined/output_dir/
   |--- IGV_Snapshots/
      |--- pdf/               # Final pdf file
      |--- merge_true/        # The merged snapshot for each sample
      |--- {sample}/          # All snapshots for each sample
```
### V. To run on an HPC
* Access graphic connection to the HPC system using ssh -Y, or using tools like NoMachine (NX).
* Edit config/config.yaml and save
* To run on an HPC using Slurm Jjb scheduler like NIH Biowulf: run sbatch.sh; look in log directory for logs for each rule.
* To run on an HPC using SGE job scheduler like Cgems: run qsub.sh; look in log directory for logs for each rule.
