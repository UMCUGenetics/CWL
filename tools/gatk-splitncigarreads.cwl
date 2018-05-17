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
      position: 0
  - id: gatk_jar
    type: File
    inputBinding:
      position: 2
      prefix: '-jar'
      shellQuote: false
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
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
'sbg:license': Apache 2.0
'sbg:toolAuthor': Tilman Schaefers
'sbg:toolkit': GATK
'sbg:toolkitVersion': SplitNCigarReads
'sbg:wrapperAuthor': ''
'sbg:wrapperLicense': ''
