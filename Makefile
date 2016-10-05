all:
	pandoc --css notes.css -o html/git-novice.html git-novice.md
	pandoc --css notes.css -o html/shell-novice.html shell-novice.md
	pandoc --css notes.css -o html/Setting_up.html Setting_up.md
