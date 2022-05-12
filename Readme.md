# PiAware relay

This project aims to create a docker image that can be configured and deployed to read from an 
existing adsb feeder (in my case, a [ADSBx Custom Pi Image](https://www.adsbexchange.com/how-to-feed/adsbx-custom-pi-image/)) 
that exposes a dump server in port 30005, so it can consume and forward that data to [flightaware.com](https://flightaware.com/) 
(and get that enterprise level license).

Huge thanks to [abcd567a](https://github.com/abcd567a) for providing deb packages to be able to [install Piaware on 
arm64 based platforms](https://github.com/abcd567a/rpi) like the Raspberry Pi4.

## Build

```shell
DOCKER_BUILDKIT=1 docker build --target piaware -t technomike/piaware-relay .
```