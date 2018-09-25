#!/usr/bin/python

import sys
import yaml

#emote rules in gesture, others would be in gesture function
emotions = {"worry", "happySurprise", "happy.001", "recoil", "happyDisgust" 
						"happy", "surprisedSad", "surprised", "sad", "irritated", "happy.002", 
						"fearSuprise", "fear", "engaged", "disgustSurprise", 
						"disgust.Sad", "disgust", "contempt", "confused", "comprehending", 
						"bored", "awe", "angrySad", "angryDisgust", "angry", "amused", "none"}

def main():
	if (len(sys.argv) == 3):
		ghost = open(str(sys.argv[2]), "a+")
	else:
		ghost = open("output.ghost", "a+")
	with open(str(sys.argv[1]), 'r') as f:
		x = yaml.load(f)
		for key, value in x.items():
			i = 0
			while i < len(value):
				ghost.write("u: " + value[i].get("name") + '{}' .format(i+1) + " () ")
				for k in value[i].keys():
					if (k == "start_time"):
						ghost.write("^start_timer(" + '{}' .format(value[i].get(k)) + ") ")
					if (k == "gesture"):
						ghost.write("^gesture(")
						if (value[i].get(k) in emotions):
							mag = ', '.join(str(e) for e in value[i].get("magnitude"))
							ghost.write(value[i].get(k) + ", " + mag + ", " + '{}' .format(value[i].get("duration")) + ")")
						else:
							mag = ', '.join(str(e) for e in value[i].get("magnitude"))
							ghost.write(value[i].get(k) + ", " + '{}' .format(value[i].get("speed")) + ", " + mag + ")")		
					if (k == "text"):
						# Removing of some <> entries from YAML
						textval = value[i].get(k)
						textval = textval.replace('</usel>','')
						textval = textval.replace('<usel variant=','')
						textval = textval.replace('">','')
						textval = textval.replace('"','')
						ghost.write('{}' .format(textval) + " ")
				ghost.write("\n\n")
				i += 1
	print("Timeline rules converted to a file named " + ghost.name)
	f.close()
	ghost.close()

if __name__ == '__main__':
	main()