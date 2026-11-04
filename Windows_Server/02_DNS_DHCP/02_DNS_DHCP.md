# DNS & DHCP Configuration

## Why DNS & DHCP?

DNS allows clients to resolve `vitaltech.local` to the server IP.
DHCP automatically assigns IP addresses to domain-joined clients.

Without these two services, clients cannot find or join the domain.

## DNS Configuration

| Setting | Value |
|---|---|
| Zone | vitaltech.local |
| Type | Primary zone |
| DNS Server IP | 172.16.10.1 |
| Listener | Internal interface only |

### Key decisions

- DNS restricted to internal NIC (`172.16.10.1`) only
- External NIC (NAT `192.168.122.x`) excluded from DNS registration
- Server points to itself for DNS resolution

> **Why restrict DNS to internal interface?**
> On a multi-NIC server, DNS registers all interfaces by default.
> This causes spurious replication failures (`dcdiag` errors: Basc, RReg).
> Restricting DNS to the internal NIC prevents this.

## DHCP Configuration

| Setting | Value |
|---|---|
| Scope | 172.16.10.100 – 172.16.10.200 |
| Subnet mask | 255.255.255.0 |
| Default gateway | 172.16.10.1 |
| DNS server (Option 006) | 172.16.10.1 |
| Authorized in AD | Yes |

## Result

- DNS zone `vitaltech.local` resolving correctly ✅
- DHCP authorized in Active Directory ✅
- Clients receive IP + DNS automatically ✅
