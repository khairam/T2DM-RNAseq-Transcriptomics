# Comparative Transcriptomic Analysis of Type 2 Diabetes Mellitus

## Project Overview

This independent bioinformatics project investigates transcriptomic differences between Type 2 Diabetes Mellitus (T2DM) and control samples using publicly available RNA-seq data from GEO accession GSE326582.

Ten sequencing samples (five T2DM and five controls) were selected from the larger 22-sample dataset for comparative analysis. The study aimed to identify differentially expressed genes, examine associated biological processes, and investigate extracellular matrix (ECM)-related transcriptional changes.

Differential expression analysis identified 57 statistically significant genes (adjusted p-value < 0.05). Functional enrichment analysis highlighted extracellular matrix organization and cell adhesion, motivating a focused investigation of seven ECM-associated genes.

The project combines transcriptomic analysis, functional interpretation, and gene expression visualization to explore biological differences associated with T2DM.

## Methodology

Publicly available paired-end RNA-seq data were processed through quality assessment, read trimming, alignment to the human reference genome (hg38), and gene-level quantification. Differential expression between T2DM and control samples was evaluated using DESeq2, with statistical significance defined as an adjusted p-value < 0.05.

Exploratory analyses included principal component analysis (PCA), volcano plots, and expression heatmaps. Functional enrichment was performed using g:Profiler, followed by a focused investigation of seven ECM-associated genes through expression analysis and functional annotation.

## Key Findings

- **Differential expression:** Identified 57 significantly differentially expressed genes between T2DM and control samples (adjusted p-value < 0.05).
- **Functional enrichment:** Gene Ontology analysis identified significant enrichment in extracellular matrix organization and cell adhesion.
- **ECM-focused analysis:** Seven ECM-associated genes—SFRP2, CCDC80, CTSK, OLFML2B, FBLN1, LOXL1, and COL1A1—showed higher expression in T2DM samples.
- **Expression patterns:** A heatmap of variance-stabilized expression values supported the observed differences in these seven genes across the selected samples.
- **Sample variation:** PCA indicated that the T2DM and control groups did not separate clearly, highlighting the need for cautious interpretation.

These findings suggest that ECM-associated transcriptional changes may warrant further investigation in T2DM. The analysis is exploratory and does not establish a causal relationship.

