.PHONY: prebuild all clean push echo end

#asciidoctor-pdf -r asciidoctor-diagram -r asciidoctor-pdf-cjk-kai_gen_gothic -a pdf-style=KaiGenGothicCN $< > /dev/null 2>&1
ORG_FILES = $(shell find . -name "*.org")
ADOC_FILES = $(shell find . -name "*.adoc")
EMACS = $(shell which emacs)
ASCIIDOCTOR = $(shell which asciidoctor)

ORG_2_HTML = $(patsubst %.org, %.html, $(ORG_FILES))
ADOC_2_HTML = $(patsubst %.adoc, %.html, $(ADOC_FILES))
ADOC_2_PDF = $(patsubst %.adoc, %.pdf, $(ADOC_FILES))

all: $(ORG_2_HTML) $(ADOC_2_HTML) end

end:
	@$(MAKE) -C work/
	@$(MAKE) -C plan/

%.html: %.org
	@echo $(EMACS)
	@echo $<
	@$(EMACS) $< --batch -l ~/.emacs.d/init.el -f org-html-export-to-html --kill

%.html: %.adoc
	@echo $(ASCIIDOCTOR)
	@echo $<
	@$(ASCIIDOCTOR) -r asciidoctor-diagram -a data-uri $<

#%.pdf: %.adoc
	#asciidoctor-pdf -r asciidoctor-diagram -r asciidoctor-pdf-cjk-kai_gen_gothic -a pdf-style=KaiGenGothicCN $< > /dev/null 2>&1

pull:
	git pull

push:
	@find . -regex '.*html\~\|.*nouse.*\|.*\.cache' -exec rm -rf {} \;
	git add -A; git commit -m "--wip auto--"
	git push

clean:
	@find . -regex '.*html\~\|.*nouse.*\|.*\.cache' -exec rm -rf {} \;

