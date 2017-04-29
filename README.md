# MS17-010
MS17-010 is the Microsoft security bulletin which fixes several remote code execution vulnerabilities in the SMB service on Windows systems.

There are numerous things about MS17-010 that make it esoteric, such as manipulating the Windows kernel pool heap allocations, running remote Windows ring 0 shellcode, and the intricacies of the different SMB protocol versions.

We previously improved the ExtraBacon exploit. https://github.com/RiskSense-Ops/CVE-2016-6366

## Scanners
There is a Metasploit scanner and a Python port. The scanners are able to use uncredentialed information leakage to determine if the MS17-010 patch is installed on a host. If it is not installed, it will also check for a DoublePulsar infections.

## Exploits
There is a Python script that can reliably infect Windows Server 2008 R2 SP1 with DoublePulsar using the same technique as EternalBlue.

## Payloads
Windows ring 0 shellcode is being crafted so that instead of DoublePulsar, the transition from ring 0 to ring 3 and running usermode payloads, directly with or without DLL, is done in a single step. The size of the code is also being reworked, as the original shellcode appears to be compiler output, in order to accomodate more complex userland payloads in the first stage.

## Resources 
- https://zerosum0x0.blogspot.com/2017/04/doublepulsar-initial-smb-backdoor-ring.html
- https://countercept.com/our-thinking/analyzing-the-doublepulsar-kernel-dll-injection-technique/
- https://www.rapid7.com/db/modules/auxiliary/scanner/smb/smb_ms17_010

### Credits
- @zerosum0x0
- @jennamagius
- @The_Naterz
- @Aleph___Naught
- @nixawk
- @JukeLennings (Countercept)

### Acknowledgements
- Shadow Brokers
- Equation Group
- skape
- Stephen Fewer
