"""
Arguments

file: 		the file to be printed (obligatory)
copies: 	number of copies
duplex:		choose 's' for single and 'd' for duplex

The script requires packages paramiko and scp (both can be installed using pip).
"""

# ---------------------------------------------------------

# In the file .printConfig.cfg you need to change your personal information
# print server and username, eventually printer names.

PRINTER_GRAY = "lj4a"												# printer name for gray-scale printing
PRINTER_COLOUR = "copy4a"											# printer name for colourful printing
PRINTER_DUPLEX = "copy4a-duplex -o sides=two-sided-long-edge"		# duplex option

# ---------------------------------------------------------

import os
import sys
import re
import configparser

import argparse
parser = argparse.ArgumentParser()
parser.add_argument('file', metavar='file', type=str, help='the file to be printed')
parser.add_argument('-n', '--number', type=int, help='number of copies', default=1)
parser.add_argument('-c', '--colour', help='colourful printing', action='store_true', default=False)
parser.add_argument('-d', '--duplex', help='duplex printing', action='store_true', default=False)

def error(msg):
	print(msg)
	sys.exit(1)

def SSHerrorPrint(ssh_stderr):
	print("SSH error output:")
	error = ssh_stderr.read().decode('utf-8').strip("\n")
	if error:
		print(error)
	else:
		print("No errors.")
	print("-" * 20)

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
	#print(FOLDER + os.path.basename(file))
	sftp.put(file, FOLDER + os.path.basename(file))

	# print the file
	ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("lpr -P " + printer + " -# " + str(copies) + " " + FOLDER + re.escape(os.path.basename(file)))
	#print("lpr -P " + printer + " -# " + str(copies) + " " + FOLDER + re.escape(os.path.basename(file)))
	SSHerrorPrint(ssh_stderr)

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

	config = configparser.ConfigParser()
	config.read('.printConfig.cfg')
	USER, FOLDER, SERVER = list(zip(*config.items('DEFAULT')))[1]

	if args.number:
		copies=args.number
	else:
		copies=1

	if args.colour:
		if args.duplex:
			printFile(args.file, PRINTER_DUPLEX, copies)
		else:
			printFile(args.file, PRINTER_COLOUR, copies)
	else:
		if args.duplex:
			printFile(args.file, PRINTER_DUPLEX, copies)
		else:
			printFile(args.file, PRINTER_GRAY, copies)