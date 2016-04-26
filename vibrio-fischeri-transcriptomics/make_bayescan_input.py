#!/usr/bin/env python
import sys

#############################################################################################################################################################################
#                                                                                                                                                                           #
#   Written by Jason Ladner                                                                                                                                                 #
#   questions?: jtladner@gmail.com                                                                                                                                          #
#   Usage:                                                                                                                                                                  #
#   python make_bayescan_input.py input_vcf_file  popfile  genotype_quality_cutoff  [# indivs req each pop]  [minor allele number threshold] [to output genotype file?]     #
#                                                                                                                                                                           #
#   Arguments in [ ] are optional, however input order is important, so if you want to output a genotype file then you must provide                                         #
#   the minimum # of individuals required in each population and the minor variant frequency threshold                                                                      #
#                                                                                                                                                                           #
#   input_vcf_file = the .vcf file that you want to extract genotype information from                                                                                       #
#   popfile = a plain text file with two columns per line, separated by some amount of whitespace                                                                           #
#             The 1st column is the individual ID (exactly as in the vcf file), the 2nd is the population that the individual belongs to                                    #
#   genotype_quality_cutoff = a floating point number that specifies the minimum quality allowed by genotype information to be used                                         #
#                                                                                                                                                                           #
#   # indivs req each pop = an integer specifying the minimum number of good quality genotypes required from each population in order                                       #
#                           for a given SNP to be included in the analysis (default = 5)                                                                                    #
#   minor allele number threshold = an integer used to specify the minimum # of copies of the minor allele that are necc. for a locus to be considered trustworthy          #
#                                   enough to be used in BayeScan. SNPs that do not meet the threshold are still written into the output files. However, the #s             #
#                                   for those SNPs is also written to a file called "low_freq_snps.txt". This file can be specified when running BayeScan                   #
#                                   in order to discard these SNPs from the analysis (using the -d option).                                                                 #
#   to output genotype file? = An optional boolean integer. If set to 1, then a text file is written containing the genotype information                                    #
#                              for all of the SNPs used in the analysis. If written the file will be called "used_snp_genos.txt"                                            #
#                              The default is not to write this file.                                                                                                       #
#############################################################################################################################################################################

'''---------------------------> VCF Format <-----------------------------
    cols[0] = contig name
    cols[1] = SNP position
    cols[2] = ID???? - empty in my vcf files
    cols[3] = Reference base
    cols[4] = Alternative base
    cols[5] = SNP quality (Phred score)
    cols[6] = filter flags
    cols[7] = SNP Info
    cols[8] = genotype format (e.g., GT:AD:DP:GQ:PL)
    cols[9:] = individual genotypes'''

def make_bayescan_input(vcf_file, gen_qual_cutoff, indivs2pops_dict, num_indivs_req_perpop=5, num_minor=2, to_make_genofile=0):
    fin = open(vcf_file, "r")
    fout_snpkey = open("snpkey.txt", "w")
    low_freq = open("low_freq_snps.txt", "w")
    if int(to_make_genofile): fout_genofile = open("used_snp_genos.txt", "w")
    #Reads through the vcf file line by line
    snpcount=0
    full_snpcount=0
    indiv_names = []
    output_lines_bypop = {}
        
    for line in fin:
        cols=line.rstrip().split('\t')
        genos=[]                                                             #Will hold individual level genotype data, resets list form previous SNP
        gencount=0                                                          #Will be used below to keep track of the individuals when appending new SNPs
        
        if cols[0][0] == '#' and cols[0][1] != '#':                         #To pull out headers
    
            headers=cols[0:2] + cols[3:5] + cols[9:]                        #Creates list of headers of interest
            indiv_names = headers[4:]                                       #Prints the IDs of the individuals with genotypes in the vcf
            
            if int(to_make_genofile): fout_genofile.write("%s\t%s\n" % (recursive_join(headers[:4]), recursive_join(headers[4:], "\t\t")))
            
        if cols[0][0] != '#':                                               #Specifies only SNP lines
            snpcount+=1                                                     #Keeps track of the numbers of SNPs
            genos=cols[9:]                                                   #Creates a list of all the genotype info
            desc=cols[8]
            locus_genos = get_genos(genos, desc, gen_qual_cutoff)
            merged_genos_dict = merge_genos_by_pop(locus_genos, indiv_names, indivs2pops_dict)
            if check_for_min_data(merged_genos_dict, int(num_indivs_req_perpop)):                       # Checks to make sure that each population has at least the minimum amount of data allowed
                full_snpcount+=1
                if check_minor_freq(locus_genos, num_minor): low_freq.write("%d\n" % full_snpcount)
                fout_snpkey.write("%d\t%s_%s\n" % (full_snpcount, cols[0], cols[1]))
                for key, value in merged_genos_dict.items():
                    output_lines_bypop[key] = output_lines_bypop.get(key, [])
                    output_lines_bypop[key].append("%d\t%d\t2\t%d\t%d" % (full_snpcount, value.count('0') + value.count('1'), value.count('0'), value.count('1')))
                    
                if int(to_make_genofile): fout_genofile.write("%s\t%s\t%s\t%s\t%s\n" % (cols[0], cols[1], cols[3], cols[4],recursive_join(locus_genos)))                    
    fin.close()
    fout_snpkey.close()
    low_freq.close()
    write_bayes_input(output_lines_bypop, "bayes_input.txt")

