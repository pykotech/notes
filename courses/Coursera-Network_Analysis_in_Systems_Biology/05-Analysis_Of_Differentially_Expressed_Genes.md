% Module 5: Analysis of Differentially Expressed Genes and Proteins
% [Keith Hughitt](khughitt@umd.edu)
% 2013/11/19

Analysis of Differentially Expressed Genes and Proteins
=======================================================

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

## Fisher Exact Test

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

- Implements Fisher Exact test (and some other methods) by Chen et al. (2013)
- Currently incorporates 34 different gene set lists (GO, KEGG, Wikipathways,
  etc.)

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


