rule compile_rlooper:
    output:
        'software/rlooper/rlooper'
    shell:'''
    mkdir -p software/rlooper
    cd submodules/rlooper
    make all
    mv bin/rlooper ../../software/rlooper
    '''

rule run_rlooper_reverse:
    input:
        exe='software/rlooper/rlooper',
        plasmid_fa='workflow/data/{plasmid}.fa',
    output:
        folder='output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.rev/{plasmid}.{condition}.sigma{sigma}.rev',
        wig='output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.rev/{plasmid}.{condition}.sigma{sigma}.rev._bpprob.wig'
    params:
        sigma=lambda wildcards: wildcards['sigma']
    shell:'''
    {input.exe} {input.plasmid_fa} {output.folder} --sigma {params.sigma} --N auto --localaverageenergy --reverse
    '''


rule run_rlooper_fwd:
    input:
        exe='software/rlooper/rlooper',
        plasmid_fa='workflow/data/{plasmid}.fa',
    output:
        folder='output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.fwd/{plasmid}.{condition}.sigma{sigma}.fwd',
        wig='output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.fwd/{plasmid}.{condition}.sigma{sigma}.fwd_bpprob.wig'
    params:
        sigma=lambda wildcards: wildcards['sigma']
    shell:'''
    {input.exe} {input.plasmid_fa} {output.folder} --sigma {params.sigma} --N auto --localaverageenergy
    '''

rule plot_bbprobs:
    conda:
        '../envs/R.yml'
    input:
        'output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.{orrienation}/{plasmid}.{condition}.sigma{sigma}.{orrienation}_bpprob.wig'
    output:
        'output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.{orrienation}/plots/plot.{plasmid}.{condition}.sigma{sigma}.{orrienation}.wig_bpprob.png'
    params:
        title=lambda wildcards: f"Bp probabilities {wildcards['plasmid']} {wildcards['condition']} {wildcards['orrienation']}"
    script:'../scripts/plotbbprob.R'


