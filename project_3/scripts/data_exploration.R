library(tidyverse)
client <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/CLIENT_191102.tsv")
dis_en <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/DISABILITY_ENTRY_191102.tsv")
dis_ex <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/DISABILITY_EXIT_191102.tsv")
ee_re <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/EE_REVIEWS_191102.tsv")
ee_ud <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/EE_UDES_191102.tsv")
en_ex <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/ENTRY_EXIT_191102.tsv")
hel_ins_en <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/HEALTH_INS_ENTRY_191102.tsv")
hel_ins_ex <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/HEALTH_INS_EXIT_191102.tsv")
inc_en <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/INCOME_ENTRY_191102.tsv")
inc_ex <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/HEALTH_INS_EXIT_191102.tsv")
non_en <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/NONCASH_ENTRY_191102.tsv")
non_ex <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/NONCASH_EXIT_191102.tsv")
provider <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/PROVIDER_191102.tsv")
fam_v2 <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/VI_SPDAT_FAM_V2_191102.tsv")
ind_v2 <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/VI_SPDAT_IND_V2_191102.tsv")
v1 <- read_tsv("/Users/Yixiao/Desktop/611project/project_3/data/VI_SPDAT_V1_191102.tsv")

dis_en %>% group_by(`Disability Type (Entry)`) %>% summarise(count = n())

#What is EE provider and EE UID?
#What does disabiity_entry and disability_exit mean?


