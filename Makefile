CDN=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/2.6.2/
# CDN=https://cdn.bootcss.com/reveal.js/2.6.2

all: pages/index.html pages/000-Syllabus.html pages/001-Intro.html pages/Problems-001.html pages/Problems-002.html pages/002-Basic_Python.html pages/002-Basic_Python_actual.html pages/003-Control_Structures.html pages/custom.css images

clean:
	rm -f pages/*.html
	rm -f imgs/*
	
ghp: all
	ghp-import -p pages

images:
	cp -ru imgs pages/imgs
	cp -ru data pages/data

pages/001-Intro.html: 001-Intro.ipynb
	jupyter nbconvert --to slides 001-Intro.ipynb --config slide_config.py --execute --allow-errors --reveal-prefix="$(CDN)"
	mv 001-Intro.slides.html pages/001-Intro.html

pages/Problems-001.html: Problems-001.ipynb
		jupyter nbconvert --to html $< --execute
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/000-Syllabus.html: 000-Syllabus.ipynb
		jupyter nbconvert --to html $< --execute
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/002-Basic_Python.html: 002-Basic_Python.ipynb
		jupyter nbconvert --to html $< --execute --allow-errors
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/002-Basic_Python_actual.html: 002-Basic_Python_actual.ipynb
		jupyter nbconvert --to html $<
		mv $(addsuffix .html,$(basename $(notdir $<))) $@

pages/Problems-002.html: Problems-002.ipynb
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
