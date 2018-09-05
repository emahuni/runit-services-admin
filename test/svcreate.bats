#!/data/data/com.termux/file/usr/bin/env bats

SVDIRBCK=$SVDIR
SVDIR="$(pwd)/test/SVDIR"

service="$SVDIR/active/test_svcreate"

@test "svcreate: Creates a new service from given name and command" {
		# make sure the svdir is clean
		rm -rf "$SVDIR" echo.log

		run ./bin/svcreate test_svcreate 'sleep $sleeping'
		# echo $output > "./echo.log"
		[[ $status == "0" ]]
		[[ $output == *"service created successfully"* ]]
}

@test "svcreate: Verify new service files executability" {
		[[ -x "$service/run" ]]

		[[ -x "$service/finish" ]]

		# remove the following if next test is enabled
		# teardown
		rm -rf $SVDIR
		SVDIR=$SVDIRBCK
}

@test "svcreate: Verify new service by actually running it and stopping it" {
		skip "run cannot work well with runsv, (it is freezing) so I will need to try after updating bats"
		export fg=0
		export sleeping=30
		# run the service
		run runsv "$service" >/dev/null 2>&1
		# ( chpst runsv "$service" ) #>/dev/null 2>&1)
		echo $output > "./echo.log"

		# wait for it to initialize
		sleep 1

		# check it's status
		run sv status "$service"
		echo $output >> "./echo.log"
		[[ $status == "0" ]]
		[[ $output == *"run:"* ]]

		# stop the service
		run sv exit "$service"
		[[ $status == "0" ]]

		# teardown
		rm -rf $SVDIR
		SVDIR=$SVDIRBCK
}
