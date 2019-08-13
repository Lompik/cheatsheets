# * Port forwading
# The AllowTcpForwarding option in the OpenSSH server configuration file must be enabled on the server to allow port forwarding.
$ `-N` => Do not execute a remote command.  This is useful for just forwarding ports. (blocks)
# ** local
$ ssh -N -L 80:intra.example.com:80 gw.example.com
# local:80 -> gw.example.com -> intra.example.com:80
# This example opens a connection to the gw.example.com jump server, and forwards any connection to port 80 on the local machine to port 80 on intra.example.com.
# * Remote forwarding
$ ssh -R 8080:localhost:80 public.example.com
# pubexa:8080 -> localhost:80
# This allows anyone on the remote server to connect to TCP port 8080 on the remote server. The connection will then be tunneled back to the client host, and the client then makes a TCP connection to port 80 on localhost. Any other host name or IP address could be used instead of localhost to specify the host to connect to.