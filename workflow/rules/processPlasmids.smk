rule genbank_to_fasta:
    conda:
        '../envs/py.yml'
    input:
        genbank='workflow/data/{plasmid}.gb'
    output:
        fasta='output/plasmids/{plasmid}.fa'
    script:'scripts/gb2fa.py'
