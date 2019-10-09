Brute-force login attacks commonly target management ports as a means to gain access to a virtual machine or server. If successful, an attacker can take control over the host and establish a foothold into your environment. A brute-force attack consists of checking all possible user names or passwords until the correct one is found.

This isn’t the most sophisticated form of attack, but tools such as THC-Hydra make this a relatively simple attack to perform as shown in the following command sequence used to attack a Windows server.

```bash
user@debian$ hydra -l administrator -P wordlist.txt rdp://13.66.150.191 -t 1 -V -f
```

```output
Hydra v9.0 (c) 2004 by van Hauser/THC - Please do not use in military or secret service organizations, or for illegal purposes.

Hydra (http://www.thc.org) starting at 2019-10-10 17:38:44
[DATA] max 7 tasks per 1 server, overall 64 tasks, 7 login tries (1:1/p:7), ~0 tries per task
[DATA] attacking service rdp on port 3389
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "123456"
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "654321" 
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "password"
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "iloveyou"
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "rockyou"
...
[ATTEMPT] target 13.66.150.191 – login “administrator” – pass "P@ssword!123"
[3389][rdp] host 13.66.150.191 login: administrator  password: P@ssword!123
[STATUS] attack finished for 13.66.150.191 (waiting for children to complete tests)
```

### Stopping brute-force attacks

To counteract brute-force attacks, you can take multiple measures such as:

* Disabling the public IP address and using one of these connection methods:
  * Use a point-to-site virtual private network (VPN)
  * Create a site-to-site VPN
  * Use Azure ExpressRoute to create secure links from your on-premise network to Azure

* Require two-factor authentication
* Increase password length and/or complexity
* Limit login attempts
* Implement Captcha
* Limiting the amount of time that the ports are open

This final approach is what Azure Security Center implements on your behalf. Management ports such as Remote Desktop and SSH only need to be open while you are connected to the VM, for example to perform management or maintenance tasks. In the _standard tier_, Azure Security Center supports **Just-in-time (JIT) virtual machine (VM) access**. When just-in-time access is enabled, Security Center uses network security group (NSG) rules to restrict access to management ports when they aren't in use so they cannot be targeted by attackers.

## Enabling JIT VM Access

When you enable JIT VM Access for your VMs, you can create a policy that determines the ports to help protect, how long ports should remain open, and the approved IP addresses that can access these ports. The policy helps you stay in control of what users can do when they request access. Requests are logged in the Azure activity log, so you can easily monitor and audit access. The policy will also help you quickly identify the existing VMs that have JIT VM Access enabled and the VMs where JIT VM Access is recommended.
