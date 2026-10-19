install.packages(c("readxl", "ggplot2", "dplyr"))
library(readxl)
library(ggplot2)
library(dplyr)

ecm_data <- read_excel(file.choose())

ecm_ids <- c(
  "ENSG00000145423",
  "ENSG00000091986",
  "ENSG00000143387",
  "ENSG00000162745",
  "ENSG00000077942",
  "ENSG00000129038",
  "ENSG00000108821"
)

ecm_genes <- ecm_data %>%
  filter(sub("\\..*$", "", `Gene ID`) %in% ecm_ids)

gene_symbols <- c(
  "ENSG00000145423" = "SFRP2",
  "ENSG00000091986" = "CCDC80",
  "ENSG00000143387" = "CTSK",
  "ENSG00000162745" = "OLFML2B",
  "ENSG00000077942" = "FBLN1",
  "ENSG00000129038" = "LOXL1",
  "ENSG00000108821" = "COL1A1"
)

ecm_genes$GeneSymbol <- gene_symbols[
  sub("\\..*$", "", ecm_genes[["Gene ID"]])
]

ecm_genes$T2DM_log2FC <- -as.numeric(ecm_genes$log2FoldChange)


ggplot(ecm_genes, aes(x = reorder(GeneSymbol, T2DM_log2FC),
                      y = T2DM_log2FC,
                      fill = T2DM_log2FC > 0)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(
    values = c("TRUE" = "firebrick", "FALSE" = "steelblue"),
    labels = c("TRUE" = "Higher in T2DM", "FALSE" = "Higher in Control"),
    name = "Expression"
  ) +
  labs(
    title = "ECM-Related Gene Expression in T2DM",
    x = "Gene",
    y = "log2 Fold Change (T2DM vs Control)"
  ) +
  theme_minimal()


write.csv(
  ecm_genes[, c("GeneSymbol", "T2DM_log2FC", "padj")],
  "T2DM_ECM_7_Genes.csv",
  row.names = FALSE
)

vst_data <- readr::read_delim("Downloads/Galaxy270-[VST-Normalized counts file on collection 259 and 265].tabular", delim = "\t", escape_double = FALSE, trim_ws = TRUE)
ecm_vst <- vst_data %>%
  filter(sub("\\..*$", "", `...1`) %in% ecm_ids)


ecm_matrix <- as.matrix(ecm_vst[, -1])

rownames(ecm_matrix) <- gene_symbols[
  sub("\\..*$", "", ecm_vst[[1]])
]

ecm_matrix <- apply(ecm_matrix, 2, as.numeric)

rownames(ecm_matrix) <- gene_symbols[
  sub("\\..*$", "", ecm_vst[[1]])
]


rownames(vst_data) <- vst_data[["...1"]]

vst_matrix <- as.matrix(vst_data[, -1])

rownames(vst_matrix) <- vst_data[["...1"]]

ecm_vst <- vst_matrix[
  sub("\\..*$", "", rownames(vst_matrix)) %in% ecm_ids,
  ,
  drop = FALSE
]


rownames(ecm_vst) <- gene_symbols[
  sub("\\..*$", "", rownames(ecm_vst))
]


colnames(ecm_vst) <- c(
  paste0("T2DM_", 1:5),
  paste0("Control_", 1:5)
)

heatmap(
  ecm_vst,
  scale = "row",
  Colv = NA,
  main = "ECM Gene Expression: T2DM vs Control",
  xlab = "Samples",
  ylab = "ECM Genes",
  margins = c(10, 8)
)


write.csv(
  ecm_vst,
  "T2DM_ECM_Heatmap_Data.csv",
  row.names = TRUE
)

gene_functions <- data.frame(
  Gene = c("SFRP2", "CCDC80", "CTSK", "OLFML2B",
           "FBLN1", "LOXL1", "COL1A1"),
  Function = c(
    "Wnt signaling modulation",
    "Extracellular matrix-associated protein",
    "Collagen and matrix protein degradation",
    "Extracellular protein with incompletely characterized function",
    "Extracellular matrix structural glycoprotein",
    "Elastin cross-linking and matrix maturation",
    "Type I collagen alpha-1 chain"
  )
)

write.csv(
  gene_functions,
  "ECM_Gene_Functions.csv",
  row.names = FALSE
)


ecm_final <- merge(
  ecm_genes,
  gene_functions,
  by.x = "GeneSymbol",
  by.y = "Gene"
)

ecm_final <- ecm_final[, c(
  "GeneSymbol",
  "T2DM_log2FC",
  "padj",
  "Function"
)]


write.csv(ecm_final, "T2DM_ECM_Final_Results.csv", row.names = FALSE)