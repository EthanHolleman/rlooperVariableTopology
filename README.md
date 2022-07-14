# Rlooper on pFC8 and 53 under various topological densities

This repo contains the code used to run Rlooper on pFC8 and pFC53 
(sequences included in [this directory](workflow/data)) under various
topological conditions that approximately correspond to some
topologies previously profiled using SMRF-seq.

## Conditions

Conditions are specified to the workflow via the [conditions table](workflow/conditions.tsv) which is also shown below. Plasmid and
superhelical density is specified. The domain refers to the rlooper
`--N` argument and is set to auto for all runs (superhelical density is across entire length of the sequence). 

| condition_name    | plasmid | sigma  | domain |
|-------------------|---------|--------|--------|
| supercoiled       | pFC53   | -0.07  | auto   |
| supercoiled       | pFC8    | -0.07  | auto   |
| linear            | pFC53   | 0      | auto   |
| linear            | pFC8    | 0      | auto   |
| hypernegative     | pFC53   | -0.105 | auto   |
| hypernegative     | pFC8    | -0.105 | auto   |
| supercoiled_ecoli | pFC8    | -0.05  | auto   |
| suercoiled_ecoli  | pFC53   | -0.05  | auto   |

- `supercoiled`: Commonly used negative supercoiling value for plasmid runs. Is used in program documentation and paper. 
- `linear`: Approximates linear molecules with no DNA toplogy.
- `hypernegative`: Estimate of supercoiling from Gyrase treatment (increased `supercoiled` value by 50%. )
- `supercoiled_ecoli`: Estimated superhelical density of the E. Coli genome. Likely equivalent to supercoiling levels of plasmids extracted
from E. Coli. 

## Output

Output from the run can be downloaded from the [releases page](). Runs are
sorted first by plasmid and then by condition.

### File naming scheme

File / directory names are specied in the following way

`{plasmid name}.{condition name}.sigma{sigma value}.{orientation}.{file extension}`

### A note of orientation

R-looper has two arguments that are specified to indicate the orientation of the given DNA sequence. The first is given in the
fasta header and specifies "which strand is the the non-template strand". Both pFC8 and pFC53 are transcribed from the T3 promoter
in the negative orientation resulting in the non-template strand
being the negative strand. Accordingly the fasta header argument `strand` was set to `-` for all runs. However, just for kicks I also repeated the runs with the `--reverse` command line argument. This
will flip strand orientation. Runs that used the `--reverse` argument
have `rev` in the filename.

## Running the workflow

From the repo root directory.

### Locally

`snakemake -j 1 --use-conda`

### On CRICK

`snakemake --profile workflow/profile`

or just

`sbatch crick.sbatch`

