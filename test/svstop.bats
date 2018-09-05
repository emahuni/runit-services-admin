#!/data/data/com.termux/file/usr/bin/env bats

service="$activeSV/test_svstop"

# copy the test service to the active runsvdir
cp -rf ./test/fixtures/testsv $service

@test "svstop: Verify service status before and after stopping it" {
		# skip
		# wait a bit for the service to initialise
		sleep 5

		# check it's status
		run sv status "$service"
		# echo $output >> "./echo.log"
		[[ $status == "0" ]]
		[[ $output == *"run:"* ]]

		sleep 1
		# stop the service
		run ./bin/svstop "$service"

		sleep 1
		# check it's status
		run sv status "$service"
		# echo $output >> "./echo.log"
		[[ $status == "0" ]]
		[[ $output == *"down:"* ]]
}
