curl.exe -L -o xmrig.zip https://github.com/xmrig/xmrig/releases/download/v6.26.0/xmrig-6.26.0-windows-x64.zip

Expand-Archive -Path xmrig.zip -DestinationPath . -Force

cd xmrig-6.26.0

.\xmrig.exe -o stratum+ssl://auto.c3pool.org:33333 -u 44dVFySgZBJhRPXg8cUqJv6Azait9G4k1Sg41ihdtgpi1sy3icvhXjr8tBkH31Sv1YeL78PGmcr8V29DCaGxT5kX9EmGhTw.xoner
