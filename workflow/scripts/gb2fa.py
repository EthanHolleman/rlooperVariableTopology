from Bio import SeqIO

# ONE LINER BAAAAAAABY!!!!!!
SeqIO.write(SeqIO.read(snakemake.input['genbank'], 'genbank'), snakemake.output['fasta'], 'fasta')
