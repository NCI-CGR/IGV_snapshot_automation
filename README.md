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
* Bed files: {sampleID}.bed, Only one file allowed for each sample or group.[Example](https://github.com/NCI-CGR/IGV_snapshot_automation/tree/main/example/data/bed) Using a universal bed file for all samples or groups is also allowed.
* Bam files with indexes: {sampleID}*.bam, {sampleID}*.bam.bai, multiple files allowed for each sample or group. The filename(s) should start with the same string as the bed file filename of the same sample or group if NOT using a universal bed file. [Example](https://github.com/NCI-CGR/IGV_snapshot_automation/tree/main/example/data/bam)
* Reference genome fasta file
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
* universal_bed: If using a universal bed file for all samples or groups, 'yes' or 'no'

Optional parameters:
* output_directory: Output directory. Default: output/ in workding directory
* ht: Height of the snapshots. Default: 100
* tile: Layout of snapshots in final pdf. Default: 1x4
* mem: Memory for running IGV-snapshot-automator. Default: 16g

### IV. Output

[Example](https://github.com/NCI-CGR/IGV_snapshot_automation/tree/main/example/output)
```bash
|--- user/defined/output_dir/
   |--- IGV_Snapshots/
      |--- pdf/               # Final pdf file
      |--- merge/             # Intermediate files
      |--- merge_true/        # The merged snapshot of each sample or group
      |--- {sampleID}/          # All snapshots of each sample or group
```

### V. To run on an HPC
* Check with system administrator to make sure the xvfb-run command is available universally across the cluster.
* Edit config/config.yaml and save
* To run on an HPC using Slurm job scheduler like NIH Biowulf: run sbatch.sh; look in log directory for logs for each rule.
* To run on an HPC using SGE job scheduler like Cgems: run qsub.sh; look in log directory for logs for each rule.
