# Causal Discovery & Inference Results for T2D Meta Analysis with Seven Studies

Included studies: 
- Therdthata et al. (PRJDB9293)
- Kondo et al. (PRJNA766337)
- Ahmad et al. (PRJNA554535)
- Saleem et al. (PRJEB53017)
- Saleem et al. (PRJEB53018)
- Babiker et al. (PRJNA588353)
- Hoang et al. (PRJNA668251)

Data description:
- 811 total samples (527 controls, 284 T2D); 614 OTUs
- V3-V4, Adult

## Microbe-Microbe Interaction Network
1. Filter rare OTUs (<1%): 614 OTUs → 256 OTUs
2. Graphical lasso, estimate sparse precision matrix
    - 256 x 256 precision matrix yields 65,536 - 256 = 65,280 edges in a complete graph
    - Controls: 224 remaining edges after glasso
    - T2D: 222 remaining edges after glasso
3. Run PC with max depth 2 on the above edges/graph with significance level $\alpha = 0.01$
    - Controls and T2D: share 27 microbes
    - Controls: additional 10 microbes 
    - T2D: additional 13 microbes 

## Microbe-Disease Interaction Network
1. Filter rare OTUs (<1%): 614 OTUs → 256 OTUs
2. Logistic lasso
    - 77 variables including 75 OTUs and 2 non-microbe covariates
3. Run CD-NOD with the 2 non-microbe covariates as c_index variables
    - 9 nodes directly pointing to disease status node including region and 8 OTUs
4. Run logistic regression to estimate causal effects of each of the 8 OTUs (any other causal inference estimators work, too)
    - Model 1: logit(disease status) ~ 8 OTUs
    - Model 2: for each OTU, logit(disease status) ~ OTU + Neighbors(OTU)
    - BIRDMAn: Negative Binomial, mean CLR

| Genus | Model 1 | Model 2 | BIRDMAn | Literature Agreement |
|-------|---------|---------|---------|----------------------|
| Alistipes A 871400 | -0.72608* | -0.87070* | -1.38028 | Inconclusive |
| Aphodomorpha | -1.23747* | -2.36658* | -1.54138* | Inconclusive | 
| CAG-267 | -19.68728 | -13.81186 | N/A | Inconclusive | 
| Collinsella | 0.10462* | 0.08761* | 1.4355* | Yes |
| Faecalibacterium | -0.10471* | -0.07721* | -0.09936 | Yes |
| Prevotella | -0.02734* | -0.01884* | -0.25227* | Yes |
| Pseudobutyrivibrio | 1.80315* | 1.76850* | 2.80971* | Inconclusive |
| unclassified Monoglobaceae | -9.38222* | -8.98766* | -4.07403* | N/A |