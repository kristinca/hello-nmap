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

]]