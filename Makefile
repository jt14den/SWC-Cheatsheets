all:
	pandoc --css notes.css -H header.html -o html/git-novice.html git-novice.md
	pandoc --css notes.css -H header.html -o html/shell-novice.html shell-novice.md
	pandoc --css notes.css -H header.html -o html/Setting_up.html Setting_up.md
	pandoc --css notes.css -H header.html -o html/r-novice-gapminder2.html r-novice-gapminder2.md
	pandoc --css notes.css -H header.html -o html/template.html template.md