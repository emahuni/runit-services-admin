#!/data/data/com.termux/file/usr/bin/env bats

SVDIRBCK=$SVDIR
SVDIR=./test/fixtures

@test "Creates a new service from given name and command" {
		skip "feature not yet implemented"
}

@test "Starts a fresh new service (never ran before)" {
		skip "test is wip"
		
		rm -rf $SVDIR/testsv/supervise/
		# if [ -d "$SVDIR/testsv" ]; then echo "svc dir exists"; fi

		run sv status $SVDIR/testsv
		echo "output: $output"
		[[ $output == *"warning"* ]]
}

@test "reRuns a downed service" {
		skip "test not yet implemented"
}


@test "reRuns an erred service (it was killed but left a run status)" {
		skip "test not yet implemented"
}

