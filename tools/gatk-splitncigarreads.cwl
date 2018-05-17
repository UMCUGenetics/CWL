class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: gatk_splitncigarreads
baseCommand:
  - java
inputs:
  - id: java_args
    type: string
    inputBinding:
      position: 1
      prefix: ''
  - id: gatk_jar
    type: File
    inputBinding:
      position: 2
      prefix: '-jar'
  - id: Reference
    type: File
    inputBinding:
      position: 4
      prefix: '-R'
  - id: input
    type: File?
    inputBinding:
      position: 5
      prefix: '-I'
  - id: output
    type: string?
    inputBinding:
      position: 6
      prefix: '-o'
  - id: input_1
    type: string?
    inputBinding:
      position: 7
      prefix: '-U'
outputs:
  - id: bam_out
    type: File?
    outputBinding:
      glob: $(inputs.output)
label: GATK-SplitNCigarReads
arguments:
  - position: 3
    prefix: '-T'
    valueFrom: SplitNCigarReads
requirements:
  - class: InlineJavascriptRequirement
'sbg:toolkit': GATK
'sbg:toolAuthor': Tilman Schaefers
'sbg:license': Apache 2.0
'sbg:wrapperAuthor': ''
'sbg:wrapperLicense': ''
'sbg:toolkitVersion': SplitNCigarReads
