#!/bin/bash

# -----------------------------------------------------------------------------
# all_tcp_udp: show all listening TCP/UDP ports
# -----------------------------------------------------------------------------

all_tcp_udp() {
lsof -Pan -i tcp -i udp
}
