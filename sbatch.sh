sbatch --cpus-per-task=2 \
       --mem=4g \
       --time=240:00:00 \
       snakemake_slurm.batch 
