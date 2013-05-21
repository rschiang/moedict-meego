# -*- coding: utf-8 -*-
import json
import codecs
import re

source = codecs.open('dict-revised.unicode.json', encoding='utf-8', mode='r')
sourceJson = json.load(source)

index = {"title": [], "zhuyin": {}, "pinyin": {}}
ignore = [re.compile(x) for x in [r'\{\[[0-9a-f]{4}\]\}', u'\uDB40[\uDD00-\uDD0F]', r'[⿰⿸]']]

def ignoreEntry(title):
	for expr in ignore:
		if expr.search(title): return True
	return False

def addEntry(source, category, value):
	if not source: return
	if not source in index[category]:
		index[category][source] = []
	index[category][source].append(value)
	
for entry in sourceJson:
	title = entry['title']
	if ignoreEntry(title): continue

	for h in entry['heteronyms']:
		if 'bopomofo' in h: addEntry(h['bopomofo'], 'zhuyin', title)
		if 'pinyin' in h: addEntry(h['pinyin'], 'pinyin', title)
		# More index entries can be added here

	index['title'].append(title)

index['title'].sort()
target = codecs.open('../data/index.json', encoding='utf-8', mode='w+')
json.dump(index, target, ensure_ascii=False, indent=0, sort_keys=True)
