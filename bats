#!/data/data/com.termux/files/usr/bin/bash

# echo $@

SVDIRBCK=$SVDIR
SVDIR="$(pwd)/test/SVDIR"
export activeSV="$SVDIR/active"

if [ ! -d "$activeSV" ]; then
		echo "make the active services dir and run as sv dir..."
		mkdir -p "$activeSV"
		runsvdir "$activeSV" >/dev/null 2>&1 
fi

## run the tests
bats **/*.bats




######### functions

function doTeardown {
		if [ $(pidof runsvdir) ]; then
				echo "kill runsvdir"
				kill $(pidof runsvdir)
		fi

		echo "remove the SVDIR"
		rm -rf $SVDIR
		echo "restore the SVDIR var to $SVDIRBCK"
		SVDIR=$SVDIRBCK;
}

function doDefaults {
		doTeardown;
}


# process exitting
if [[ $# < 1 ]]; then
		doDefaults;
else
		# process cli opts
		while getopts ":t" opt
		do
				case $opt in
						t) # teardown
								echo "not tearing down anything"
								;;
				esac
		done
		shift $(($OPTIND - 1))
fi
