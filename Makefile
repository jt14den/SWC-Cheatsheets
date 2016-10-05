all:
	pandoc --css notes.css -o git-novice.html git-novice.md
	pandoc --css notes.css -o shell-novice.html shell-novice.md
	pandoc --css notes.css -o Setting_up.html Setting_up.md
