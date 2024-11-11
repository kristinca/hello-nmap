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

3.3. Finding an Organization's IP Addresses
    - DO carefully research target netblocks BEFORE scanning them !!!
    - An authorization letter signed by your client WONT'T HELP YOU if you accidentally break into the wrong company

3.3.1. DNS Tricks
    - the primary purpose of DNS is to resolve domain names into IP addresses ---> we can start here yay ^^

3.3.2. Whois Queries Against IP Registries
    - To find which IP belongs to the company you expect + determine what netblocks they are part of, we have the registries:
        * ARIN (American Registry for Internet Numbers)
        * RIPE for Europe and the Middle East.
    - Small and mid-sized companies normally don't have IP space allocated by the likes of ARIN
        * they are delegated netblocks from their ISPs
    - many ISPs subdelegate customer ranges using Shared Whois (SWIP) or Referral Whois (RWhois)

3.3.3. Internet Routing Information
    - Border Gateway Protocol (BGP)
        * The core routing protocol of the Internet
        * When scanning mid-sized and large organizations,
          BGP routing tables can help you find their IP subnets all over the world

3.4 DNS Resolution
    - The key focus of Nmap host discovery ---> determining WHICH HOSTS ARE UP and RESPONSIVE on the network
    - By default, Nmap performs reverse-DNS resolution for EVERY IP which responds to host discovery probes (is online)
    - If host discovery is skipped with -Pn, resolution is performed for all IPs
    - Nmap uses a custom stub resolver which performs dozens of requests in parallel

3.5. Host Discovery Controls
    - Nmap will include a ping scanning stage prior to more intrusive probes:
        * port scans
        * OS detection
        * Nmap Scripting Engine
        * version detection.
    - -Pn : scan every IP

3.5.1. List Scan (-sL)
    - just lists each host on the network(s) specified, without sending any packets to the target hosts
    - Nmap still performs reverse-DNS resolution on the hosts to learn their names
    - Nmap reports the total number of IP addresses at the end
    - List scan is a good sanity check to ensure that you have proper IP addresses for your targets
    - Another reason for an advance list scan is stealth
        * In some cases, you do not want to begin with a full-scale assault on the target network
            that is likely to trigger IDS alerts and bring unwanted attention
        * you can bounce through anonymous recursive DNS servers using the --dns-servers option
    - List scan is unobtrusive and provides information
      that may be useful in choosing which individual machines to target

3.5.2. Ping Scan (-sP)
    - only perform a ping scan, then print out the available hosts that responded to the scan
    - specify Nmap Scripting Engine (--script) host scripts and traceroute probing (--traceroute) for further testing
    - Knowing how many hosts are up is MORE valuable to attackers
      than the list of every single IP and host name provided by list scan

        * example: nmap -sP -T4 www.lwn.net/24
            ** The -sP option sends an ICMP echo request and a TCP ACK packet to port 80 BY DEFAULT
            ** Unix users (or Windows users without WinPcap installed) cannot send these raw packets
                -> a SYN packet is sent instead, using a TCP connect system call to port 80 of the target host
            ** A privileged user tries to scan targets on a local ethernet network
                -> ARP requests (-PR) are used
                -> unless the --send -ip option is specified

3.5.3. Disable Ping (-PN)
    - skip Nmap discovery stage altogether 
    - By default, Nmap only performs heavy probing such as port scans,
      version detection, or OS detection against hosts that are found to be up
    - Disabling host discovery with -PN -> Nmap will attempt the requested scanning functions
      against EVERY TARGET IP address specified
        * if a class B sized target address space (/16) is specified on the command line
          -> ALL 65,536 IP addresses are scanned !!!
    - One can specify dozens of different ping probes in an attempt to elicit a response from all available hosts,
      
      BUT
    
      it is still possible that an active yet heavily firewalled machine might not reply to any of those probes.
    - to avoid missing anything, auditors frequently perform intense scans,
      such as for all 65,536 TCP ports, against every IP on the target network
        * it can slow scan times by an order of magnitude or more
        * Nmap must send retransmissions to every port in case the original probe was dropped in transit
        * Nmap must spend substantial time waiting for responses
          because it has no round-trip-time (RTT) estimate for these non-responsive IP addresses
    - if the tester has a list of machines that are already known to be up:
        * one can see no point in wasting time with the host discovery stage
        * create a list of active hosts and then pass it to Nmap using the -iL (take input from list) option
            ** this strategy is RARELY beneficial from a time-saving perspective
            ** due to the retransmission and RTT estimate issues
               even ONE unresponsive IP address in a large list will often take more time to scan
               than a WHOLE ping scanning stage would have
        * the ping stage allows Nmap to gather RTT samples
          that can speed up the following port scan,
          particularly if the target host has strict firewall rules.

3.6. Host Discovery Techniques
    - hosts can no longer be assumed unavailable based on failure to reply to ICMP ping probes
    -
]]