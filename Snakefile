# vim: ft=python
import sys
import os
import glob
import itertools

shell.prefix("set -eo pipefail; ")
configfile:"config/config.yaml"
localrules: all

# Software installation directory
dire = config["path_to_software"]

# File directories 
bam_dir = config["bam_directory"]
bed_dir = config["bed_direcotry"]

# Sample ID
def parse_sampleID(fname):
    return fname.split(bed_dir)[-1].split('.')[0].split('_')[0]
 
 # Bam files
bam = sorted(glob.glob(bam_dir + '*.bam'), key=parse_sampleID)
 # Bed files
bed = sorted(glob.glob(bed_dir + '*.bed'),key=parse_sampleID)

d = {}
for key, value in itertools.groupby(bed, parse_sampleID):
    d[key] = list(value)

# Output directory
out_dir = config.get("output_directory", "output/")

rule all:
   input:
         out_dir + "IGV_Snapshots/pdf/all_by_sample.pdf"

rule igv_snapshot:
    input: 
          bam = bam,  
          bed = bed_dir + "{sample}.bed"
    output:
          out_dir + "IGV_Snapshots/merge/{sample}.png"
    params:
          ref = config["reference"],
          ht = config.get("ht","100"),
          mem = config.get("mem","16000")
    threads: 4
    shell:
          """
          python {dire}make_IGV_snapshots.py -mem {params.mem} -ht {params.ht} -bin {dire}bin/IGV_2.3.81/igv.jar -o {out_dir}IGV_Snapshots/{wildcards.sample} {bam_dir}{wildcards.sample}*.bam -r {input.bed} -g {params.ref} -s -suffix {wildcards.sample} 2> log/{wildcards.sample}_igv.err
          mkdir -p {out_dir}IGV_Snapshots/merge
          if ls {out_dir}IGV_Snapshots/{wildcards.sample}/*.png 1> /dev/null 2>&1; then 
          magick montage -label '%f' -pointsize 24 -geometry 1920x900+2+2 -title '{wildcards.sample}' -tile 1x {out_dir}IGV_Snapshots/{wildcards.sample}/*.png {output} 2> log/{wildcards.sample}_merge.err
          mkdir -p {out_dir}IGV_Snapshots/merge_true
          cp {output} {out_dir}/IGV_Snapshots/merge_true/{wildcards.sample}.png 2>log/{wildcards.sample}_cp.err
          else
          touch {output} 
          fi
          """

rule create_pdf:
    input:
          expand(rules.igv_snapshot.output,sample=d.keys())
    output:
          out_dir + "IGV_Snapshots/pdf/all_by_sample.pdf"
    params:
          tile = config.get("tile","1x4")
    threads: 1
    shell:
          """
          magick convert -adjoin {out_dir}/IGV_Snapshots/merge_true/*.png {output} 2>log/pdf.err
          """

