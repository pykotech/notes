% Module 4: Topological Models and Network Evolution
% [Keith Hughitt](khughitt@umd.edu)
% 2013/10/20

Small-World and Scale-Free Networks
===================================

Background
----------

**Erdos-Renyi Random Networks**
* Erdos and Renyi studied networks with randomly connected nodes (1959).
* Showed that degree distribution for random networks follow a Poisson (~Normal)
distribution.

**"Real" Networks are "Small World"**
* Watts and Strogatz showed that real world systems follow "small world" 
topology (1998).
* Real world system are *not* random but instead they have:
 1. High clustering coefficients, and,
 2. Relatively short characteristic patterning.

Looked at three complex systems:
 * IMDB (movies)
 * Powergrid systems
 * Neuronal connectivity map of *C. elegans*

**Clustering Coefficient**

 A measure of how the neighbors of a node are connected.

C=1   All neighbors are connected
C=1/2 Neighbors have half of the total possible connections
C=0   No neighbors are connected to one another

**Characteristic Path Length**
The average shortest distance between all possible pairs of nodes in a network.

These "small world" networks fall about fall way between a completely connected
network and a complete randomized network. (Watts and Strogatz, 1998)

**Rich-Get-Richer network growth model**
Real world network degree distribution follows power-law distribution 
("scale-free") and not a poisson distribution (Barabasi and Albert; 1999).

To construct such a network:
* Start with a few randomly connected nodes
* Start adding new nodes and links to the system:
 - Adding randomly will result in Erdos-Renyi random network.
 - In Rich-get-richer model, new nodes are added with a varying probability
   based on existing nodes.
* Stop once it reaches your desired size.

Many complex systems tend to have this scale-free property. When comparing
similar things, likely get Normal distribution. When you have more diverse
agents, however, more likely to get a power-law distribution (e.g. building
heights in NYC).

**Hub nodes**
* In a scale-free network you have a few very highly-connected nodes; small
proportion of total network, but much higher than for random networks.
* In scale-free networks, there is sometimes a drop in hubs: they do not
grow infinitely large.
* This may be due to a limit, either physical or temporal ("aging") on the 
nodes (e.g. max height for a building.)




