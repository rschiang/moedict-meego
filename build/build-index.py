import json
import os


source = open("../moedict-data/dict-revised.json")
sourceJson = json.load(source)

index = []
for entry in sourceJson:
	index.append(entry.title)

target = open("../data/index.json", "w")
json.dump(index, target)
