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

Functional Association Networks with Sets2Networks
==================================================

Bipartite Networks for Data Integration
---------------------------------------
- Tanay et al. 2004^1
- Genes linked together based on functional properties
- Used to find functional modules in yeast regulatory network

**Gene Matrix Transpose (GMT) format**
- Flat-file format for storing functional networks
- Initially created for doing Gene Set Enrichment Analysis (GSEA)
- Column 1: functional terms (e.g. a particular KEGG pathway)
- Columns 2-n: List of genes that have that function/property.

The inference problem
---------------------
- Given functional relationships between genes (e.g. GMT file), can we infer
the structure of the underlying network?
- Assumptions
 - There is an underlying network connecting genes
 - Functional groups tell us something about the network

Sets2Networks
-------------
- Clark et al^2^ (2012)
- Generates many random networks based on partial available data
- Keep track of how many times an edge appears between a pair of nodes
that are consistent with the data.
- Threshold results to only include the most frequently occuring edges.

**Matthew's Correlation Coefficient**
- Index for assessing the quality of a binary classifier using the true and
false positive and negative rates.
- Typically used in machine learning
- Perfect performance: MCC=1

Other examples:
---------------
- Systems Pharmacology
 - Example: FDA Adverse Event Reporting Systems (FAERS) database
 - Can use to infer interactions between drugs and side-effects.
- Author collaboration networks

References
==========
1. A. Tanay, R. Sharan, M. Kupiec, R. Shamir, (2004) Revealing Modularity And 
Organization in The Yeast Molecular Network by Integrated Analysis of Highly 
Heterogeneous Genomewide Data.  *Proceedings of The National Academy of 
Sciences*  **101**  2981-2986
[10.1073/pnas.0308661100](http://dx.doi.org/10.1073/pnas.0308661100)>
2. Neil R Clark, Ruth Dannenfelser, Christopher M Tan, Michael E Komosinski, 
Avi Ma'ayan,   (2012) Sets2networks: Network Inference From Repeated 
Observations of Sets.  *Bmc Systems Biology*  **6**  89-NA  
[10.1186/1752-0509-6-89](http://dx.doi.org/10.1186/1752-0509-6-89)

