# JMeter test

`test_fragment.jmx`: JMeter test fragment that inclues the main test plan logic
`ramp_test_plan.jmx`: JMeter test plan with a predifined JMeter thread group controller linked to the above test fragment. This test plan requires the 'Prometheus Listener for Jmeter' plugin in the JMeter lib\ext folder.
`plateau_test_plan.jmx`: JMeter test plan with a predifined JMeter concurrency thread group controller linked to the above test fragment. This test plan requires the 'Prometheus Listener for Jmeter' and 'Concurrency Thread Group' plugins in the JMeter lib\ext folder.

test fragment and test plan files have to be in the same folder. The test can be executed using one of the 2 test plan as standard jmeter script (eg. `sh jmeter.sh -t ramp_test_plan.jmx`)

## Test fragment

![Test fragment](/jmeter_test/img/test_fragment.png)

1. Welcome (homepage)
2. Random category page x2
3. Random manufactor page x2
4. Random product page x5
5. Add to cart (last product)

after each request uniform random timer of `-JRANDOM_DELAY_MAX_MS` (default 100ms) and `-JCONSTANT_DELAY_OFFSET_MS` (default "150") is applied 

### Variables ###

* `-JTARGET_HOST` (default "localhost")
* `-JTARGET_PORT` (default "8780")
* `-JRANDOM_DELAY_MAX_MS` (default "100")
* `-JCONSTANT_DELAY_OFFSET_MS` (default "150")

## Ramp test plan ##

![Thread group](/jmeter_test/img/ramp_thread_group.png)

### Variables ###

* `-JTHREADS` (default "200")
* `-JRAMP_SEC` (default "200")

## Plateua test plan ##

![Thread group](/jmeter_test/img/plateau_thread_group.png)

### Variables ###

* `-JTHREADS`  (default "120")
* `-JRAMP_UP_MIN` (default "2")
* `-JRAMP_UP_COUNT`(default "120")
* `-JHOLD_MIN` (default "5")