def get_genos(full_genos_data_list, desc, quality_cutoff):
    GQ_pos = get_GQ_pos(desc)
    locus=[]
    for gen in full_genos_data_list:                                #Steps through the genotype info for each individual
        parts=gen.split(':')                                        #Breaks apart the different sections of the genotype info
        genotype=parts[0]                                           #Most probable genotype for the individual, with the two alleles seperated by '/'
        genotypes=genotype.split('/')
        if genotypes != ['.','.']:                                  #Had to be added because in new version of GATK, .vcf files are written so that if there is no genotype info for an individual, their genotype is './.' as opposed to './.:0:0:0:0', or whatever
            # The exact positions of these variables within a .vcf can change
            # Check your genotype format and change script accordingly
            gen_quality=float(parts[GQ_pos])
            
            if gen_quality<quality_cutoff:
                genotypes=['.','.']

        locus.append(genotypes)

    return locus

def merge_genos_by_pop(locus_genos, indiv_names, indivs2pops_dict):
    genosbypop_dict={}
    for index, value in enumerate(locus_genos):
        if indivs2pops_dict.has_key(indiv_names[index]):
            pop_of_origin = indivs2pops_dict[indiv_names[index]]
            genosbypop_dict[pop_of_origin] = genosbypop_dict.get(pop_of_origin, []) + value
    return genosbypop_dict

def write_bayes_input(output_lines_bypop, outfile):
    fout = open(outfile, "w")
    fout.write("[loci]=%d\n\n[populations]=%d\n\n" % (len(output_lines_bypop[output_lines_bypop.keys()[0]]), len(output_lines_bypop)))
    pop_count=0
    for each_pop in output_lines_bypop:
        pop_count+=1
        fout.write("\n[pop]=%d\n" % (pop_count))
        print pop_count, each_pop
        for line in output_lines_bypop[each_pop]:
            fout.write("%s\n" % (line))

def check_for_min_data(merged_genos_dict, min_data):
    for pop_info in merged_genos_dict.values():
        if len(pop_info) - pop_info.count(".") < min_data * 2: return False
    return True

def write_alleles(outfile_pointer, locus_name, locus_genos):
    return True

#---------------------------------------------------------------------------------------------------------------
###----------> This function will join a list of values using a specified delimiter, the default is tab
###----------> Works even if some of the values in the list are tuples and integers
###------------------------------------------------------------------------------------------------------------

def recursive_join(list, delimiter="\t"):                # Function definition: def NAME(list of parameters):
    ready_to_join = []                                    #                            STATEMENTS
    for index, value in enumerate(list):
        if type(value) == type(()) or type(value) == type([]):
            ready_to_join.append(recursive_join(value))
        elif type(value) == type(1) or type(value) == type(1.0): 
            ready_to_join.append(str(value)) 
        else: 
            ready_to_join.append(value)                    # end of the function calls itself, hence recursive
            
    joined=delimiter.join(ready_to_join)
    return joined

#-------------------------------------------------------------#
#  This function takes the genotype description for a SNP     #
#   (e.g., GT:AD:DP:GQ:PL)                                    #
#  and returns the position of the genotype quality (GQ)      #
#  with the first position being 0                            #
#-------------------------------------------------------------#
def get_GQ_pos(genotype_description):            
    return genotype_description.split(':').index('GQ')

#---------------------------------------------------------------------------------------------------------------
#-------> This function will create a dictionary relating your individuals to their population of origin
#-------> Popfile should be a plain text file with two columns per line, separated by some amount of whitespace
#-------> The first column is the individual ID (exactly as it is in the .vcf file
#-------> The second column is the population that the individual belongs to
#---------------------------------------------------------------------------------------------------------------
def make_pop_dict(popfile):
    pop_dict = {}
    fin = open(popfile, 'r')
    for line in fin:
        cols = line.strip().split()
        pop_dict[cols[0]] = cols[1]
    return pop_dict

def check_minor_freq(locus_genos, num_minor):
    allele_0_count=0
    allele_1_count=0
    for geno in locus_genos:
        allele_0_count+=geno.count('0')
        allele_1_count+=geno.count('1')
    if allele_0_count < num_minor or allele_1_count < num_minor: return True
    else: return False
    
###------------> Actual script starts here:

if len(sys.argv) == 4: make_bayescan_input(sys.argv[1], int(sys.argv[3]), make_pop_dict(sys.argv[2]))
elif len(sys.argv) == 5: make_bayescan_input(sys.argv[1], int(sys.argv[3]), make_pop_dict(sys.argv[2]), int(sys.argv[4]))
elif len(sys.argv) == 6: make_bayescan_input(sys.argv[1], int(sys.argv[3]), make_pop_dict(sys.argv[2]), int(sys.argv[4]), int(sys.argv[5]))
elif len(sys.argv) == 7: make_bayescan_input(sys.argv[1], int(sys.argv[3]), make_pop_dict(sys.argv[2]), int(sys.argv[4]), int(sys.argv[5]), int(sys.argv[6]))
else: print "Invalid number of arguments specified. Read script usage commented into the top of the script file"
