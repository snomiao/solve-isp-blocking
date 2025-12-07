@echo off
REM Validation script for testing Vercel IP ranges accessibility from Softbank network
REM Created for debugging Softbank ISP blocking Vercel.com issue

echo ========================================
echo Vercel IP Range Validation Script
echo Testing accessibility from your network
echo ========================================
echo.

REM Test main Vercel ranges
echo Testing main Vercel IP ranges...
echo.

echo [1/6] Testing 76.76.21.0/24 (Main Vercel range):
ping -n 2 76.76.21.1
echo.

echo [2/6] Testing 198.169.1.0/24 (vercel.com range):
ping -n 2 198.169.1.129
echo.

echo [3/6] Testing 198.169.2.0/24 (vercel.com range):
ping -n 2 198.169.2.129
echo.

echo [4/6] Testing 216.150.1.0/24:
ping -n 2 216.150.1.1
echo.

echo [5/6] Testing 216.198.79.0/24:
ping -n 2 216.198.79.1
echo.

echo [6/6] Testing 64.29.17.0/24:
ping -n 2 64.29.17.1
echo.

echo ========================================
echo HTTP/HTTPS Connectivity Tests
echo ========================================
echo.

echo Testing HTTP access to vercel.com:
curl -I http://vercel.com --max-time 10
echo.

echo Testing HTTPS access to vercel.com:
curl -I https://vercel.com --max-time 10
echo.

echo ========================================
echo DNS Resolution Test
echo ========================================
echo.

echo Testing DNS resolution for vercel.com:
nslookup vercel.com
echo.

echo Testing DNS with Google DNS:
nslookup vercel.com 8.8.8.8
echo.

echo Testing DNS with Cloudflare DNS:
nslookup vercel.com 1.1.1.1
echo.

echo ========================================
echo Network Route Analysis
echo ========================================
echo.

echo Tracing route to vercel.com:
tracert -h 10 vercel.com
echo.

echo ========================================
echo Test Results Summary
echo ========================================
echo Please check the results above:
echo - If ping succeeds: IP range is NOT blocked
echo - If ping times out: IP range is likely BLOCKED
echo - If HTTP/HTTPS fails but ping works: Port-specific blocking
echo - If DNS fails: DNS-level blocking
echo.
echo For comparison, test from a VPN or different network
echo.
pause