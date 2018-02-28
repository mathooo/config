# Requirements
# ssh key

# Parameters
# $1 - filename

FOLDER="/home/xtrojak/tisk/"	# location where files are stored on external adress
SERVER="anxur.fi.muni.cz"		# server adress
USER="xtrojak"					# user name on the server
PRINTER="lj4a"					# printer name

function printFI {
	echo "Sending ..."
	scp "$1" $USER"@"$SERVER":"$FOLDER
	echo "Your document is being printed."
	ssh $USER"@"$SERVER "lpr -P"$PRINTER" "$FOLDER"`basename "$1"`"
}

printFI $1