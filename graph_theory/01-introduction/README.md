% Introduction to Graph Theory
% Keith Hughitt
% 2013/11/06

Introduction
============

1.1 Graphs and Graph Models
---------------------------

## Graph definition
- A graph $G$ consists of a finite nonempty set $V$ of objected call *vertices*
and  a set $E$ of 2-element subsets of $V$ called **edges**.
- $V$ and $E$ are the **vertex set** and **edge set**; can also write as $V(G)$ and
$E(G)$ to emphasize that they are the vertex and edge sets of graph $G$
- $G$ is the *ordered* set containing $V$ and $E$
- Two graphs $G$ and $H$ are *equal* if both their node and edges sets are equal.

## Properties
- An edge between nodes $u$ and $v$ may be represented as ${u,v}$ or $uv$.
- If $uv$ is an edge in $G$, then $u$ and $v$ are said to be **adjacent**
- **order** = # nodes
- **size** = # edges
- A graph with exactly one vertex is called a **trivial** graph. All other
graphs are **nontrivial**.
- Graphs can be **labeled** or **unlabeled**

## Examples
- **Word graphs** each nodes in the graph represents a word. Adjacent nodes
are nodes with a single character changed.

1.2 Connected Graphs
--------------------


References
----------
- Gary Chartrand,   (2012) A first course in graph theory.
