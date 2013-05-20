# -*- coding: utf-8 -*-
import json
import codecs
import re

source = codecs.open('dict-revised.unicode.json', encoding='utf-8', mode='r')
sourceJson = json.load(source)

index = []
ignore = [re.compile(x) for x in [r'\{\[[0-9a-f]{4}\]\}', u'\uDB40[\uDD00-\uDD0F]', r'[⿰⿸]']]

def ignoreEntry(title):
	for expr in ignore:
		if expr.search(title): return True
	return False
	
for entry in sourceJson:
	if ignoreEntry(entry['title']): continue
	index.append(entry['title'])

target = codecs.open('../data/index.json', encoding='utf-8', mode='w+')
json.dump(index, target, ensure_ascii=False, indent=0)
