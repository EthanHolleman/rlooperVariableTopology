library(ggplot2)
library(ggpubr)  # only for looks

bbprobs.path <- snakemake@input[[1]]
plot.title <- snakemake@params[['title']]
output.file <- snakemake@output[[1]]

# Read and process wig file with bb probs
bbprobs.path <-bbprobs.path
df <- as.data.frame(
    read.csv(bbprobs.path, skip = 4, header = F)
)

df$base <- seq(1, nrow(df), 1)  # label basepair positions
colnames(df) <- c('prob', 'base')

# Plot probs as line along sequence
prob.plot <- ggplot(df, aes(x=base, y=prob)) + 
             geom_line(color='dodgerblue') + 
             labs(title=plot.title) +
             theme_pubr()

# Save the plot to output
ggsave(output.file, prob.plot, dpi=300)