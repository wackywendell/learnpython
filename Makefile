all: pages/index.html pages/000-Syllabus.html pages/001-Intro.html pages/custom.css images
	
ghp: all
	ghp-import -p pages

images:
	cp -ru imgs pages/imgs

002-Basic Python.html: 001-Intro.ipynb
	jupyter nbconvert --to slides $? --config slide_config.py --execute --reveal-prefix='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/2.6.2/'
	mv 001-Intro.slides.html pages/001-Intro.html

pages/001-Intro.html: 001-Intro.ipynb
	jupyter nbconvert --to slides 001-Intro.ipynb --config slide_config.py --execute --reveal-prefix='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/2.6.2/'
	mv 001-Intro.slides.html pages/001-Intro.html

pages/000-Syllabus.html: 000-Syllabus.ipynb
		jupyter nbconvert --to html $< --execute
		mv $(basename $(notdir $<)) $@

# pages/index.html: index.ipynb
# 		jupyter nbconvert --to html index.ipynb --execute
# 		mv index.html pages/index.html

pages/index.html: index.html
	cp index.html pages/

pages/custom.css: custom.css
	cp custom.css pages/
