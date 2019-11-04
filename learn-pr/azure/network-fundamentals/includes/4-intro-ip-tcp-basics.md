When considering the move to the cloud, it's essential in your role as either an Azure Developer, Solution Architect, or Administrator to know the fundamentals of how your network works. The next step in understanding the composition of a network is a detailed look at the interoperability of your network. This knowledge applies whether it's your own organization's network or more extensive networks like the world wide web. All networks are built on the same principals.

In this unit, you'll learn about the main aspects of network communications, why networks are built using TCP/IP. You'll understand the differences between Internet Protocol address standards. Finally, you'll explore subnetting, the Domain Name System, ports, and the use and role of private IP addresses.

## What is TCP

The Transmission Control Protocol (TCP) originated during the initial development of the network standards. TCP is a core element of the Internet protocol suite (IPS). TCP provides a stable and reliable mechanism for the delivery of data packets across an IP-based network. It's responsible for chunking up the data stream into an orderly and error-checked packet of data.

TCP is only concerned with ensuring data streams are packaged ready for delivery. It doesn't know where the data is being sent to or how it will be sent. TCP is still widely used in the majority of Internet-based applications, including email, web, remote desktop, and FTP. While TCP for the web and is part of the HTTP and HTTP/2 protocol, it's no longer used in the recently approved HTTP/3 protocol.

## What is IP

The Internet Protocol (IP) is a significant part of the Internet protocol suite. IP is solely responsible for the addressing of a data packet or packets that it receives from the layer above or below it. IP encapsulates the data packet to be delivered, adding an address header. This header contains information on the sender and recipient IP addresses. The IP layer isn't concerned about the order the packets are sent or received, just that they're addressed correctly.

## What is TCP/IP

The Transmission Control Protocol/Internet Protocol (TCP/IP)  is a collection of different communication protocols that support and define how network-enabled devices interconnect with each other over an IP-based network. At its heart are two key protocols: TCP and IP. This protocol makes possible the Internet, as well as private and public networks, like intranets and extranets.

TCP/IP defines the way data is shared between network-enabled devices by defining the end-to-end communication process. It manages how the message is broken down into packets of data, sometimes known as datagrams. How the packet will be addressed and transmitted, routed, and received. TCP/IP can determine the most efficient route across a network.

The TCP/IP model is designed to be stateless. Which means it treats each request as new, because it isn't related to the previous request. There's one part of the TCP/IP model that isn't. The transport layer operates in a stateful mode because it maintains a connection until all the packets in the message are received.

TCP/IP is an open standard, governed, but not owned by anyone organization. Which allows it to work with all operating systems, networks, and hardware.

### TCP/IP model layers

The TCP/IP model is comprised of four distinct layers. Each of which uses a different type of protocol.

- **Application layer** - The application layer is responsible for determining which communication protocols will be used. This layer includes HyperText Transfer Protocol (HTTP), Domain Name System (DNS), File Transfer Protocol (FTP), Internet Message Access Protocol (IMAP), Lightweight Directory Access Protocol (LDAP), Post Office Protocol (POP), Simple Mail Transfer Protocol (SMTP), Simple Network Management Protocol (SNMP), Secure Shell (SSH), Telnet, and TLS/SSL.
- **Transport layer** - This layer will split the application data into manageable ordered chunks, using the right port for the application protocol used. The protocols associated with this layer are TCP and UDP.
- **Internet layer** - Also know as the network layer. This layer will ensure the data packet gets to its destination. The protocols associated with this layer are IP, IPv4, IPv6, ICMP, and IPsec.
- **Physical layer** - This layer is responsible for defining how the data is sent across the network. The protocols associated with this layer are ARP, MAC, Ethernet, DSL, and ISDN.

## What are the Internet Protocol (IP) standards

The Internet Protocol provides a logical addressing system that is used to route and forwards the message to its destination. It doesn't guarantee a packet will be delivered, or that they'll be delivered in the right sequence. Sequencing is handled by the TCP. This protocol forms the basis for communication used across the Internet and on any network.

