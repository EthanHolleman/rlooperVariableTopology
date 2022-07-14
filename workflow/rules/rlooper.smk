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
        'output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.rev/{plasmid}.{condition}.sigma{sigma}.rev.wig'
    params:
        sigma=lambda wildcards: wildcards['sigma']
    shell:'''
    {input.exe} {input.plasmid_fa} {output} --sigma {params.sigma} --N auto --localaverageenergy --reverse
    '''


rule run_rlooper_fwd:
    input:
        exe='software/rlooper/rlooper',
        plasmid_fa='workflow/data/{plasmid}.fa',
    output:
        'output/rlooper/{plasmid}/{plasmid}.{condition}.sigma{sigma}.fwd/{plasmid}.{condition}.sigma{sigma}.fwd.wig'
    params:
        sigma=lambda wildcards: wildcards['sigma']
    shell:'''
    {input.exe} {input.plasmid_fa} {output} --sigma {params.sigma} --N auto --localaverageenergy
    '''
