class: Workflow
cwlVersion: v1.0
id: rna_seq
doc: RNA-seq preprocessing workflow
label: RNA-seq
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: genomeDir
    type: Directory
    'sbg:x': 1
    'sbg:y': 144
  - id: readFilesIn
    type: 'File[]?'
    'sbg:x': -47.59234619140625
    'sbg:y': -93.71746826171875
  - id: outBAMcompression
    type: int
    'sbg:exposed': true
  - id: outFileNamePrefix
    type: string?
    'sbg:exposed': true
  - id: outSAMmode
    type: string
    'sbg:exposed': true
  - id: outSAMtype
    type: string
    'sbg:exposed': true
  - id: outStd
    type: string
    'sbg:exposed': true
  - id: readFilesCommand
    type: string?
    'sbg:exposed': true
  - id: runMode
    type: string
    'sbg:exposed': true
  - id: runThreadN
    type: int?
    'sbg:exposed': true
  - id: java_args
    type: string
    'sbg:exposed': true
  - id: output
    type: string
    'sbg:exposed': true
  - id: ReadGroupID
    type: string
    'sbg:exposed': true
  - id: ReadGroupLibrary
    type: string
    'sbg:exposed': true
  - id: ReadGroupPlatform
    type: string
    'sbg:exposed': true
  - id: ReadGroupPlatformUnit
    type: string
    'sbg:exposed': true
  - id: ReadGroupSampleName
    type: string
    'sbg:exposed': true
  - id: CREATE_INDEX
    type: string
    'sbg:exposed': true
  - id: java_arg
    type: string
    'sbg:exposed': true
  - id: outputFileName_markDups
    type: string
    'sbg:exposed': true
  - id: createIndex
    type: string?
    'sbg:exposed': true
  - id: metricsFile
    type: string?
    'sbg:exposed': true
  - id: gatk_jar
    type: File
    'sbg:x': 611.037841796875
    'sbg:y': 371.2839660644531
  - id: Reference
    type: File
    'sbg:x': 604.9028930664062
    'sbg:y': 220.16673278808594
outputs:
  - id: mappingstats
    outputSource:
      - _s_t_a_r/mappingstats
    type: File?
    'sbg:x': 417.0085144042969
    'sbg:y': 107
  - id: markDups_output_index
    outputSource:
      - picard__mark_duplicates/markDups_output_index
    type: File
    'sbg:x': 831.14990234375
    'sbg:y': -110.27662658691406
  - id: bam_out
    outputSource:
      - gatk_splitncigarreads/bam_out
    type: File?
    'sbg:x': 1011.57421875
    'sbg:y': 128.2342071533203
steps:
  - id: _s_t_a_r
    in:
      - id: genomeDir
        source: genomeDir
      - id: outBAMcompression
        source: outBAMcompression
      - id: outFileNamePrefix
        source: outFileNamePrefix
      - id: outSAMmode
        source: outSAMmode
      - id: outSAMtype
        source: outSAMtype
      - id: outStd
        source: outStd
      - id: readFilesCommand
        source: readFilesCommand
      - id: readFilesIn
        source:
          - readFilesIn
      - id: runMode
        source: runMode
      - id: runThreadN
        source: runThreadN
    out:
      - id: aligned
      - id: indices
      - id: mappingstats
      - id: readspergene
      - id: transcriptomesam
    run: ../../tools/STAR.cwl
    'sbg:x': 141.875
    'sbg:y': 25.5
  - id: picard__add_or_replace_read_groups
    in:
      - id: input
        source:
          - _s_t_a_r/aligned
      - id: java_args
        source: java_args
      - id: output
        source: output
      - id: ReadGroupID
        source: ReadGroupID
      - id: ReadGroupLibrary
        source: ReadGroupLibrary
      - id: ReadGroupPlatform
        source: ReadGroupPlatform
      - id: ReadGroupPlatformUnit
        source: ReadGroupPlatformUnit
      - id: ReadGroupSampleName
        source: ReadGroupSampleName
      - id: CREATE_INDEX
        source: CREATE_INDEX
    out:
      - id: out_bam
    run: ../../tools/picard-AddOrReplaceReadGroups.cwl
    label: picard-AddOrReplaceReadGroups
    'sbg:x': 417.0085144042969
    'sbg:y': 0
  - id: picard__mark_duplicates
    in:
      - id: createIndex
        source: createIndex
      - id: inputFileName_markDups
        source:
          - picard__add_or_replace_read_groups/out_bam
      - id: java_arg
        source: java_arg
      - id: metricsFile
        source: metricsFile
      - id: outputFileName_markDups
        source: outputFileName_markDups
    out:
      - id: markDups_output
      - id: markDups_output_index
    run: ../../tools/picard-MarkDuplicates.cwl
    'sbg:x': 615.711669921875
    'sbg:y': 46.5
  - id: gatk_splitncigarreads
    in:
      - id: java_args
        default: '-Xmx4g'
      - id: gatk_jar
        source: gatk_jar
      - id: Reference
        source: Reference
      - id: INPUT
        source: picard__mark_duplicates/markDups_output
      - id: OUTPUT
        default: split.bam
      - id: N_CIGAR
        default: ALLOW_N_CIGAR_READS
      - id: rf
        default: ReassignOneMappingQuality
      - id: RMQF
        default: 255
      - id: RMQT
        default: 60
    out:
      - id: bam_out
    run: ../../tools/GATK-SplitNCigarReads.cwl
    label: GATK-SplitNCigarReads
    'sbg:x': 831.2301635742188
    'sbg:y': 129.27928161621094
requirements: []
'sbg:license': Apache 2.0
'sbg:toolAuthor': Tilman Schaefers
