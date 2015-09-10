all: pages/index.html pages/000-Syllabus.html pages/001-Intro.html pages/custom.css
	
ghp: all
	ghp-import -p pages

pages/001-Intro.html: 001-Intro.ipynb
	jupyter nbconvert --to slides 001-Intro.ipynb --config slide_config.py --execute --reveal-prefix='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/2.6.2/'
	mv 001-Intro.slides.html pages/001-Intro.html

pages/000-Syllabus.html: 000-Syllabus.ipynb
		jupyter nbconvert --to html 000-Syllabus.ipynb --execute
		mv 000-Syllabus.html pages/000-Syllabus.html

pages/index.html: index.ipynb
		jupyter nbconvert --to html index.ipynb --execute
		mv index.html pages/index.html

pages/custom.css: custom.css
	cp custom.css pages/
