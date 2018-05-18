class: Workflow
cwlVersion: v1.0
id: trim_map
label: trim-map
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: trimmomatic_jar_path
    type: File
    'sbg:x': -7.361143112182617
    'sbg:y': -142.8061981201172
  - id: input_read1_fastq_file
    type: File
    'sbg:x': 16.194517135620117
    'sbg:y': 149.6941680908203
  - id: input_adapters_file
    type: File
    'sbg:x': 0
    'sbg:y': 320.046875
  - id: end_mode
    type: string
    'sbg:exposed': true
  - id: illuminaclip
    type: string
    'sbg:exposed': true
  - id: java_opts
    type: string?
    'sbg:exposed': true
  - id: leading
    type: int?
    'sbg:exposed': true
  - id: log_filename
    type: string?
    'sbg:exposed': true
  - id: minlen
    type: int?
    'sbg:exposed': true
  - id: nthreads
    type: int
    'sbg:exposed': true
  - id: phred
    type: string
    'sbg:exposed': true
  - id: slidingwindow
    type: string?
    'sbg:exposed': true
  - id: trailing
    type: int?
    'sbg:exposed': true
  - id: input_read2_fastq_file
    type: File?
    'sbg:x': 2.944457530975342
    'sbg:y': 19.13850212097168
  - id: genomeDir
    type: Directory
    'sbg:x': -2.944457530975342
    'sbg:y': 505.5003662109375
outputs:
  - id: output_log_file
    outputSource:
      - trimmomatic/output_log_file
    type: File?
    'sbg:x': 680.4754638671875
    'sbg:y': 132.06248474121094
  - id: transcriptomesam
    outputSource:
      - _s_t_a_r/transcriptomesam
    type: File?
    'sbg:x': 955.6090087890625
    'sbg:y': 0
  - id: readspergene
    outputSource:
      - _s_t_a_r/readspergene
    type: File?
    'sbg:x': 955.6090087890625
    'sbg:y': 106.6953125
  - id: mappingstats
    outputSource:
      - _s_t_a_r/mappingstats
    type: File?
    'sbg:x': 955.6090087890625
    'sbg:y': 213.4296875
  - id: indices
    outputSource:
      - _s_t_a_r/indices
    type: Directory?
    'sbg:x': 955.6090087890625
    'sbg:y': 320.125
  - id: aligned
    outputSource:
      - _s_t_a_r/aligned
    type: File?
    'sbg:x': 955.6090087890625
    'sbg:y': 426.8203125
steps:
  - id: trimmomatic
    in:
      - id: end_mode
        default: PE
        source: end_mode
      - id: illuminaclip
        default: '2:30:10'
        source: illuminaclip
      - id: input_adapters_file
        source: input_adapters_file
      - id: input_read1_fastq_file
        source: input_read1_fastq_file
      - id: input_read2_fastq_file
        source: input_read2_fastq_file
      - id: java_opts
        default: '-Xmx4g'
        source: java_opts
      - id: leading
        default: 3
        source: leading
      - id: log_filename
        default: trim.log
        source: log_filename
      - id: minlen
        default: 36
        source: minlen
      - id: nthreads
        default: 4
        source: nthreads
      - id: phred
        default: '64'
        source: phred
      - id: slidingwindow
        default: '4:15'
        source: slidingwindow
      - id: trailing
        default: 3
        source: trailing
      - id: trimmomatic_jar_path
        source: trimmomatic_jar_path
    out:
      - id: output_log_file
      - id: output_read1_trimmed_file
      - id: output_read1_trimmed_unpaired_file
      - id: output_read2_trimmed_paired_file
      - id: output_read2_trimmed_unpaired_file
    run: ../../tools/trimmomatic.cwl
    'sbg:x': 226.0625
    'sbg:y': 185.4296875
  - id: _s_t_a_r
    in:
      - id: genomeDir
        source: genomeDir
      - id: outBAMcompression
        default: -1
      - id: outFileNamePrefix
        default: sample
      - id: outSAMmode
        default: Full
      - id: outSAMtype
        default: BAM SortedByCoordinate
      - id: outStd
        default: Log
      - id: readFilesIn
        source:
          - trimmomatic/output_read2_trimmed_paired_file
          - trimmomatic/output_read2_trimmed_unpaired_file
          - trimmomatic/output_read1_trimmed_unpaired_file
          - trimmomatic/output_read1_trimmed_file
      - id: runMode
        default: alignReads
      - id: runThreadN
        default: 4
    out:
      - id: aligned
      - id: indices
      - id: mappingstats
      - id: readspergene
      - id: transcriptomesam
    run: ../../tools/STAR.cwl
    'sbg:x': 680.4754638671875
    'sbg:y': 266.7578125
requirements:
  - class: MultipleInputFeatureRequirement
