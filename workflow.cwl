class: Workflow
  inputs: []

  outputs:
    files:
      type: File
      outputSource: count/output

  steps:
	  list:
	    run: test.yaml
			in: []
			out: [my_output]

		count:
		  run: wc.yaml
			in:
			  test_file: list_step/my_output
	    out: [output]
