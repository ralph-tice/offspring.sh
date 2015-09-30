# offspring.sh
Interpolate bash / POSIX style environment variables into config files

### Tests

To run tests requires bats.  Either `brew install bats` or install from the [source](https://github.com/sstephenson/bats)

It would also require there to be tests.  TODO, PRs welcome!

### Motivation

I found a similar but specific script for [managing server.properties](https://github.com/wurstmeister/kafka-docker/blob/master/start-kafka.sh) for Kafka which fortunately is also Apache licensed.  The main problem is establishing the interface between the orchestrator launching a container and the service running within the container.  This script attempts to result in simple `cp` or `wget` into a repo and a resulting one-liner invocation in a Dockerfile, not counting whatever variables need to be set.

This means the initial version of this script is specific to [java.util.Properties style file formats](https://en.wikipedia.org/wiki/.properties).

Very soon this will also support Typesafe Config file format, which will be basically JSON.

In the future I intend to add support for TOML.  That might mean different scripts in order to keep things simple, but worst case we'll generate the appropriate bash script.
