"""
Arguments

file: 		the file to be printed (obligatory)
copies: 	number of copies
duplex:		choose 's' for single and 'd' for duplex
"""

# ---------------------------------------------------------

# The following constants can be edited according to the specific location of files, 
# print server and username, eventually printer names.

USER = "xtrojak"													# user name on the server
FOLDER = "/home/xtrojak/tisk/"										# location where files are stored on external adress
SERVER = "anxur.fi.muni.cz"											# server adress
PRINTER_SINGLE = "lj4a"												# printer name for simple printing
PRINTER_DUPLEX = "copy4a-duplex -o sides=two-sided-long-edge"		# printer name for duplex printing

# ---------------------------------------------------------

import os
import sys

"""
Function handleArguments

Parses given 'arguments'.
First it tries whether given argument is a number => it is number of copies
Then it tests whether given argument is one of "s" or "d" and sets Boolean variable duplex accordingly.

return: both number of copies and variable indicating single/duplex print method
"""
def handleArguments(arguments):
	copies = 1
	duplex = False
	for arg in arguments:
		try:
			copies = int(arg)
		except ValueError:
			print("yes")
			if arg in ["s", "d"]:
				duplex = True if arg == "d" else False
			else:
				raise ValueError("Unknown option '" + arg + "'.")
	return copies, duplex

"""
Function printFile

Sends given 'file' using SCP to FOLDER on the SERVER. It is neccessary to have a SSH key on the SERVER for the USER.
Using SSH connects to the SERVER and prints given 'file'.

return: None
"""
def printFile(file, printer, copies):
	os.system("scp " + file + " " + USER + "@" + SERVER + ":" + FOLDER)
	os.system("ssh " + USER + "@" + SERVER + " \"lpr -P " + printer + " -# " + str(copies) + " " + FOLDER + os.path.basename(file) + "\"")

copies, duplex = handleArguments(sys.argv[2:])

if duplex:
	printFile(sys.argv[1], PRINTER_DUPLEX, copies)
else:
	printFile(sys.argv[1], PRINTER_SINGLE, copies)