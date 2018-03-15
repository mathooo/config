"""
Arguments

file: 		the file to be printed (obligatory)
copies: 	number of copies
duplex:		choose 's' for single and 'd' for duplex

The script requires packages paramiko and scp (both can be installed using pip).
"""

# ---------------------------------------------------------

# The following constants can be edited according to the specific location of files, 
# print server and username, eventually printer names.

USER = "username"													# user name on the server
FOLDER = "/home/username/folder/"										# location where files are stored on external adress
SERVER = "anxur.fi.muni.cz"											# server adress
PRINTER_SINGLE = "lj4a"												# printer name for simple printing
PRINTER_DUPLEX = "copy4a-duplex -o sides=two-sided-long-edge"		# printer name for duplex printing

# ---------------------------------------------------------

import os
import sys

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('--file', help='the file to be printed')
parser.add_argument('--copies', type=int, help='number of copies', default=1)
parser.add_argument('--duplex', help='choose for duplex', default=False)

def error(msg):
	print(msg)
	sys.exit(1)

try:
	from paramiko import SSHClient
except ImportError:
	error("Package 'paramiko' is required.")
try:
	from scp import SCPClient
except ImportError:
	error("Package 'scp' is required.")

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
	ssh = SSHClient() 
	ssh.load_system_host_keys()

	# connect to the server
	ssh.connect(SERVER, username=USER)
	sftp = ssh.open_sftp()

	# copy the file
	sftp.put(file, FOLDER + os.path.basename(file))

	# print the file
	ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("lpr -P " + printer + " -# " + str(copies) + " " + FOLDER + os.path.basename(file))
	print(ssh_stderr)

	sftp.close()
	ssh.close()

if __name__ == '__main__':
  args = parser.parse_args()
  try:
    from paramiko import SSHClient
  except ImportError:
    error("Package 'paramiko' is required.")
  try:
    from scp import SCPClient
  except ImportError:
    error("Package 'scp' is required.")

  if args.copies:
    copies=args.copies
  else:
    copies=1

  if args.duplex:
    printFile(args.file, PRINTER_DUPLEX, copies)
  else:
    printFile(args.file, PRINTER_SINGLE, copies)
  	