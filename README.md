# Softbank ISP Blocking Vercel.com - Debug Repository

This repository contains debugging tools and documentation for the Softbank Japan ISP blocking Vercel.com issue discovered in December 2025.

## 🚨 Issue Summary

**Problem**: Softbank (ソフトバンク) ISP in Japan is blocking access to Vercel.com and most Vercel-hosted websites.

**Impact**: Users on Softbank network (including Softbank Hikari) cannot access:
- vercel.com (main website)
- Most Vercel-hosted applications
- Vercel's dashboard and services

**Root Cause**: IP-level blocking of multiple Vercel IP ranges by Softbank's network infrastructure.

## 📋 Affected IP Ranges

### ❌ **BLOCKED by Softbank**:
- `198.169.1.0/24` - Where vercel.com resolves
- `198.169.2.0/24` - Where vercel.com resolves
- `216.150.1.0/24`
- `216.150.16.0/24`
- `216.198.79.0/24`
- `64.29.17.0/24`
- `64.239.109.0/24`

### ✅ **NOT BLOCKED by Softbank**:
- `76.76.21.0/24` - Main Vercel range (accessible)

## 🔧 Quick Diagnosis

### Run the Validation Scripts

**Windows users:**
```cmd
validate-vercel-ips.bat
```

**Linux/macOS users:**
```bash
chmod +x validate-vercel-ips.sh
./validate-vercel-ips.sh
```

### Expected Results on Softbank Network
- Most IP ranges will show "Request timed out" or connection failures
- `76.76.21.1` should respond successfully
- DNS resolution works but connections fail

## 🚀 Immediate Workarounds

### 1. SSH Tunnel (If you have a VPS)
```bash
# Create SOCKS proxy through your VPS
ssh -D 8080 -N your-vps-server

# Configure browser to use localhost:8080 as SOCKS5 proxy
```

### 2. VPN Services
- Use any VPN to bypass ISP-level blocking
- Recommended: Cloudflare WARP (free), ProtonVPN, Windscribe

### 3. DNS Change (May help)
```cmd
# Windows - Run as Administrator
netsh interface ip set dns "Wi-Fi" static 1.1.1.1
netsh interface ip add dns "Wi-Fi" 1.0.0.1 index=2
```

### 4. Mobile Hotspot
- Use your phone's mobile data as a temporary workaround
- Different ISP, bypasses Softbank's blocks

## 📞 Contact Softbank Support

See [softbank-call-script.md](softbank-call-script.md) for complete Japanese call script and instructions.

**Phone**: 0800-919-0157 (toll-free)
**Hours**: 9:00-20:00 (daily)
**Chat Support**: https://www.softbank.jp/internet/support/chat-support2/?name=sbfooter

## 🔍 Technical Analysis

### Blocking Methodology
- **Type**: IP-level blocking (not DNS)
- **Scope**: Selective range blocking (not all Vercel IPs)
- **Network Level**: Occurs at hop 3-4 in Softbank's routing infrastructure

### Evidence
- DNS resolution works correctly
- Ping to blocked IPs times out
- Traceroute shows blocking at Softbank's network edge
- Same IPs accessible from non-Softbank networks

### Timeline
- **Discovered**: December 2025
- **Scope**: Affects multiple Vercel IP ranges
- **ISP**: Softbank Corp (AS17676)

## 📊 Test Results

### From Softbank Network:
```
198.169.1.129 - 100% packet loss ❌
198.169.2.129 - 100% packet loss ❌
76.76.21.1    - 0% packet loss ✅
```

### From External VPS:
```
198.169.1.129 - 0% packet loss ✅
198.169.2.129 - 0% packet loss ✅
76.76.21.1    - 0% packet loss ✅
```

## 🔗 Related Issues

- This appears to be an isolated incident specific to Softbank Japan
- No other ISPs in Japan have reported similar blocking
- Vercel has no known policy to block Japanese traffic
- No government-mandated blocks identified

## 🤝 Contributing

If you're experiencing similar issues:

1. Run the validation scripts
2. Report your results by opening an issue
3. Include your ISP information and location
4. Share any workarounds you've discovered

## 📚 Files in This Repository

- `validate-vercel-ips.bat` - Windows validation script
- `validate-vercel-ips.sh` - Unix/Linux validation script
- `softbank-call-script.md` - Japanese call script for Softbank support
- `README.md` - This documentation
- `FINDINGS.md` - Detailed technical findings

## ⚠️ Disclaimer

This repository is for educational and debugging purposes. The information is provided as-is for users experiencing connectivity issues with Vercel services through Softbank ISP.

---

**Last Updated**: December 7, 2025
**Status**: Active Issue
**ISP**: Softbank Japan
**Affected Service**: Vercel.com and hosted applications