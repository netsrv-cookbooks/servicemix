@test 'base installation directory exists' {
	[ -d /usr/local/smix/ ]
}

@test 'servicemix 5.1.0 exists in expected location' {
	[ -d /usr/local/smix/apache-servicemix-5.1.0 ]
}

@test 'a symlink is created to reference the installation' {
	run readlink /usr/local/smix/current
	[ "$status" -eq 0 ]
  [ "$output" = '/usr/local/smix/apache-servicemix-5.1.0' ]
}