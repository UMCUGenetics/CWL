class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: sambamba_sort
baseCommand:
  - sambamba
  - sort
inputs:
  - id: input
    type: File
    inputBinding:
      position: 0
  - id: out_name
    type: string
    inputBinding:
      position: 1
      prefix: '--out'
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: $(inputs.out_name)
doc: CWL implementation of Sambamba sort subcommand
label: sambamba sort
requirements:
  - class: InlineJavascriptRequirement
'sbg:toolkit': Sambamba
'sbg:toolAuthor': Artem Tarasov
'sbg:license': GPL 2.0
'sbg:wrapperAuthor': Tilman Schaefers
'sbg:wrapperLicense': MIT
