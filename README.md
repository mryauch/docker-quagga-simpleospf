# docker-quagga-simpleospf
This is a Docker container that auto detects the primary interface (the default route) and configures OSPF to run on that interface. This is useful on specialty Linux machines that require a default route, but more specific dynamic routes to other locations.
