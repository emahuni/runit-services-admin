#!/data/data/com.termux/file/usr/bin/env bats

SVDIRBCK=$SVDIR
SVDIR=./test/fixtures

service="$SVDIR/active/test_svcreate"

@test "Creates a new service from given name and command" {
		# make sure the fixtures dir is clean
		rm -rf "$service"

		run ./bin/svcreate test_svcreate '-a test_svcreate sleep 1000000'
		[[ $status == "0" ]]
		echo "output: $output"
		[[ $output == *"created"* ]]
}

@test "Verify the actual service files" {
		[[ -x "$service/run" ]]

		[[ -x "$service/finish" ]]
}

@test "Verify the service by actually running it and stopping it" {
		# run the service
		run runsv "$service"
		[[ $status == "0" ]]

		# check it's status
		run sv status "$service"
		[[ $status == "0" ]]
		[[ $output == *"run:"* ]]

		# stop the service
		run sv exit "$service"
		[[ $status == "0" ]]

		# delete the service
		rm -rf "$service"
}
