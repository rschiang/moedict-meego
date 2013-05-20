moedict-data ::
	-git clone --depth 1 https://github.com/g0v/moedict-data.git

moedict-epub ::
	-git clone --depth 1 https://github.com/g0v/moedict-epub.git

source :: moedict-data moedict-epub
	ln -fs ../moedict-data/dict-revised.json moedict-epub/dict-revised.json
	cd moedict-epub && perl json2unicode.pl             > dict-revised.unicode.json

index :: source
	ln -fs ../moedict-epub/dict-revised.unicode.json build/dict-revised.unicode.json
	mkdir data
	cd build && python build-index.py
