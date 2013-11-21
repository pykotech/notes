% Module 5: Analysis of Differentially Expressed Genes and Proteins
% [Keith Hughitt](khughitt@umd.edu)
% 2013/11/19

Analysis of Differentially Expressed Genes and Proteins
=======================================================

Background
----------

## GSEA: Gene Set Enrichment Analysis (2005)

- [Subramanian et al.](http://www.pnas.org/content/102/43/15545.short)
- Developed a statistical test based on the [Kolmogorov-Smirnov
  test](http://en.wikipedia.org/wiki/Kolmogorov%E2%80%93Smirnov_test)
- Also developed database of gene-set libraries:
  [MSigDB](http://www.broadinstitute.org/msigdb)

### Kolmogorov-Smirnov test

![KS test](http://upload.wikimedia.org/wikipedia/commons/c/cf/KS_Example.png)

> Kolmogorov–Smirnov test (K–S test) is a nonparametric test for the equality
> of continuous, one-dimensional probability distributions that can be used to
> compare a sample with a reference probability distribution (one-sample K–S
> test), or to compare two samples (two-sample K–S test)
(Wikipedia)

- K-S statistic quanitifies distance between the empirical distribution
function of the sample and the cumulative distribution function of the
reference distribution.
- null hypothesis: samples are drawn from the same distribution.

The Fisher Exact Test and Enrichr
---------------------------------

## Input

### GMT File Format (review)

- Gene Matrix Transpose (GMT) format created primarily for enrichment analysis.
- Example (GO terms):

| GO Term       | Description   | Gene 1  | Gene 2 | etc. |
| ------------- | ------------  | ------- | ------ | ---- |
| GO:00123      | na            | PPY     | NOX5   | ...  |
| GO:00345      | na            | GTF3A   | RNASEK | ...  |
| etc.          | na            | ...     |        |      |

- Other types of annotations can be used however, e.g. KEGG.

### Gene Ontology (GO)

- 3 parent nodes
    - Cellular Component
    - Biological Process
    - Molecular Function

### KEGG

- Biological pathways
- Term = a pathway (in human cells)

By flattening the graph structures of GO, KEGG, etc., it is possible to apply
simple statistical methods to look for enrichment.

## Fisher's Exact Test

![RA Fisher](http://upload.wikimedia.org/wikipedia/commons/4/46/R._A._Fischer.jpg)

### Overview

- Statistical significance test used in the analysis of contingency tables.
- Useful for categorical data resulting from classfying objects in two
  different way.


For Gene enrichment analysis:

For each set of terms, a p-value is computed that evaluates the enrichment
level of the term with the list of input genes.

- Uses a contingency table:
 1. (top-left) Overlapping genes between my list and a list of gene set library
 2. (bottom-left) DE genes
 3. (top-right) Genes in the gene set library
 4. (bottom-right) All genes

Fisher exact compares chance of see above table compared with what would be
expected if terms were randomly distributed.

## Enrichr

![Enrichr screenshot](http://www.biomedcentral.com/content/supplementary/1471-2105-14-128-s2.png)

- Chen et al. (2013)
- Provides three different methods for computing enrichment:
    1. Fisher exact test
    2. "Corrected" version of Fisher exact test 
    3. Combination of p-value from Fisher exact test with z-score of deviation
      from expected rank:
      $$c=log(p)*z$$
- Currently incorporates 34 different gene set lists:
    - GO
    - KEGG
    - Wikipathways
    - etc.

### Motivation

- Many other tools similar to GSEA have been developed, but most tend to focus
  on GO enrichment
- These tools often use Fisher exact test to compute enrichment.
- FE test family is biased with respect to list size.
- Goals of Enrichr:
    - incorporate other gene set lists
    - do better than Fisher exact test
    - visualization

Network Visualization
---------------------

## Genes2Networks (2007)

- http://actin.pharm.mssm.edu/genes2networks/
- Web-based tool that takes a list of mammalian genes or proteins and attempts
  to connect them using know protein-protein interactions.
- Combined several databases from literature describing protein-protein
  interactions. Then filtered data to remove less reliable interactions.
- G2N builds a sub-network for list of genes using shortest path.

### Expression2Kinases (2012)

- http://www.maayanlab.net/X2K/
- Attempt to detect upstream regulators (TFs and kinases) from lists of
  differentially expressed genes.
- [STRING](http://string-db.org/) is another popular method for generating
  networks in a similar manner.

Network2Canvas and Enrichment Analysis with N2C
-----------------------------------------------

## GATE: Grid Analysis of Time-series Expression 
MacArthur et al. 2009

![GATE](http://amp.pharm.mssm.edu/maayan-lab/img/gatebackground.png)

### Overview

- An alternative method for visualizing networks
- Nodes are arranged on a grid based on node similarity/node-node interactions.
- Initially developed to deal with multi-layered time-series regulatory data
  (Nanog knockdown in mouse embryonic stem cells, inducing cell
  differentiation.)
- Incorporated several data sources
  - expression data (microarray)
  - whole nuclear proteomics (mass spec)
  - histone modifications and Pol II binding (ChIP-ChIP)
- Goal: visualize changes in expression over time across multiple layers.

###Construction

- Place each gene on a hexagonal grid s.t. genes with similar expression
  profiles are close together.
    - Self-organizing map?
- Uses [simmulated
  annealing](http://en.wikipedia.org/wiki/Simulated_annealing) to find a good
  arrangement for all of the genes.
- Pairs of genes are randomly shuffled and fitness is measured.
    - improvements to global fitness are always accepted
    - improvements that do not improve fitness are accepted with some
      probability (boltzmann distribution)
- Final configuration is visualized on hexagonal grid
    - gene position stays the same across time as color changes
    - green: expression decreases
    - red: expression increases

## Network2Canvas

![N2C](https://i.ytimg.com/vi/R3eBQcRcOEY/mqdefault.jpg)

### Overview

- Idea of visualizing expression on a grid extended to deal with any type of
  network.
  - Take a gene set library or drug set library
  - transpose library
  - feed to Sets2Networks
  - project on canvas
  - uses a square grid instead of hexagonal (easier to implement)

Expression2Kinases - Inferring Pathways for Differentially Expressed Genes
--------------------------------------------------------------------------

### Cell Signalling Pathways

Pathways aren't as isolated as they are often portrayed -- may be better to
think of them as having fuzzy boundaries with members of varying importance.

### KEA: Enrichment Analysis for Kinase-Substrate Interactions from Literature

![KEA](http://bioinformatics.oxfordjournals.org/content/25/5/684/F1.large.jpg)

- Collected kinase-substrate reactions from various online databases
- Used to create a large-scale network of KS reactions and also a gene set
  library with kinases as terms and substrates at row entries.
  - Can use for enrichment analysis
- SIL

References
----------
- Edward Y Chen, Christopher M Tan, Yan Kou, Qiaonan Duan, Zichen Wang,
  Gabriela Meirelles, Neil R Clark, Avi Ma’ayan,   (2013) Enrichr: Interactive
  And Collaborative Html5 Gene List Enrichment Analysis Tool.  *Bmc
  Bioinformatics*  **14**  128-NA
  [10.1186/1471-2105-14-128](http://dx.doi.org/10.1186/1471-2105-14-128)> 
- http://en.wikipedia.org/wiki/Kolmogorov–Smirnov_test
- http://en.wikipedia.org/wiki/Fisher's_exact_test
