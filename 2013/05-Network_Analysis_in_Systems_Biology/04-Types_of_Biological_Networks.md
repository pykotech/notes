% Module 4: Topological Models and Network Evolution
% [Keith Hughitt](khughitt@umd.edu)
% 2013/10/20

Types of Biological Networks
============================

Cell-signalling pathways
------------------------
- Typically represented by signed mixed graphs
- nodes = proteins, metabolites, lipids, etc.
- edges = information flow (activation or inhibition); enzymatic/binding
- Ex. Wikipathways, KEGG, etc.

**Kinase-substrate networks**
Directed bipartite graphs linking kinases with substrates.

**Pseudo-nodes** used to represent unknown links between components in a
network.

Gene Regulation Networks
------------------------
- Genes & TFs
- Edges can be activating or inhibitory

Network sources
---------------

## Literature-based
1. Manual (e.g. KEGG)
2. Semi-automated
3. Natural Language Processing (NLP)

## Experimental data
1. Protein-protein interaction network (Y2H screens)
 - In humans, Y2H about 78% accurate as confirmed by Co-IP
2. Epistasis Networks
 - E.g. Double-deletion yeast mutants

## Reverse Engineering
1. Inferring Networks from Time Series Microarrays (e.g. Zou et al. 2005)
2. Perturbations and Bayesian Networks

Other Networks
--------------
1. Drug-target networks
2. Disease gene networks
3. Functional Association networks
 - Bipartite networks for data integration
 - genes vs. experiments
