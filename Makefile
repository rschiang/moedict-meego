moedict-data ::
	@if [ ! -d moedict-data ]; then \
		-git clone --depth 1 https://github.com/g0v/moedict-data.git; \
	fi

moedict-epub ::
	@if [ ! -d moedict-epub ]; then \
		-git clone --depth 1 https://github.com/g0v/moedict-epub.git; \
	fi

update :: moedict-data moedict-epub
	cd moedict-data && git pull origin master && git checkout
	cd moedict-epub && git pull origin master && git checkout

source :: moedict-data moedict-epub
	ln -fs ../moedict-data/dict-revised.json moedict-epub/dict-revised.json
	cd moedict-epub && perl json2unicode.pl             > dict-revised.unicode.json

index ::
	@if [ ! -e build/dict-revised.unicode.json ]; then \
		make source; \
		ln -fs ../moedict-epub/dict-revised.unicode.json build/dict-revised.unicode.json; \
	fi
	-mkdir -p data
	cd build && python build-index.py
