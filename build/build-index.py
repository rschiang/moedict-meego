import json
import os
import codecs

source = codecs.open('dict-revised.unicode.json', encoding='utf-8', mode='r')
sourceJson = json.load(source)

index = []
for entry in sourceJson:
	index.append(entry['title'])

target = codecs.open('../data/index.json', encoding='utf-8', mode='w+')
json.dump(index, target)
