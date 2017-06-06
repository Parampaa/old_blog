.PHONY: all clean

ASCIIDOCTOR = $(shell which asciidoctor)
HTML_FILES = $(shell find . -name "*.html" | sort | grep -v plan.html)
all: plan.adoc
	@$(ASCIIDOCTOR) -r asciidoctor-diagram -a data-uri $<

plan.adoc: $(HTML_FILES)
	sed -i '/* link:/d' $@ ;			     \
	for html in $(HTML_FILES); do  				 \
		name=$$html; 							 \
		name=`echo $$html | sed 's/\.\/\(.*\)\.html/\1/'`;     \
		html=`echo $$html | sed 's/\.\/\(.*\)/\1/'`;     \
		sed -i -e '$$a\* link:'"$$html[$$name]" $@ ;      \
	done
