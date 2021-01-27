# IGV snapshot automation 
## Description
This snakemake pipeline is for automatically creating IGV snapshots of multiple samples. The final output is a pdf file including all the snapshots for all samples. The pipeline may be run on an HPC or in a local environment. 

## Dependencies
* [Snakemake](https://snakemake.readthedocs.io/en/stable/)
* [IGV Snapshot Automator](https://github.com/stevekm/IGV-snapshot-automator) : Check "Software Requirements"
* [ImageMagick](https://imagemagick.org/)

## User's guide
### I. Input requirements
* Edited config/config.yaml
* Bam files: {sample}*.bam, multiple files allowed for each sample or group. 
* Bed files: {sample}.bed, only one file allowed for each sample or group
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
[Example](https://github.com/NCI-CGR/IGV_snapshot_automation/tree/main/output/IGV_Snapshots)
```bash
|--- user/defined/output_dir/
   |--- IGV_Snapshots/
      |--- pdf/               # Final pdf file
      |--- merge_true/        # The merged snapshot of each sample or group
      |--- {sample}/          # All snapshots of each sample or group
```
### V. To run on an HPC
* Check with system administrator to make sure the xvfb-run command is available universally across the cluster.
* Edit config/config.yaml and save
* To run on an HPC using Slurm job scheduler like NIH Biowulf: run sbatch.sh; look in log directory for logs for each rule.
* To run on an HPC using SGE job scheduler like Cgems: run qsub.sh; look in log directory for logs for each rule.
