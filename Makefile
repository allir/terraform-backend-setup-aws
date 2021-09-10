STATE_FILE=./terraform.tfstate
ifneq ("$(wildcard $(STATE_FILE))","")
    BACKEND=$(shell terraform output backend | tr '\n' '\1')
	OUTPUT="backend \"s3\" $(BACKEND)"
else
    OUTPUT=Make sure to create resources first with \`terraform apply\`
endif


generate:
	@echo $(OUTPUT) | tr '\1' '\n'
