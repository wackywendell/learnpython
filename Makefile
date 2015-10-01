all: pages/index.html pages/000-Syllabus.html pages/001-Intro.html pages/002-Basic_Python.html pages/003-Control_Structures.html pages/custom.css images

clean:
	rm pages/*
	rm imgs/*
	
ghp: all
	ghp-import -p pages

images:
	cp -ru imgs pages/imgs

pages/001-Intro.html: 001-Intro.ipynb
	jupyter nbconvert --to slides 001-Intro.ipynb --config slide_config.py --execute --reveal-prefix='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/2.6.2/'
	mv 001-Intro.slides.html pages/001-Intro.html

pages/000-Syllabus.html: 000-Syllabus.ipynb
		jupyter nbconvert --to html $< --execute
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/002-Basic_Python.html: 002-Basic_Python.ipynb
		jupyter nbconvert --to html $< --execute
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/003-Control_Structures.html: 003-Control_Structures.ipynb
		jupyter nbconvert --to html $< --execute
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

# pages/index.html: index.ipynb
# 		jupyter nbconvert --to html index.ipynb --execute
# 		mv index.html pages/index.html

pages/index.html: index.html
	cp index.html pages/

pages/custom.css: custom.css
	cp custom.css pages/
