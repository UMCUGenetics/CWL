class: Workflow
cwlVersion: v1.0
id: wes_map_process_cwl
label: WES_map_process.cwl
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: reference
    type: File
    'sbg:x': -1
    'sbg:y': -56
  - id: reads
    type: 'File[]'
    'sbg:x': -13
    'sbg:y': 125
  - id: output_filename
    type: string
    'sbg:exposed': true
  - id: metricsFile
    type: string?
    'sbg:exposed': true
  - id: outputFileName_markDups
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
  - id: out_bam_name
    type: string?
    'sbg:exposed': true
  - id: format
    type: string
    'sbg:exposed': true
  - id: out_name
    type: string
    'sbg:exposed': true
outputs:
  - id: markDups_output_index
    outputSource:
      - picard__mark_duplicates/markDups_output_index
    type: File
    'sbg:x': 722.0912475585938
    'sbg:y': -150.10313415527344
  - id: out_bam
    outputSource:
      - picard__add_or_replace_read_groups/out_bam
    type: File?
    'sbg:x': 924.143310546875
    'sbg:y': 59.62335968017578
steps:
  - id: bwa_mem
    in:
      - id: output_filename
        source: output_filename
      - id: reads
        source:
          - reads
      - id: reference
        source: reference
    out:
      - id: output
    run: ../../tools/bwa-mem.cwl
    'sbg:x': 133.421875
    'sbg:y': 46.421875
  - id: picard__mark_duplicates
    in:
      - id: inputFileName_markDups
        source:
          - sambamba_sort/output
      - id: java_arg
        default: '-Xmx4g'
      - id: metricsFile
        default: metrics.txt
        source: metricsFile
      - id: outputFileName_markDups
        default: sample.mdub.bam
        source: outputFileName_markDups
    out:
      - id: markDups_output
      - id: markDups_output_index
    run: ../../tools/picard-MarkDuplicates.cwl
    'sbg:x': 543.71484375
    'sbg:y': 45.50581359863281
  - id: picard__add_or_replace_read_groups
    in:
      - id: input
        source:
          - picard__mark_duplicates/markDups_output
      - id: java_args
        default: '-Xmx4g'
      - id: output
        default: out.RG.bam
        source: output
      - id: ReadGroupID
        default: '778'
        source: ReadGroupID
      - id: ReadGroupLibrary
        default: WES
        source: ReadGroupLibrary
      - id: ReadGroupPlatform
        default: illumina
        source: ReadGroupPlatform
      - id: ReadGroupPlatformUnit
        default: Unit1
        source: ReadGroupPlatformUnit
      - id: ReadGroupSampleName
        default: na1287878
        source: ReadGroupSampleName
      - id: CREATE_INDEX
        default: 'true'
        source: CREATE_INDEX
    out:
      - id: out_bam
    run: ../../tools/picard-AddOrReplaceReadGroups.cwl
    label: picard-AddOrReplaceReadGroups
    'sbg:x': 734.2340698242188
    'sbg:y': 62.92189025878906
  - id: sambamba_view
    in:
      - id: input_sam
        source: bwa_mem/output
      - id: out_bam_name
        source: out_bam_name
      - id: format
        source: format
    out:
      - id: out_bam
    run: ../../tools/sambamba-view.cwl
    label: sambamba view
    'sbg:x': 253.09100341796875
    'sbg:y': 45
  - id: sambamba_sort
    in:
      - id: input
        source: sambamba_view/out_bam
      - id: out_name
        source: out_name
    out:
      - id: output
    run: ../../tools/sambamba-sort.cwl
    label: sambamba sort
    'sbg:x': 381.8963317871094
    'sbg:y': 43.02603530883789
requirements: []