When IPv4 was first devised and deployed in the early '80s, there were fewer network devices available. The '90s saw a rapid increase in the number of devices, networks, and web services. It was clear IPv4 wouldn't provide enough logical IP addresses. So a new standard was established to run in parallel with IPv4, and it was called IPv6.

### IPv4

Internet Protocol version 4 (IPv4) was released in 1983, and is the standard for all packet-switch based networks in use today. It's been in constant use since its introduction in 1983. Using a 32-bit address space gives an upper limit of 4,293,967,296 (4.3 billion) unique logical IP addresses. A large number of these available IP addresses are reserved for specific purposes.

### Structure of an IPv4 address

The structure of an IPv4 address is four decimal numbers in the range of 0 to 255, each separated with a dot. It's also known as the dotted-decimal format. An example of an IP address would be 192.168.0.1.

### Parts of an IPv4 address

There are two parts to an IP address, the network, and the host.

The network part of an IP address covers the first two decimal numbers. Using the above example, that would be 192.168. This number is unique to your network and specifies the Class of your network as well.

The host part of the IP address covers the last two decimal numbers. Using the above example, that would be 0.1. It represents the device and has to be unique within your network to avoid IP clashing.

### IPv4 address classes

At the introduction of the Internet Protocol, the local address space was split into five logical classes, each represented by a letter of the alphabet.

| Class | Start Address | End Address     | Number of Networks | IP addresses per network | Total IP addresses available | Subnet mask   |
| ----- | ------------- | --------------- | ------------------ | ------------------------ | ---------------------------- | ------------- |
| A     | 0.0.0.0       | 127.255.255.255 | 128                | 16,777,216               | 2,147,483,648                | 255.0.0.0     |
| B     | 128.0.0.0     | 191.255.255.255 | 16,384             | 65,536                   | 1,073,741,824                | 255.255.0.0   |
| C     | 192.0.0.0     | 223.255.255.255 | 2,097,152          | 256                      | 536,870,912                  | 255.255.255.0 |
| D     | 224.0.0.0     | 239.255.255.255 | -                  | -                        | 268,435,456                  | -             |
| E     | 240.0.0.0     | 255.255.255.255 | -                  | -                        | 268,435,456                  | -             |

For classes A, B, and C, the start and end IP addresses are reserved and shouldn't be used. Class D is reserved for multicast traffic only. Class E is reserved and can't be used on public networks, like the Internet.

### Special Use addresses

Each of the classes has restrictions on the ranges of IP addresses that can be used. This table shows the more common ones.

| Address range               | Scope           | Description                                               |
| --------------------------- | --------------- | --------------------------------------------------------- |
| 10.0.0.0–10.255.255.255     | Private network | Used for local communications within a private network. |
| 127.0.0.0–127.255.255.255   | Host            | Used for loopback addresses. |
| 172.16.0.0–172.31.255.255   | Private network | Used for local communications within a private network. |
| 192.88.99.0–192.88.99.255   | Internet        | Reserved. |
| 192.168.0.0–192.168.255.255 | Private network | Used for local communications within a private network. |
| 255.255.255.255             | Subnet          | Reserved for the "limited broadcast" destination address. |

### IPv4 Address Space Exhaustion

Soon after the introduction of IPv4, it became apparent that the pool of available IP addresses was being consumed faster than had initially been planned. Which came from an increase in Internet users, ADSL and cable modems, and mobile devices like phones, PDAs, and laptops.

Several solutions were introduced to mitigate the threat of running out of IP addresses. These including network address translation (NAT), classful networks, and Classless Inter-Domain Routing (CIDR). In the '90s, IPv6 was created, increasing the number of IP address spaces to 128 bits. It was introduced commercially in 2006.

### IPv6

