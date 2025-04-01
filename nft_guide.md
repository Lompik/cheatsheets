<!-- -*- mode: markdown; -*- -->

Quick reference-nftables in 10 minutes
======================================

From nftables wiki

Jump to: [navigation](#column-one), [search](#searchInput)

Find below some basic concepts to know before using nftables.

**table** refers to a container of [chains](/wiki-nftables/index.php/Configuring_chains "Configuring chains") with no specific semantics.

**chain** within a [table](/wiki-nftables/index.php/Configuring_tables "Configuring tables") refers to a container of [rules](/wiki-nftables/index.php/Simple_rule_management "Simple rule management").

**rule** refers to an action to be configured within a _chain_.



Contents
--------

*   [1 nft command line](#nft_command_line)
    *   [1.1 Tables](#Tables)
    *   [1.2 Chains](#Chains)
    *   [1.3 Rules](#Rules)
        *   [1.3.1 Matches](#Matches)
            *   [1.3.1.1 Ip](#Ip)
            *   [1.3.1.2 Ip6](#Ip6)
            *   [1.3.1.3 Tcp](#Tcp)
            *   [1.3.1.4 Udp](#Udp)
            *   [1.3.1.5 Udplite](#Udplite)
            *   [1.3.1.6 Sctp](#Sctp)
            *   [1.3.1.7 Dccp](#Dccp)
            *   [1.3.1.8 Ah](#Ah)
            *   [1.3.1.9 Esp](#Esp)
            *   [1.3.1.10 Comp](#Comp)
            *   [1.3.1.11 Icmp](#Icmp)
            *   [1.3.1.12 Icmpv6](#Icmpv6)
            *   [1.3.1.13 Ether](#Ether)
            *   [1.3.1.14 Dst](#Dst)
            *   [1.3.1.15 Frag](#Frag)
            *   [1.3.1.16 Hbh](#Hbh)
            *   [1.3.1.17 Mh](#Mh)
            *   [1.3.1.18 Rt](#Rt)
            *   [1.3.1.19 Vlan](#Vlan)
            *   [1.3.1.20 Arp](#Arp)
            *   [1.3.1.21 Ct](#Ct)
            *   [1.3.1.22 Meta](#Meta)
        *   [1.3.2 Statements](#Statements)
            *   [1.3.2.1 Verdict statements](#Verdict_statements)
            *   [1.3.2.2 Log](#Log)
            *   [1.3.2.3 Reject](#Reject)
            *   [1.3.2.4 Counter](#Counter)
            *   [1.3.2.5 Limit](#Limit)
            *   [1.3.2.6 Nat](#Nat)
            *   [1.3.2.7 Queue](#Queue)
    *   [1.4 Extras](#Extras)
        *   [1.4.1 Export Configuration](#Export_Configuration)
        *   [1.4.2 Monitor Events](#Monitor_Events)
*   [2 Nft scripting](#Nft_scripting)
    *   [2.1 List ruleset](#List_ruleset)
    *   [2.2 Flush ruleset](#Flush_ruleset)
    *   [2.3 Load ruleset](#Load_ruleset)
*   [3 Examples](#Examples)
    *   [3.1 Simple IP/IPv6 Firewall](#Simple_IP.2FIPv6_Firewall)

nft command line
================

_nft_ is the command line tool in order to interact with nftables at userspace.

Tables
------

**family** refers to a one of the following table types: _ip_, _arp_, _ip6_, _bridge_, _inet_, _netdev_.

% nft list tables [<family>]
% nft list table [<family>] <name> [-n] [-a]
% nft (add | delete | flush) table [<family>] <name>

The argument _-n_ shows the addresses and other information that uses names in numeric format. The _-a_ argument is used to display the _handle_.

Chains
------

**type** refers to the kind of chain to be created. Possible types are:

*   _filter_: Supported by _arp_, _bridge_, _ip_, _ip6_ and _inet_ table families.
*   _route_: Mark packets (like mangle for the _output_ hook, for other hooks use the type _filter_ instead), supported by _ip_ and _ip6_.
*   _nat_: In order to perform Network Address Translation, supported by _ip_ and _ip6_.

**hook** refers to an specific stage of the packet while it's being processed through the kernel. More info in [Netfilter hooks](/wiki-nftables/index.php/Netfilter_hooks "Netfilter hooks").

*   The hooks for _ip_, _ip6_ and _inet_ families are: _prerouting_, _input_, _forward_, _output_, _postrouting_.
*   The hooks for _arp_ family are: _input_, _output_.
*   The _bridge_ family handles ethernet packets traversing bridge devices.
*   The hook for _netdev_ is: _ingress_.

**priority** refers to a number used to order the chains or to set them between some Netfilter operations. Possible values are: _NF\_IP\_PRI\_CONNTRACK\_DEFRAG (-400)_, _NF\_IP\_PRI\_RAW (-300)_, _NF\_IP\_PRI\_SELINUX\_FIRST (-225)_, _NF\_IP\_PRI\_CONNTRACK (-200)_, _NF\_IP\_PRI\_MANGLE (-150)_, _NF\_IP\_PRI\_NAT\_DST (-100)_, _NF\_IP\_PRI\_FILTER (0)_, _NF\_IP\_PRI\_SECURITY (50)_, _NF\_IP\_PRI\_NAT\_SRC (100)_, _NF\_IP\_PRI\_SELINUX\_LAST (225)_, _NF\_IP\_PRI\_CONNTRACK\_HELPER (300)_.

**policy** is the default verdict statement to control the flow in the chain. Possible values are: _accept_, _drop_, _queue_, _continue_, _return_.

% nft (add | create) chain [<family>] <table> <name> [ { type <type> hook <hook> [device <device>] priority <priority> \; [policy <policy> \;] } ]
% nft (delete | list | flush) chain [<family>] <table> <name>
% nft rename chain [<family>] <table> <name> <newname>

Rules
-----

**handle** is an internal number that identifies a certain _rule_.

**position** is an internal number that is used to insert a _rule_ before a certain _handle_.

% nft add rule [<family>] <table> <chain> <matches> <statements>
% nft insert rule [<family>] <table> <chain> [position <position>] <matches> <statements>
% nft replace rule [<family>] <table> <chain> [handle <handle>] <matches> <statements>
% nft delete rule [<family>] <table> <chain> [handle <handle>]

### Matches

**matches** are clues used to access to certain packet information and create filters according to them.

#### Ip

ip match

_dscp <value>_

ip dscp cs1
ip dscp != cs1
ip dscp 0x38
ip dscp != 0x20
ip dscp {cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, af11, af12, af13, af21,
af22, af23, af31, af32, af33, af41, af42, af43, ef}

_length <length>_

Total packet length

ip length 232
ip length != 233
ip length 333-435
ip length != 333-453
ip length { 333, 553, 673, 838}

_id <id>_

IP ID

ip id 22
ip id != 233
ip id 33-45
ip id != 33-45
ip id { 33, 55, 67, 88 }

_frag-off <value>_

Fragmentation offset

ip frag-off 222
ip frag-off != 233
ip frag-off 33-45
ip frag-off != 33-45
ip frag-off { 33, 55, 67, 88 }

_ttl <ttl>_

Time to live

ip ttl 0
ip ttl 233
ip ttl 33-55
ip ttl != 45-50
ip ttl { 43, 53, 45 }
ip ttl { 33-55 }

_protocol <protocol>_

Upper layer protocol

ip protocol tcp
ip protocol 6
ip protocol != tcp
ip protocol { icmp, esp, ah, comp, udp, udplite, tcp, dccp, sctp }

_checksum <checksum>_

IP header checksum

ip checksum 13172
ip checksum 22
ip checksum != 233
ip checksum 33-45
ip checksum != 33-45
ip checksum { 33, 55, 67, 88 }
ip checksum { 33-55 }

_saddr <ip source address>_

Source address

ip saddr 192.168.2.0/24
ip saddr != 192.168.2.0/24
ip saddr 192.168.3.1 ip daddr 192.168.3.100
ip saddr != 1.1.1.1
ip saddr 1.1.1.1
ip saddr & 0xff == 1
ip saddr & 0.0.0.255 < 0.0.0.127

_daddr <ip destination address>_

Destination address

ip daddr 192.168.0.1
ip daddr != 192.168.0.1
ip daddr 192.168.0.1-192.168.0.250
ip daddr 10.0.0.0-10.255.255.255
ip daddr 172.16.0.0-172.31.255.255
ip daddr 192.168.3.1-192.168.4.250
ip daddr != 192.168.0.1-192.168.0.250
ip daddr { 192.168.0.1-192.168.0.250 }
ip daddr { 192.168.5.1, 192.168.5.2, 192.168.5.3 }

_version <version>_

Ip Header version

ip version 4

_hdrlength <header length>_

IP header length

ip hdrlength 0
ip hdrlength 15

#### Ip6

ip6 match

_dscp <value>_

ip6 dscp cs1
ip6 dscp != cs1
ip6 dscp 0x38
ip6 dscp != 0x20
ip6 dscp {cs0, cs1, cs2, cs3, cs4, cs5, cs6, cs7, af11, af12, af13, af21, af22, af23, af31, af32, af33, af41, af42, af43, ef}

_flowlabel <label>_

Flow label

ip6 flowlabel 22
ip6 flowlabel != 233
ip6 flowlabel { 33, 55, 67, 88 }
ip6 flowlabel { 33-55 }

_length <length>_

Payload length

ip6 length 232
ip6 length != 233
ip6 length 333-435
ip6 length != 333-453
ip6 length { 333, 553, 673, 838}

_nexthdr <header>_

Next header type (Upper layer protocol number)

ip6 nexthdr {esp, udp, ah, comp, udplite, tcp, dccp, sctp, icmpv6}
ip6 nexthdr esp
ip6 nexthdr != esp
ip6 nexthdr { 33-44 }
ip6 nexthdr 33-44
ip6 nexthdr != 33-44

_hoplimit <hoplimit>_

Hop limit

ip6 hoplimit 1
ip6 hoplimit != 233
ip6 hoplimit 33-45
ip6 hoplimit != 33-45
ip6 hoplimit {33, 55, 67, 88}
ip6 hoplimit {33-55}

_saddr <ip source address>_

Source Address

ip6 saddr 1234:1234:1234:1234:1234:1234:1234:1234
ip6 saddr ::1234:1234:1234:1234:1234:1234:1234
ip6 saddr ::/64
ip6 saddr ::1 ip6 daddr ::2

_daddr <ip destination address>_

Destination Address

ip6 daddr 1234:1234:1234:1234:1234:1234:1234:1234
ip6 daddr != ::1234:1234:1234:1234:1234:1234:1234-1234:1234::1234:1234:1234:1234:1234

_version <version>_

IP header version

ip6 version 6



#### Tcp

tcp match

_dport <destination port>_

Destination port

tcp dport 22
tcp dport != 33-45
tcp dport { 33-55 }
tcp dport {telnet, http, https }
tcp dport vmap { 22 : accept, 23 : drop }
tcp dport vmap { 25:accept, 28:drop }

_sport < source port>_

Source port

tcp sport 22
tcp sport != 33-45
tcp sport { 33, 55, 67, 88}
tcp sport { 33-55}
tcp sport vmap { 25:accept, 28:drop }
tcp sport 1024 tcp dport 22

_sequence <value>_

Sequence number

tcp sequence 22
tcp sequence != 33-45

_ackseq <value>_

Acknowledgement number

tcp ackseq 22
tcp ackseq != 33-45
tcp ackseq { 33, 55, 67, 88 }
tcp ackseq { 33-55 }

_flags <flags>_

TCP flags

tcp flags { fin, syn, rst, psh, ack, urg, ecn, cwr}
tcp flags cwr
tcp flags != cwr

_window <value>_

Window

tcp window 22
tcp window != 33-45
tcp window { 33, 55, 67, 88 }
tcp window { 33-55 }

_checksum <checksum>_

IP header checksum

tcp checksum 22
tcp checksum != 33-45
tcp checksum { 33, 55, 67, 88 }
tcp checksum { 33-55 }

_urgptr <pointer>_

Urgent pointer

tcp urgptr 22
tcp urgptr != 33-45
tcp urgptr { 33, 55, 67, 88 }

_doff <offset>_

Data offset

tcp doff 8



#### Udp

udp match

_dport <destination port>_

Destination port

udp dport 22
udp dport != 33-45
udp dport { 33-55 }
udp dport {telnet, http, https }
udp dport vmap { 22 : accept, 23 : drop }
udp dport vmap { 25:accept, 28:drop }

_sport < source port>_

Source port

udp sport 22
udp sport != 33-45
udp sport { 33, 55, 67, 88}
udp sport { 33-55}
udp sport vmap { 25:accept, 28:drop }
udp sport 1024 tcp dport 22

_length <length>_

Total packet length

udp length 6666
udp length != 50-65
udp length { 50, 65 }
udp length { 35-50 }

_checksum <checksum>_

UDP checksum

udp checksum 22
udp checksum != 33-45
udp checksum { 33, 55, 67, 88 }
udp checksum { 33-55 }



#### Udplite

udplite match

_dport <destination port>_

Destination port

udplite dport 22
udplite dport != 33-45
udplite dport { 33-55 }
udplite dport {telnet, http, https }
udplite dport vmap { 22 : accept, 23 : drop }
udplite dport vmap { 25:accept, 28:drop }

_sport < source port>_

Source port

udplite sport 22
udplite sport != 33-45
udplite sport { 33, 55, 67, 88}
udplite sport { 33-55}
udplite sport vmap { 25:accept, 28:drop }
udplite sport 1024 tcp dport 22

_checksum <checksum>_

Checksum

udplite checksum 22
udplite checksum != 33-45
udplite checksum { 33, 55, 67, 88 }
udplite checksum { 33-55 }



#### Sctp

sctp match

_dport <destination port>_

Destination port

sctp dport 22
sctp dport != 33-45
sctp dport { 33-55 }
sctp dport {telnet, http, https }
sctp dport vmap { 22 : accept, 23 : drop }
sctp dport vmap { 25:accept, 28:drop }

_sport < source port>_

Source port

sctp sport 22
sctp sport != 33-45
sctp sport { 33, 55, 67, 88}
sctp sport { 33-55}
sctp sport vmap { 25:accept, 28:drop }
sctp sport 1024 tcp dport 22

_checksum <checksum>_

Checksum

sctp checksum 22
sctp checksum != 33-45
sctp checksum { 33, 55, 67, 88 }
sctp checksum { 33-55 }

_vtag <tag>_

Verification tag

sctp vtag 22
sctp vtag != 33-45
sctp vtag { 33, 55, 67, 88 }
sctp vtag { 33-55 }

_chunk <type>_

Existence of a chunk with given type in packet

sctp chunk init exists
sctp chunk error missing

_chunk <type> <field>_

A chunk's field value (implies chunk existence)

<sourcex lang="bash">

sctp chunk init flags 0x1 sctp chunk data tsn 0x23 </source>

#### Dccp

dccp match

_dport <destination port>_

Destination port

dccp dport 22
dccp dport != 33-45
dccp dport { 33-55 }
dccp dport {telnet, http, https }
dccp dport vmap { 22 : accept, 23 : drop }
dccp dport vmap { 25:accept, 28:drop }

_sport < source port>_

Source port

dccp sport 22
dccp sport != 33-45
dccp sport { 33, 55, 67, 88}
dccp sport { 33-55}
dccp sport vmap { 25:accept, 28:drop }
dccp sport 1024 tcp dport 22

_type <type>_

Type of packet

dccp type {request, response, data, ack, dataack, closereq, close, reset, sync, syncack}
dccp type request
dccp type != request



#### Ah

ah match

_hdrlength <length>_

AH header length

ah hdrlength 11-23
ah hdrlength != 11-23
ah hdrlength {11, 23, 44 }

_reserved <value>_

ah reserved 22
ah reserved != 33-45
ah reserved {23, 100 }
ah reserved { 33-55 }

_spi <value>_

ah spi 111
ah spi != 111-222
ah spi {111, 122 }

_sequence <sequence>_

Sequence Number

ah sequence 123
ah sequence {23, 25, 33}
ah sequence != 23-33



#### Esp

esp match

_spi <value>_

esp spi 111
esp spi != 111-222
esp spi {111, 122 }

_sequence <sequence>_

Sequence Number

esp sequence 123
esp sequence {23, 25, 33}
esp sequence != 23-33



#### Comp

comp match

_nexthdr <protocol>_

Next header protocol (Upper layer protocol)

comp nexthdr != esp
comp nexthdr {esp, ah, comp, udp, udplite, tcp, tcp, dccp, sctp}

_flags <flags>_

Flags

comp flags 0x0
comp flags != 0x33-0x45
comp flags {0x33, 0x55, 0x67, 0x88}

_cpi <value>_

Compression Parameter Index

comp cpi 22
comp cpi != 33-45
comp cpi {33, 55, 67, 88}



#### Icmp

icmp match

_type <type>_

ICMP packet type

icmp type {echo-reply, destination-unreachable, source-quench, redirect, echo-request, time-exceeded, parameter-problem, timestamp-request, timestamp-reply, info-request, info-reply, address-mask-request, address-mask-reply, router-advertisement, router-solicitation}

_code_

ICMP packet code

icmp code 111
icmp code != 33-55
icmp code { 2, 4, 54, 33, 56}

_checksum <value>_

ICMP packet checksum

icmp checksum 12343
icmp checksum != 11-343
icmp checksum { 1111, 222, 343 }

_id <value>_

ICMP packet id

icmp id 12343
icmp id != 11-343
icmp id { 1111, 222, 343 }

_sequence <value>_

ICMP packet sequence

icmp sequence 12343
icmp sequence != 11-343
icmp sequence { 1111, 222, 343 }

_mtu <value>_

ICMP packet mtu

icmp mtu 12343
icmp mtu != 11-343
icmp mtu { 1111, 222, 343 }

_gateway <value>_

ICMP packet gateway

icmp gateway 12343
icmp gateway != 11-343
icmp gateway { 1111, 222, 343 }



#### Icmpv6

icmpv6 match

_type <type>_

ICMPv6 packet type

icmpv6 type {destination-unreachable, packet-too-big, time-exceeded, echo-request, echo-reply, mld-listener-query, mld-listener-report, mld-listener-reduction, nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, nd-redirect, parameter-problem, router-renumbering}

_code <code>_

ICMPv6 packet code

icmpv6 code 4
icmpv6 code 3-66
icmpv6 code {5, 6, 7}

_checksum <value>_

ICMPv6 packet checksum

icmpv6 checksum 12343
icmpv6 checksum != 11-343
icmpv6 checksum { 1111, 222, 343 }

_id <value>_

ICMPv6 packet id

icmpv6 id 12343
icmpv6 id != 11-343
icmpv6 id { 1111, 222, 343 }

_sequence <value>_

ICMPv6 packet sequence

icmpv6 sequence 12343
icmpv6 sequence != 11-343
icmpv6 sequence { 1111, 222, 343 }

_mtu <value>_

ICMPv6 packet mtu

icmpv6 mtu 12343
icmpv6 mtu != 11-343
icmpv6 mtu { 1111, 222, 343 }

_max-delay <value>_

ICMPv6 packet max delay

icmpv6 max-delay 33-45
icmpv6 max-delay != 33-45
icmpv6 max-delay {33, 55, 67, 88}



#### Ether

ether match

_saddr <mac address>_

Source mac address

ether saddr 00:0f:54:0c:11:04

_type <type>_

ether type vlan

#### Dst

dst match

_nexthdr <proto>_

Next protocol header

dst nexthdr { udplite, ipcomp, udp, ah, sctp, esp, dccp, tcp, ipv6-icmp}
dst nexthdr 22
dst nexthdr != 33-45

_hdrlength <length>_

Header Length

dst hdrlength 22
dst hdrlength != 33-45
dst hdrlength { 33, 55, 67, 88 }



#### Frag

frag match

_nexthdr <proto>_

Next protocol header

frag nexthdr { udplite, comp, udp, ah, sctp, esp, dccp, tcp, ipv6-icmp, icmp}
frag nexthdr 6
frag nexthdr != 50-51

_reserved <value>_

frag reserved 22
frag reserved != 33-45
frag reserved { 33, 55, 67, 88}

_frag-off <value>_

frag frag-off 22
frag frag-off != 33-45
frag frag-off { 33, 55, 67, 88}

_more-fragments <value>_

frag more-fragments 0
frag more-fragments 0

_id <value>_

frag id 1
frag id 33-45



#### Hbh

hbh match

_nexthdr <proto>_

Next protocol header

hbh nexthdr { udplite, comp, udp, ah, sctp, esp, dccp, tcp, icmpv6}
hbh nexthdr 22
hbh nexthdr != 33-45

_hdrlength <length>_

Header Length

hbh hdrlength 22
hbh hdrlength != 33-45
hbh hdrlength { 33, 55, 67, 88 }



#### Mh

mh match

_nexthdr <proto>_

Next protocol header

mh nexthdr { udplite, ipcomp, udp, ah, sctp, esp, dccp, tcp, ipv6-icmp }
mh nexthdr 22
mh nexthdr != 33-45

_hdrlength <length>_

Header Length

mh hdrlength 22
mh hdrlength != 33-45
mh hdrlength { 33, 55, 67, 88 }

_type <type>_

mh type {binding-refresh-request, home-test-init, careof-test-init, home-test, careof-test, binding-update, binding-acknowledgement, binding-error, fast-binding-update, fast-binding-acknowledgement, fast-binding-advertisement, experimental-mobility-header, home-agent-switch-message}
mh type home-agent-switch-message
mh type != home-agent-switch-message

_reserved <value>_

mh reserved 22
mh reserved != 33-45
mh reserved { 33, 55, 67, 88}

_checksum <value>_

mh checksum 22
mh checksum != 33-45
mh checksum { 33, 55, 67, 88}



#### Rt

rt match

_nexthdr <proto>_

Next protocol header

rt nexthdr { udplite, ipcomp, udp, ah, sctp, esp, dccp, tcp, ipv6-icmp }
rt nexthdr 22
rt nexthdr != 33-45

_hdrlength <length>_

Header Length

rt hdrlength 22
rt hdrlength != 33-45
rt hdrlength { 33, 55, 67, 88 }

_type <type>_

rt type 22
rt type != 33-45
rt type { 33, 55, 67, 88 }

_seg-left <value>_

rt seg-left 22
rt seg-left != 33-45
rt seg-left { 33, 55, 67, 88}



#### Vlan

vlan match

_id <value>_

Vlan tag ID

vlan id 4094
vlan id 0

_cfi <value>_

vlan cfi 0
vlan cfi 1

_pcp <value>_

vlan pcp 7
vlan pcp 3



#### Arp

arp match

_ptype <value>_

Payload type

arp ptype 0x0800

_htype <value>_

Header type

arp htype 1
arp htype != 33-45
arp htype { 33, 55, 67, 88}

_hlen <length>_

Header Length

arp hlen 1
arp hlen != 33-45
arp hlen { 33, 55, 67, 88}

_plen <length>_

Payload length

arp plen 1
arp plen != 33-45
arp plen { 33, 55, 67, 88}

_operation <value>_

arp operation {nak, inreply, inrequest, rreply, rrequest, reply, request}



#### Ct

ct match

_state <state>_

State of the connection

ct state { new, established, related, untracked }
ct state != related
ct state established
ct state 8

_direction <value>_

Direction of the packet relative to the connection

ct direction original
ct direction != original
ct direction {reply, original}

_status <status>_

Status of the connection

ct status expected
(ct status & expected) != expected
ct status {expected,seen-reply,assured,confirmed,snat,dnat,dying}

_mark [set]_

Mark of the connection

ct mark 0
ct mark or 0x23 == 0x11
ct mark or 0x3 != 0x1
ct mark and 0x23 == 0x11
ct mark and 0x3 != 0x1
ct mark xor 0x23 == 0x11
ct mark xor 0x3 != 0x1
ct mark 0x00000032
ct mark != 0x00000032
ct mark 0x00000032-0x00000045
ct mark != 0x00000032-0x00000045
ct mark {0x32, 0x2222, 0x42de3}
ct mark {0x32-0x2222, 0x4444-0x42de3}
ct mark set 0x11 xor 0x1331
ct mark set 0x11333 and 0x11
ct mark set 0x12 or 0x11
ct mark set 0x11
ct mark set mark
ct mark set mark map { 1 : 10, 2 : 20, 3 : 30 }

_expiration_

Connection expiration time

ct expiration 30
ct expiration 30s
ct expiration != 233
ct expiration != 3m53s
ct expiration 33-45
ct expiration 33s-45s
ct expiration != 33-45
ct expiration != 33s-45s
ct expiration {33, 55, 67, 88}
ct expiration { 1m7s, 33s, 55s, 1m28s}

_helper "<helper>"_

Helper associated with the connection

ct helper "ftp"

_[original | reply] bytes <value>_

ct original bytes > 100000
ct bytes > 100000

_[original | reply] packets <value>_

ct reply packets < 100

_[original | reply] ip saddr <ip source address>_

ct original ip saddr 192.168.0.1
ct reply ip saddr 192.168.0.1
ct original ip saddr 192.168.1.0/24
ct reply ip saddr 192.168.1.0/24

_[original | reply] ip daddr <ip destination address>_

ct original ip daddr 192.168.0.1
ct reply ip daddr 192.168.0.1
ct original ip daddr 192.168.1.0/24
ct reply ip daddr 192.168.1.0/24

_[original | reply] l3proto <protocol>_

ct original l3proto ipv4

_[original | reply] protocol <protocol>_

ct original protocol 6

_[original | reply] proto-dst <port>_

ct original proto-dst 22

_[original | reply] proto-src <port>_

ct reply proto-src 53

_count [over] <number of connections>_

ct count over 2

tcp dport 22 add @ssh\_flood { ip saddr ct count over 2 } reject
[ which requires an existing ssh\_flood set, ie. add set filter ssh\_flood { type ipv4\_addr; flags dynamic; } ]

#### Meta

[_meta_](/wiki-nftables/index.php/Matching_packet_metainformation "Matching packet metainformation") matches packet by metainformation.

meta match

_iifname <input interface name>_

Input interface name

meta iifname "eth0"
meta iifname != "eth0"
meta iifname {"eth0", "lo"}
meta iifname "eth\*"

_oifname <output interface name>_

Output interface name

meta oifname "eth0"
meta oifname != "eth0"
meta oifname {"eth0", "lo"}
meta oifname "eth\*"

_iif <input interface index>_

Input interface index

meta iif eth0
meta iif != eth0

_oif <output interface index>_

Output interface index

meta oif lo
meta oif != lo
meta oif {eth0, lo}

_iiftype <input interface type>_

Input interface type

meta iiftype {ether, ppp, ipip, ipip6, loopback, sit, ipgre}
meta iiftype != ether
meta iiftype ether

_oiftype <output interface type>_

Output interface hardware type

meta oiftype {ether, ppp, ipip, ipip6, loopback, sit, ipgre}
meta oiftype != ether
meta oiftype ether

_length <length>_

Length of the packet in bytes

meta length 1000
meta length != 1000
meta length > 1000
meta length 33-45
meta length != 33-45
meta length { 33, 55, 67, 88 }
meta length { 33-55, 67-88 }

_protocol <protocol>_

ethertype protocol

meta protocol ip
meta protocol != ip
meta protocol { ip, arp, ip6, vlan }

_nfproto <protocol>_

meta nfproto ipv4
meta nfproto != ipv6
meta nfproto { ipv4, ipv6 }

_l4proto <protocol>_

meta l4proto 22
meta l4proto != 233
meta l4proto 33-45
meta l4proto { 33, 55, 67, 88 }
meta l4proto { 33-55 }

_mark [set] <mark>_

Packet mark

meta mark 0x4
meta mark 0x00000032
meta mark and 0x03 == 0x01
meta mark and 0x03 != 0x01
meta mark != 0x10
meta mark or 0x03 == 0x01
meta mark or 0x03 != 0x01
meta mark xor 0x03 == 0x01
meta mark xor 0x03 != 0x01
meta mark set 0xffffffc8 xor 0x16
meta mark set 0x16 and 0x16
meta mark set 0xffffffe9 or 0x16
meta mark set 0xffffffde and 0x16
meta mark set 0x32 or 0xfffff
meta mark set 0xfffe xor 0x16

_priority [set] <priority>_

tc class id

meta priority none
meta priority 0x1:0x1
meta priority 0x1:0xffff
meta priority 0xffff:0xffff
meta priority set 0x1:0x1
meta priority set 0x1:0xffff
meta priority set 0xffff:0xffff

_skuid <user id>_

UID associated with originating socket

meta skuid {bin, root, daemon}
meta skuid root
meta skuid != root
meta skuid lt 3000
meta skuid gt 3000
meta skuid eq 3000
meta skuid 3001-3005
meta skuid != 2001-2005
meta skuid { 2001-2005 }

_skgid <group id>_

GID associated with originating socket

meta skgid {bin, root, daemon}
meta skgid root
meta skgid != root
meta skgid lt 3000
meta skgid gt 3000
meta skgid eq 3000
meta skgid 3001-3005
meta skgid != 2001-2005
meta skgid { 2001-2005 }

_rtclassid <class>_

Routing realm

meta rtclassid cosmos

_pkttype <type>_

Packet type

meta pkttype broadcast
meta pkttype != broadcast
meta pkttype { broadcast, unicast, multicast}

_cpu <cpu index>_

CPU ID

meta cpu 1
meta cpu != 1
meta cpu 1-3
meta cpu != 1-2
meta cpu { 2,3 }
meta cpu { 2-3, 5-7 }

_iifgroup <input group>_

Input interface group

meta iifgroup 0
meta iifgroup != 0
meta iifgroup default
meta iifgroup != default
meta iifgroup {default}
meta iifgroup { 11,33 }
meta iifgroup {11-33}

_oifgroup <group>_

Output interface group

meta oifgroup 0
meta oifgroup != 0
meta oifgroup default
meta oifgroup != default
meta oifgroup {default}
meta oifgroup { 11,33 }
meta oifgroup {11-33}

_cgroup <group>_

meta cgroup 1048577
meta cgroup != 1048577
meta cgroup { 1048577, 1048578 }
meta cgroup 1048577-1048578
meta cgroup != 1048577-1048578
meta cgroup {1048577-1048578}

### Statements

**statement** is the action performed when the packet match the rule. It could be _terminal_ and _non-terminal_. In a certain rule we can consider several non-terminal statements but only a single terminal statement.

#### Verdict statements

The **verdict statement** alters control flow in the ruleset and issues policy decisions for packets. The valid verdict statements are:

*   _accept_: Accept the packet and stop the remain rules evaluation.
*   _drop_: Drop the packet and stop the remain rules evaluation.
*   _queue_: Queue the packet to userspace and stop the remain rules evaluation.
*   _continue_: Continue the ruleset evaluation with the next rule.
*   _return_: Return from the current chain and continue at the next rule of the last chain. In a base chain it is equivalent to accept
*   _jump <chain>_: Continue at the first rule of <chain>. It will continue at the next rule after a return statement is issued
*   _goto <chain>_: Similar to jump, but after the new chain the evaluation will continue at the last chain instead of the one containing the goto statement

#### Log

log statement

_level [over] <value> <unit> [burst <value> <unit>]_

Log level

log
log level emerg
log level alert
log level crit
log level err
log level warn
log level notice
log level info
log level debug

_group <value> [queue-threshold <value>] [snaplen <value>] [prefix "<prefix>"]_

log prefix aaaaa-aaaaaa group 2 snaplen 33
log group 2 queue-threshold 2
log group 2 snaplen 33



#### Reject

The default **reject** will be the ICMP type **port-unreachable**. The **icmpx** is only used for inet family support.

More information on the [Rejecting\_traffic](/wiki-nftables/index.php/Rejecting_traffic "Rejecting traffic") page.

reject statement

_with <protocol> type <type>_

reject
reject with icmp type host-unreachable
reject with icmp type net-unreachable
reject with icmp type prot-unreachable
reject with icmp type port-unreachable
reject with icmp type net-prohibited
reject with icmp type host-prohibited
reject with icmp type admin-prohibited
reject with icmpv6 type no-route
reject with icmpv6 type admin-prohibited
reject with icmpv6 type addr-unreachable
reject with icmpv6 type port-unreachable
reject with icmpx type host-unreachable
reject with icmpx type no-route
reject with icmpx type admin-prohibited
reject with icmpx type port-unreachable
ip protocol tcp reject with tcp reset

#### Counter

counter statement

_packets <packets> bytes <bytes>_

counter
counter packets 0 bytes 0



#### Limit

limit statement

_rate [over] <value> <unit> [burst <value> <unit>]_

Rate limit

limit rate 400/minute
limit rate 400/hour
limit rate over 40/day
limit rate over 400/week
limit rate over 1023/second burst 10 packets
limit rate 1025 kbytes/second
limit rate 1023000 mbytes/second
limit rate 1025 bytes/second burst 512 bytes
limit rate 1025 kbytes/second burst 1023 kbytes
limit rate 1025 mbytes/second burst 1025 kbytes
limit rate 1025000 mbytes/second burst 1023 mbytes

#### Nat

nat statement

_dnat to <destination address>_

Destination address translation

dnat to 192.168.3.2
dnat to ct mark map { 0x00000014 : 1.2.3.4}

_snat to <ip source address>_

Source address translation

snat to 192.168.3.2
snat to 2001:838:35f:1::-2001:838:35f:2:::100

_masquerade [<type>] [to :<port>]_

Masquerade

masquerade
masquerade persistent,fully-random,random
masquerade to :1024
masquerade to :1024-2048

#### Queue

queue statement

_num <value> <scheduler>_

queue
queue num 2
queue num 2-3
queue num 4-5 fanout bypass
queue num 4-5 fanout
queue num 4-5 bypass

Extras
------

### Export Configuration

% nft export (xml | json)

### Monitor Events

Monitor events from Netlink creating filters.

% nft monitor [new | destroy] [tables | chains | sets | rules | elements] [xml | json]



Nft scripting
=============

List ruleset
------------

% nft list ruleset

Flush ruleset
-------------

% nft flush ruleset

Load ruleset
------------

Create a command batch file and load it with the nft interpreter,

```bash
% echo "flush ruleset" > /etc/nftables.rules
% echo "add table filter" >> /etc/nftables.rules
% echo "add chain filter input" >> /etc/nftables.rules
% echo "add rule filter input meta iifname lo accept" >> /etc/nftables.rules
% nft -f /etc/nftables.rules
```

or create an executable nft script file,

```bash
% cat << EOF > /etc/nftables.rules
\> #!/usr/local/sbin/nft -f
\> flush ruleset
\> add table filter
\> add chain filter input
\> add rule filter input meta iifname lo accept
\> EOF
% chmod u+x /etc/nftables.rules
% /etc/nftables.rules
```

or create an executable nft script file from an already created ruleset,

```bash
% nft list ruleset > /etc/nftables.rules
% nft flush ruleset
% nft -f /etc/nftables.rules
```


Examples
========

Simple IP/IPv6 Firewall
-----------------------

flush ruleset

table firewall {
  chain incoming {
    type filter hook input priority 0; policy drop;

    \# established/related connections
    ct state established,related accept

    \# loopback interface
    iifname lo accept

    \# icmp
    icmp type echo-request accept

    \# open tcp ports: sshd (22), httpd (80)
    tcp dport {ssh, http} accept
  }
}

table ip6 firewall {
  chain incoming {
    type filter hook input priority 0; policy drop;

    \# established/related connections
    ct state established,related accept

    \# invalid connections
    ct state invalid drop

    \# loopback interface
    iifname lo accept

    \# icmp
    \# routers may also want: mld-listener-query, nd-router-solicit
    icmpv6 type {echo-request,nd-neighbor-solicit} accept

    \# open tcp ports: sshd (22), httpd (80)
    tcp dport {ssh, http} accept
  }
}

Retrieved from "[https://wiki.nftables.org/wiki-nftables/index.php?title=Quick\_reference-nftables\_in\_10\_minutes&oldid=996](https://wiki.nftables.org/wiki-nftables/index.php?title=Quick_reference-nftables_in_10_minutes&oldid=996)"

Navigation menu
---------------

### Views

*   [Page](/wiki-nftables/index.php/Quick_reference-nftables_in_10_minutes "View the content page [c]")
*   [Discussion](/wiki-nftables/index.php?title=Talk:Quick_reference-nftables_in_10_minutes&action=edit&redlink=1 "Discussion about the content page [t]")
*   [View source](/wiki-nftables/index.php?title=Quick_reference-nftables_in_10_minutes&action=edit "This page is protected.
    You can view its source [e]")
*   [History](/wiki-nftables/index.php?title=Quick_reference-nftables_in_10_minutes&action=history "Past revisions of this page [h]")

### Personal tools

*   [Log in](/wiki-nftables/index.php?title=Special:UserLogin&returnto=Quick+reference-nftables+in+10+minutes "You are encouraged to log in; however, it is not mandatory [o]")

[](/wiki-nftables/index.php/Main_Page "Visit the main page")

### Navigation

*   [Main page](/wiki-nftables/index.php/Main_Page "Visit the main page [z]")
*   [Recent changes](/wiki-nftables/index.php/Special:RecentChanges "A list of recent changes in the wiki [r]")
*   [Random page](/wiki-nftables/index.php/Special:Random "Load a random page [x]")
*   [Help](https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents "The place to find out")

### Search

   

### Tools

*   [What links here](/wiki-nftables/index.php/Special:WhatLinksHere/Quick_reference-nftables_in_10_minutes "A list of all wiki pages that link here [j]")
*   [Related changes](/wiki-nftables/index.php/Special:RecentChangesLinked/Quick_reference-nftables_in_10_minutes "Recent changes in pages linked from this page [k]")
*   [Special pages](/wiki-nftables/index.php/Special:SpecialPages "A list of all special pages [q]")
*   [Printable version](/wiki-nftables/index.php?title=Quick_reference-nftables_in_10_minutes&printable=yes "Printable version of this page [p]")
*   [Permanent link](/wiki-nftables/index.php?title=Quick_reference-nftables_in_10_minutes&oldid=996 "Permanent link to this revision of the page")
*   [Page information](/wiki-nftables/index.php?title=Quick_reference-nftables_in_10_minutes&action=info "More information about this page")

[![GNU Free Documentation License 1.3 or later](/wiki-nftables/resources/assets/licenses/gnu-fdl.png)](https://www.gnu.org/copyleft/fdl.html)

[![Powered by MediaWiki](/wiki-nftables/resources/assets/poweredby_mediawiki_88x31.png)](//www.mediawiki.org/)

*   This page was last edited on 23 July 2021, at 17:00.
*   Content is available under [GNU Free Documentation License 1.3 or later](https://www.gnu.org/copyleft/fdl.html) unless otherwise noted.
*   [Privacy policy](/wiki-nftables/index.php/Nftables_wiki:Privacy_policy "Nftables wiki:Privacy policy")
*   [About nftables wiki](/wiki-nftables/index.php/Nftables_wiki:About "Nftables wiki:About")
*   [Disclaimers](/wiki-nftables/index.php/Nftables_wiki:General_disclaimer "Nftables wiki:General disclaimer")
