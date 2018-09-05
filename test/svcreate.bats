#!/data/data/com.termux/file/usr/bin/env bats

SVDIRBCK=$SVDIR
SVDIR="$(pwd)/test/SVDIR"

service="$SVDIR/active/test_svcreate"

@test "svcreate: Creates a new service from given name and command" {
		# make sure the fixtures dir is clean
		rm -rf "$service"

		run ./bin/svcreate test_svcreate '-a test_svcreate sleep 1000000'
		# echo $output > "./out.log"
		[[ $status == "0" ]]
		[[ $output == *"service created successfully"* ]]
}

@test "svcreate: Verify service files executability" {
		[[ -x "$service/run" ]]

		[[ -x "$service/finish" ]]
}

@test "svcreate: Verify the service by actually running it and stopping it" {
		skip "wip"
		fg="1";
		# run the service
		run runsv "$service"
		echo $output >> "./out.log"
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
