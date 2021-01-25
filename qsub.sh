qsub -cwd \
     -V \
     -q all.q \
     -N IGV_automation \ 
     -o log/ \
     -e log/ \
     -S /bin/bash snakemake_sge.batch
