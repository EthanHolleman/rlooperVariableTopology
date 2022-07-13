rule compile_rlooper:
    output:
        'software/rlooper/rlooper'
    shell:'''
    mkdir -p software/rlooper
    cd submodules/rlooper
    make all
    mv bin/rlooper ../software/rlooper
    '''


rule run_rlooper_reverse:
    input:
        exe='software/rlooper/rlooper',
        plasmid_fa='output/plasmids/{plasmid}.fa',
    output:
        directory('output/rlooper/{plasmid}/{plasmid}.{condition}.{sigma}.{run_num}.rev')
    params:
        sigma=lambda wildcards: wildcards['sigma']
    shell:'''
    {input.exe} {input.plasmid_fa} {output} --sigma {params.sigma} --N auto --localaverageenergy --reverse
    '''


rule run_rlooper_fwd:
    input:
        exe='software/rlooper/rlooper',
        plasmid_fa='output/plasmids/{plasmid}.fa',
    output:
        directory('output/rlooper/{plasmid}/{plasmid}.{condition}.{sigma}.{run_num}.fwd')
    params:
        sigma=lambda wildcards: wildcards['sigma']
    shell:'''
    {input.exe} {input.plasmid_fa} {output} --sigma {params.sigma} --N auto --localaverageenergy
    '''
