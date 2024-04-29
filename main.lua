--[[ My notes and work from the book 'Nmap Network Scanning : Official Nmap Project Guide to Network Discovery and Security Scanning' by Gordon "Fyodor" Lyon

1. Getting Started with Nmap
1.1. Introduction

- Nmap ("Network Mapper") is a free and open source utility for:
    * network exploration 
    * security auditing
    * network inventory
    * managing service upgrade schedules
    *monitoring host or service uptime.
- Nmap uses raw IP packets to determine
    * what hosts are available on the network
    * what services (application name and version) those hosts are offering
    * what operating systems (and OS versions) they are running
    * what type of packet filters/firewalls are in use, etc.

1.3. The Phases of an Nmap Scan
    - Target enumeration:
        * Nmap researches the host specifiers provided by the user
            -> a combination of host DNS names, IP addresses, CIDR network notations, etc
        * add (-iR) so Nmap can choose for you yay ^^
        * Nmap resolves these specifiers into a list of 1Pv4 or IPv6 addresses for scanning
        * This phase cannot be skipped
    - Host discovery (ping scanning)
        * find out which targets on the network are online
        * Nmap offers quick ARP requests to elaborate combinations of TCP, ICMP, and other types of probes
    - Reverse-DNS resolution
        * Nmap looks u p the reverse-DNS names of all hosts found online by the ping scan
    - !!! Port scanning !!!
        * Nmap's FUNDAMENTAL OPERATION !!!
        * Probes are sent -> the responses (or non-responses) to those probes are used 
          to classify remote ports into states such as open, closed or filtered
        * performed by default
    - Version detection
        * send a variety of probes and match the responses
          against a database of thousands of known service signatures
        * enable: -sV
    - OS detection
        * -O option
        * Nmap matches responses to a standard set of probes 
          against a database of more than a thousand known operating system responses
    - Traceroute
        * enabled by the --traceroute option
        * find the network routes to many hosts in parallel
          using the best available probe packets as determined by Nmap's previous discovery phases
    - Script scanning
        * The Nmap Scripting Engine (NSE) uses a collection of special-purpose scripts
          to gain information about remote systems
        * Lua programming language
        * standard library designed for network information gathering
        * advanced version detection
        * notification of service vulnerabilities
        * discovery of backdoors and other malware
        * request it with options like --script or -sC
    - Output
        * Nmap collects all the information it has gathered and writes it to the screen or to a file

1.4. Legal Issues
    - Nmap offers many options for stealthy scans, including
        * source-IP spoofing
        * decoy scanning
        * idle scanning 
    - ALWAYS HAVE A LEGITIMATE REASON FOR PERFORMING SCANS
    - For testing purposes, you have permission to scan the host scanme.nmap.org

1.4.2. Can Port Scanning Crash the Target Computer/Networks?
    - The IP, TCP, UDP, and ICMP headers are always appropriate,
      though the destination host is not necessarily expecting the packets
    - no app, host, or network component should ever crash based on an Nmap scan

1.5. The History And The Future Of Nmap
    - September 1, 1997 - Nmap is first released
      * It doesn't have a version number because new releases aren't planned.
      * Nmap is about 2,000 lines long
      * compilation is as simple as gee -06 -o nmap nmap.c -Im

2. Obtaining, Compilng, Installing, and Removing Nmap

    - First Scan ^^
        nmap -sVC -O -T4 scanme.nmap.org

    * !!! ProtonVPN  -> off !!!

3. Host Discovery ("Ping Scanning")
3.1 . Introduction
    - One of the very first steps in any network reconnaissance mission
        => to reduce a (sometmes huge) set of IP ranges into a list of active or interesting hosts
    - Scanning every port of every single IP address ---> don't do it; slow and usually unnecessary;
    - Network administrators may only be interested in hosts running a certain service
        * An administrator may be comfortable using an ICMP ping to locate hosts on his internal network
    - Security auditors may care about every single device with an IP address
        * external penetration tester may use a diverse set of dozens of probes in an attempt to evade firewall restrictions
    - Despite the name ping scan, this goes well beyond the simple ICMP echo request packets
      associated with the ubiquitous ping tool
        * list scan (-sL): skip the ping step entirely with a list scan
        * disable scan (-PN)
        * engage the network with arbitrary combinations of multi-port TCP SYN/ACK, UDP, and ICMP probes
            ** The goal of these probes is to solicit responses which demonstrate that an IP address is actually active

3.2. Specifying Target Hosts and Networks
    - Everything on the Nmap command-line that isn't an option (or option argument) is treated as
        !!! a target host specification !!!
        * The simplest case is to specify a target IP address or hostname for scanning
    - Scanning a whole network of adjacent hosts
        * Nmap supports CIDR-style addressing: You can append /<nbits> to an IPv4 address or hostname
          and Nmap will scan every IP address for which the first <nbits>
          are the same as for the reference IP or hostname given
          ** CIDR notation is short but not always flexible enough
        * example: 192.168.10.0/24 would scan the 256 hosts between 192.168.10.0  and 192.168.10.255
            ** 192.168.10.40/24 would scan exactly the same targets
    - The smallest allowed value is /0, which scans the whole Internet
    - The largest value is /32, which scans just the named host or IP address because all address bits are fixed
    - you might want to scan 192.168.0.0/16 but skip any IPs ending with .0 or .255
        => they may be used as subnet network and broadcast addresses
    - Nmap supports octet range addressing
        * you can specify a comma-separated list of numbers or ranges for each octet
        * example: 192.168.0-255.1-254 will skip all addresses in the range that end in .0 or .255
        * ranges don't need to be limited to the final octets
            ** the specifier 0-255.0-255.13.37 will perform an Internet-wide scan for all IP addresses ending in 13.37
            ** this broad sampling can be useful for Internet surveys and research
        * CIDR and octet ranges aren't supported for IPv6
            ** they are rarely useful
            ** IPv6 addresses can only be specified by their fully qualified IPv6 address or hostname
    - Nmap accepts multiple host specifications on the command line, and they don't need to be the same type
    
    nmap -Pn ipv4 ---> scan w/o ping, useful if ICMP is blocked

3.2.1. Input From List (-iL)
    - generate list of hosts to scan and pass that filename to Nmap as an argument to the -iL option
    - Entries can be in any of the formats accepted by Nmap on the command line
        * IP address
        * hostname
        * CIDR
        * IPv6
        * octet ranges
        separated by one or more spaces, tabs, or newlines.
    - hyphen (-) as the filename ---> Nmap will read hosts from standard input

3.2.3. Excluding Targets (--exclude, --excludefile <filename>)
    - exclude hosts or entire networks with the --exclude option (--excludefile ---> a file with hosts/networks)

    - Obtain the list of assigned DHCP IP addresses and feed them directly to Nmap for scanning
        egrep '^lease'/var/lib/dhcp/dhcpd.leases | awk '{print $2}' | nmap -iL -
]]