Internet Protocol version 6 (IPv6) is the latest version of the IP standard. IPv6 designed and developed by the Internet Engineering Task Force (IETF) to address the problem of IPv4 logical address exhaustion and to eventually replace the IPv4 standard. It was adopted as a recognized Internet standard in July 2017.

IPv6 uses a 128-bit address space, allowing 2<sup>128</sup> addresses. Which is approximately 7.9x10<sup>28</sup> times more than IPv4.

IPv4 and IPv6 weren't designed to be interoperable, which has slowed down the transition to the newer IPv6 standard.

As well as expanding the total number of logical IP addresses, IPv6 has introduced other technical benefits.  It now allows hierarchical address allocation, which is part of supernetworks and an attempt to reduce the overhead of routing traffic across large networks. IPv6 has simplified the use of multicast addressing by optimizing the delivery process.

The IPv6 address structure supports three types of transmission: multicast, unicast, and anycast.

### Structure of an IPv6 address

The structure of an IPv6 is different from IPv4. Instead of four decimal numbers, it uses eight groups of four hexadecimal numbers called a hexadectet. Each hexadectet is separated with a colon. A full IPv6 address will look like this: *2001:0db8:0000:0000:0000:8a2e:0370:7334*. However, the new standard allows for the address to be simplified using the following rules:

- One or more leading zeros from any group will be removed. So 0042 becomes 42.
- Consecutive sections of zeros will be replaced with a double colon (::), which can only be used once in an address. So the three 0000s in our example are replaced by three colons (:::).

So the shortened version of our IPv6 example is *2001:db8::8a2e:370:7334*. You'll notice that all the 0000s have been removed.

## Subnetting

Subnetting lets you define one or more logical networks within your Class A, B, or C network. Without subnets, you'd be restricted to a single network in each of your Class A, B, or C networks.

An IP address, also known as a network address or routing prefix, represents the address of the device or computer to send the packet of data. A subnet, or host address, represents which network or subnetwork to use. A subnet is a 32-bit number framed using the dotted-decimal format; for example, 255.255.255.0 is a standard subnet mask.

In an IPv4 network, for a packet of data to be routed to the correct network and the right network device, a routing prefix is needed. A routing prefix is created by taking the subnet mask and applying a bitwise AND to the IP address.

A more common way of defining the subnet and the routing prefix is to use the Classless Inter-Domain Routing (CIDR) notation. CIDR is applied to the IP address as the number of bits you want to allocate to your subnet. Using CIDR notation, at the end of the IP address, you would add a / and then the number of bits. For example, 198.51.100.0/24 is the same as using the dotted-decimal format subnet mask 255.255.255.0. It will offer an address range of 198.51.100.0 to 198.51.100.255.

Subnets allow multiple subnetworks to exist within one network. They can be used to enhance routing performance. Subnets can be arranged hierarchically to create routing trees.

## Private IP Addressing

In classes A, B, and C, there's a range of IP addresses set aside for Private Networks. These IP ranges aren't accessible via the Internet, and any packets sent to them will be ignored by all public routers.

| Name         | CIDR block | Address range                 | Number of addresses | *Classful* description |
| ------------ | ------------------------------------------------------------ | ----------------------------- | ------------------- | ------------------------------------------------------------ |
| 24-bit block | 10.0.0.0/8                                                   | 10.0.0.0 – 10.255.255.255     | 16777216            | Single Class A. |
| 20-bit block | 172.16.0.0/12                                                | 172.16.0.0 – 172.31.255.255   | 1048576             | Contiguous range of 16 Class B blocks. |
| 16-bit block | 192.168.0.0/16                                               | 192.168.0.0 – 192.168.255.255 | 65536               | Contiguous range of 256 Class C blocks. |

Network devices on a private network can't communicate with devices on a public network. The only way communication can happen is through network address translation at a routing gateway.

The only way to connect two private networks in different geographical areas is to use a virtual private network (VPN). A VPN encapsulates each private network packet and can further encrypt it before sending it across a public network to the other private network.

