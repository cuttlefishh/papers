#!/bin/bash

#Variant detection:

java -Xmx16g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
	-R REFERENCE_ASSEMBLY_NAME.fasta -T UnifiedGenotyper \
	-I merged_realigned.bam -o rawSNPS_Q4.vcf \
	-gt_mode DISCOVERY \
	-stand_call_conf 4 -stand_emit_conf 3
	
#Selecting an appropriate quality score threshold (From the Broad Institute's Wiki site):
#A common question is the confidence score threshold to use for variant detection. We recommend:
#Deep (> 10x coverage per sample) data 
#    we recommend a minimum confidence score threshold of Q30 with an emission threshold of Q10. These Q10-Q30 calls will be emitted filtered out as LowQual. 
#Shallow (< 10x coverage per sample) data 
#    because variants have by necessity lower quality with shallower coverage, we recommend a min. confidence score of Q4 and an emission threshold of Q3. 


#Annotate variants:

java -Xmx16g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
  -T VariantAnnotator \
  -l INFO \
  -R REFERENCE_ASSEMBLY_NAME.fasta \
  -I merged_realigned.bam \
  -o rawSNPS_Q4_annotated.vcf \
  -B:variant,VCF rawSNPS_Q4.vcf \
  --useAllAnnotations

#Calling InDels (needed for filtering around InDels):

java -Xmx16g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
	-R REFERENCE_ASSEMBLY_NAME.fasta -T UnifiedGenotyper \
	-I merged_realigned.bam -o InDels_Q4.vcf \
	-gt_mode DISCOVERY \
	-glm INDEL \
	-stand_call_conf 4 -stand_emit_conf 3

#Filtering around InDels:

java -Xmx16g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
  -T VariantFiltration \
  -R REFERENCE_ASSEMBLY_NAME.fasta \
  -B:mask,VCF InDels_Q4.vcf \
  -B:variant,VCF rawSNPS_Q4_annotated.vcf \
  -o Indel_filtered_Q4.vcf


#Additional filtering:

java -Xmx16g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
  -T VariantFiltration \
  -R REFERENCE_ASSEMBLY_NAME.fasta \
  -B:variant,VCF Indel_filtered_Q4.vcf \
  -o filtered_Q4.vcf \
  --clusterWindowSize 7 \
  --filterExpression "MQ0 >= 4 && ((MQ0 / (1.0 * DP)) > 0.1)" \
  --filterName "HARD_TO_VALIDATE" \
  --filterExpression "SB >= -1.0" \
  --filterName "StrandBiasFilter" \
  --filterExpression "QUAL < 10" \
  --filterName "QualFilter"
  
  
# Variant recalibrator

java -Xmx4g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
   -T VariantRecalibrator \
   -R REFERENCE_ASSEMBLY_NAME.fasta \
   -B:input,VCF filtered_Q4.vcf \
   -B:concordantSet,VCF,known=true,training=true,truth=true,prior=10.0 highQualSNPS.vcf \
   -an QD -an HaplotypeScore -an MQRankSum -an ReadPosRankSum -an FS -an MQ \
   -recalFile VQSR.recal \
   -tranchesFile VQSR.tranches \
   -rscriptFile VQSR.plots.R \
   -tranche 100.0 -tranche 99.9 -tranche 99.0 -tranche 90.0 \
   --ignore_filter HARD_TO_VALIDATE \
   --ignore_filter LowQual
   
#Applying the recalibration
   
java -Xmx3g -jar ~/programs/GATK/dist/GenomeAnalysisTK.jar \
   -T ApplyRecalibration \
   -R REFERENCE_ASSEMBLY_NAME.fasta \
   -B:input,VCF filtered_Q4.vcf \
   --ts_filter_level 99.0 \
   --ignore_filter HARD_TO_VALIDATE \
   --ignore_filter LowQual \
   -tranchesFile VQSR.tranches \
   -recalFile VQSR.recal \
   -o recalibrated_filtered_SNPS.vcf
   
#Finally, save all the SNPS that have passed the VQSR filter into a new vcf file:

cat recalibrated_filtered_SNPS.vcf | grep 'VQSLOD\|^#' | grep -v TruthSensitivityTranche > VQSR_PASS_SNPS.vcf
