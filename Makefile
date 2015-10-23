CDN=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/2.6.2/
# CDN=https://cdn.bootcss.com/reveal.js/2.6.2

all: pages/index.html \
	pages/000-Syllabus.html \
	pages/001-Intro.html \
	pages/Problems-001.html \
	pages/Problems-002.html \
	pages/Problems-003.html \
	pages/Answers-003.html \
	pages/002-Basic_Python.html \
	pages/002-Basic_Python_actual.html \
	pages/003-Control_Structures.html \
	pages/custom.css \
	pages/CNAME \
	images

clean:
	rm -f pages/*.html
	rm -f pages/*.css
	rm -f pages/imgs/*
	rm -f pages/data/*
	
ghp: all
	ghp-import -p pages

images:
	cp -ru imgs pages/
	cp -ru data pages/

# Generic rule: executes the notebook, and produces an HTML.
pages/%.html: %.ipynb
	jupyter nbconvert --to html $< --execute
	mv $(addsuffix .html,$(basename $(notdir $<))) $@

# The intro is in slide format, so it gets a special rule.
pages/001-Intro.html: 001-Intro.ipynb
	jupyter nbconvert --to slides 001-Intro.ipynb --config slide_config.py --execute --allow-errors --reveal-prefix="$(CDN)"
	mv 001-Intro.slides.html pages/001-Intro.html
	
# This notebook has errors on purpose, so we allow that.
pages/002-Basic_Python.html: 002-Basic_Python.ipynb
		jupyter nbconvert --to html $< --execute --allow-errors
		mv $(addsuffix .html,$(basename $(notdir $<))) $@
		
# This notebook has errors on purpose, so we allow that.
pages/003-Control_Structures.html: 003-Control_Structures.ipynb
		jupyter nbconvert --to html $< --execute --allow-errors
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

# This notebook we want represented exactly as done in class, without execution.
pages/002-Basic_Python_actual.html: 002-Basic_Python_actual.ipynb
		jupyter nbconvert --to html $<
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/index.html: index.html
	cp index.html pages/

pages/custom.css: custom.css
	cp custom.css pages/

pages/CNAME: CNAME
	cp CNAME pages/
