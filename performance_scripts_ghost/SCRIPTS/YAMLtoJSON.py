import os
import re

def main():

	# change the directories manually for now
	yaml = open("1.yaml","r") 
	json = open("1.json", "a+")
	json.write("{\n")
	if yaml.mode == 'r':
		j = True # To avoid first time entry (TODO: should be dealt better)
		for x in yaml:
			if (x.startswith("  -") and not "nodes:" in x):
				json.seek(-2, os.SEEK_END)
				json.truncate()
				if j:
					json.write("\n{\n\t")
					writeValue(json, x)
					j = False 
				else:
					json.write("\n},\n{\n\t")
					writeValue(json, x)
			elif "magnitude:" in x: #for magnitude (TODO: needs to be done a better way)
				json.write("\t\"magnitude\": [ \n")
				x = yaml.next()
				x = x[8:]
				str1 = ","
				x = "  {0},".format(x)
				var = x
				x = yaml.next()
				x = x[8:]
				value = "\t" + var + "\t  " + x + "\t],\n"
				json.write(value)
			elif not " - " in x and ":" in x and x != "\n" and not "nodes:" in x:
				json.write("\t")
				writeValue(json, x)			

	json.write("}\n")

def hasNumbers(inputString):
    return bool(re.search(r'\d', inputString))

def writeValue(json, x):
	x = x.rstrip()
	x = x[4:]
	xkey, xvalue = x.split(":")
	if not re.search(r'[a-z]', xvalue) and re.search(r'\d', xvalue):
		var = "\"" + xkey + "\": " + xvalue + ",\n"
	else:
		var = "\"" + xkey + "\": " + "\"" + xvalue + "\",\n"
	json.write(var)

if __name__ == "__main__":
	main()