#!/bin/bash

docker run --rm --name jmeter -i -v `pwd`:/tmp -w /tmp -p 9270:9270 chiabre/jmeter_plugins -t ramp_test_plan.jmx -JTARGET_HOST=localhost

