class: Workflow
cwlVersion: v1.0
id: rna_seq
doc: RNA-seq preprocessing workflow
label: RNA-seq
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
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
    'sbg:x': 198.671875
    'sbg:y': 120.90625
  - id: Reference
    type: File
    'sbg:x': 0
    'sbg:y': 14
outputs:
  - id: markDups_output_index
    outputSource:
      - picard__mark_duplicates/markDups_output_index
    type: File
    'sbg:x': 565.1358642578125
    'sbg:y': 0
  - id: bam_out
    outputSource:
      - gatk_splitncigarreads/bam_out
    type: File?
    'sbg:x': 809.4014892578125
    'sbg:y': 67.453125
steps:
  - id: picard__add_or_replace_read_groups
    in:
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
    run: ./../tools/picard-AddOrReplaceReadGroups.cwl
    label: picard-AddOrReplaceReadGroups
    'sbg:x': 0
    'sbg:y': 120.90625
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
    run: ./../tools/picard-MarkDuplicates.cwl
    'sbg:x': 198.671875
    'sbg:y': 7
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
    run: ./../tools/GATK-SplitNCigarReads.cwl
    label: GATK-SplitNCigarReads
    'sbg:x': 565.1358642578125
    'sbg:y': 120.90625
requirements: []
'sbg:license': Apache 2.0
'sbg:toolAuthor': Tilman Schaefers
