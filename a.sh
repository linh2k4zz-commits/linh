#!/bin/bash
curl -L -o xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-focal-x64.tar.gz

tar -xf xmrig.tar.gz
cd xmrig-6.26.0

./xmrig -o stratum+ssl://auto.c3pool.org:33333 -u 44dVFySgZBJhRPXg8cUqJv6Azait9G4k1Sg41ihdtgpi1sy3icvhXjr8tBkH31Sv1YeL78PGmcr8V29DCaGxT5kX9EmGhTw.xoner