## DNS

The Domain Name System (DNS) is a decentralized lookup service that translates a human-readable domain name or URL into the IP address of the server hosting the site or service. This worldwide distributed nature of the DNS service is a vital component of the Internet. DNS has been since its inception in 1985.

A DNS server serves two purposes. The first is to maintain a cache of recently searched for domain name, which improves performance and reduces network traffic. The second is to act as the start of authority (SOA) for all the domains under it. When a DNS server is looking to resolve a domain name that isn't held in its cache, it will start with the highest level, the dot, then work down the subdomains until it finds the DNS server acting as the SOA. Once found, it stores the IP address of the domain in its local cache.

The DNS also holds specific records relating to the domain. These include the Start of Authority (SOA), IP Addressing (A and AAAA), SMTP Email (MX), Name Servers (NS), and domain name alias (CNAME) records.

## Ports

A port is a logical construct that allows the routing of incoming messages to specific processes. There's a particular port for every type of Internet protocol suite. A port is an unsigned 16-bit number in the range 0 to 65535 and is also known as a port number. Ports are assigned by the sending TCP or UDP layer based on the communications protocol used.

There are specific port numbers reserved for every service. The first 1024 ports, called the well-known port numbers, are reserved for the commonly used services. The high-numbered ports, called the ephemeral ports, are unreserved and used by dedicated applications.

Every port has its own process and is linked to a specific service or communications protocol. It means the target network device, say a server, can receive multiple requests on each port and service each of them without conflict. It is a form of multiplexing, where one IP address can be used for multiple simultaneous communications.

### The well-known port numbers

Much in the same way, IP addresses are split into classes, so are ports. There are three ranges of ports: the well-known ports, the registered ports, and the dynamic/private ports. A governing body, called the IANA manages the allocation of port numbers, as well as IP addressing, DNS Root, and other Internet protocols.

The table below lists some of the more common well-known port numbers.

| Port number | Assignment                                                   |
| ----------- | ------------------------------------------------------------ |
| 20          | File Transfer Protocol (FTP) Data Transfer |
| 21          | File Transfer Protocol (FTP) Command Control |
| 22          | Secure Shell (SSH) Secure Login |
| 23          | Telnet remote login service, unencrypted text messages |
| 25          | Simple Mail Transfer Protocol (SMTP) Email routing |
| 53          | Domain Name System (DNS) service |
| 80          | Hypertext Transfer Protocol (HTTP) used in the World Wide Web |
| 110         | Post Office Protocol (POP3) |
| 119         | Network News Transfer Protocol (NNTP) |
| 123         | Network Time Protocol (NTP) |
| 143         | Internet Message Access Protocol (IMAP) Management of digital mail |
| 161         | Simple Network Management Protocol (SNMP) |
| 194         | Internet Relay Chat (IRC) |
| 443         | HTTP Secure (HTTPS) HTTP over TLS/SSL |

## What does Azure offer

While many the concepts discussed here are technical, Azure has several tools that can help with your networks.

### Azure DNS

Azure DNS is a service for hosting your registered domain names using the Azure Infrastructure. It allows you to manage your DNS records, including A, AAAA, CNAME, SOA, NS, and MX, using your regular Azure sign-in credentials.

The Azure DNS service won't replace your domain registrar, where you register and purchases your domains.

One of the core benefits provided by Azure DNS is the Alias record, which can use either an A, AAAA, or CNAME record. The Alias allows you to route traffic to an Azure resource.

### Azure  Virtual Network

An Azure Virtual Network lets you build a private network in the cloud. An Azure VNet allows you to build networks that can communicate with other VNets and your on-premises network. They're an efficient way to extend your network into the cloud.

With an Azure Virtual Network, you can control the addressing used. Most virtual networks are assumed to be private networks. As with a regular network, you can use subnetting to segment and allocate IP addresses ranges to those subnets.
