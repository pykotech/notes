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
 3. (top-right) Gnes in the gene set library
 4. (bottom-right) All genes

Fisher exact compares chance of see above table compared with what would be
expected if terms were randomly distributed.

## Enrichr

- Implements Fisher Exact test (and some other methods) by Chen et al. (2013)
- Currently incorporates 34 different gene set lists (GO, KEGG, Wikipathways,
  etc.)

