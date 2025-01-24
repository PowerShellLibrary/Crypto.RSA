# Crypto.RSA
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/Crypto.RSA?label=Crypto.RSA&color=blue&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciICB2aWV3Qm94PSIwIDAgNDggNDgiIHdpZHRoPSI0OHB4IiBoZWlnaHQ9IjQ4cHgiPjxwYXRoIGZpbGw9IiMwMjc3YmQiIGQ9Ik0xOS44NDcsNDEuOTU2Yy01LjYyOS0wLjAwMi0xMS4yNTksMC4wMjQtMTYuODg4LTAuMDEzYy0yLjg1NS0wLjAxOS0zLjM3NC0wLjctMi43MzEtMy41MjUgYzIuMTc4LTkuNTgsNC40MjctMTkuMTQzLDYuNTU3LTI4LjczNEM3LjM1Niw3LjExMiw4LjU4OCw1Ljk3NSwxMS4zMTIsNkMyMi41Nyw2LjEwNiwzMy44MjksNi4wMzQsNDUuMDg4LDYuMDQ2IGMyLjgyNCwwLjAwMywzLjI5OCwwLjYxNCwyLjY2NCwzLjUxMWMtMi4wNTgsOS40MDYtNC4xMjksMTguODA5LTYuMjM2LDI4LjIwM2MtMC43ODksMy41MTYtMS42OTcsNC4xODctNS4zNTMsNC4xOTUgQzMwLjcyNCw0MS45NjYsMjUuMjg1LDQxLjk1OCwxOS44NDcsNDEuOTU2eiIvPjxwYXRoIGZpbGw9IiNmYWZhZmEiIGQ9Ik0yNS4wNTcgMjMuOTIyYy0uNjA4LS42ODctMS4xMTQtMS4yNjctMS41MzEtMS43MzItMi40My0yLjcyOC00LjY1Ni01LjI3LTcuMDYzLTcuODY5LTEuMTAyLTEuMTg5LTEuNDUzLTIuMzQ0LS4xMy0zLjUxOCAxLjMwNy0xLjE2IDIuNTkyLTEuMDU4IDMuNzkxLjI3NyAzLjM0IDMuNzE3IDYuNjc2IDcuNDM4IDEwLjA3MSAxMS4xMDQgMS4yNjggMS4zNjkuOTcyIDIuMy0uNDI0IDMuMzE1LTUuMzU5IDMuODk1LTEwLjY4NyA3LjgzMy0xNi4wMSAxMS43NzgtMS4xOTYuODg3LTIuMzM3IDEuMTA5LTMuMzA0LS4yMDEtMS4wNjYtMS40NDUtLjA4LTIuMzA1IDEuMDI2LTMuMTE0IDMuOTU1LTIuODkzIDcuOTAzLTUuNzk4IDExLjgzNC04LjcyNUMyMy44NjUgMjQuODMgMjQuNTk1IDI0LjI2NyAyNS4wNTcgMjMuOTIyek0yMS43NSAzN0MyMC42MjUgMzcgMjAgMzYgMjAgMzVzLjYyNS0yIDEuNzUtMmM0LjIyNCAwIDYuMTEyIDAgOS41IDAgMS4xMjUgMCAxLjc1IDEgMS43NSAycy0uNjI1IDItMS43NSAyQzI5LjEyNSAzNyAyNSAzNyAyMS43NSAzN3oiLz48L3N2Zz4=)](https://www.powershellgallery.com/packages/Crypto.RSA)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)

This is a PowerShell module for doing slack history backups.

# Installation
Module is available on [Powershell Gallery][gallery]

### Install
```powershell
Install-Module -Name Crypto.RSA
```

### Import
```powershell
Import-Module Crypto.RSA
```
# Usage

```powershell
$keys = New-KeyPair
$plain = "Crypto.RSA"
$encryptedText = Protect-String $plain $keys.public
$decryptedText = Unprotect-String $encryptedText $keys.private

Write-Host "Encryption:" -ForegroundColor Green
Write-Host "[$plain] `t=> `t[$encryptedText]"
Write-Host "Decryption:" -ForegroundColor Green
Write-Host "[$decryptedText] `t<= `t[$encryptedText]"
```

**Output:**

```plain
Encryption:
[Crypto.RSA]    =>      [e7BM+iNpec8Uc90me8U8edKWKT7cpxSaBoBu62ReATypqxmq/oagPke3jUX955RMP7sL/mvXcpV75j2/i9QL5EmcPvKpvGpByQ2EIaxIAtV73ukp7v0jXSCsp965mOX6WcvuyWH6sn8y9jZSYauWo0eFoKzddf0GQJBHYDcNqgpUya9GwhzzP4wOuNW9D1kKqgIbnVqt92xuES1o3qe1ecd1n/8eu1I9szjFWu58C9XzHiXYC9lJD+y0be6Ft1gf4n/ASGC7mJCiiXqnzTlNcEP8Pg8UyqealCn/EdbpKLGfwpl5RgSLpk7jZq3SEo+6wrymp/fhDr2ALlv7gACtYw==]
Decryption:
[Crypto.RSA]    <=      [e7BM+iNpec8Uc90me8U8edKWKT7cpxSaBoBu62ReATypqxmq/oagPke3jUX955RMP7sL/mvXcpV75j2/i9QL5EmcPvKpvGpByQ2EIaxIAtV73ukp7v0jXSCsp965mOX6WcvuyWH6sn8y9jZSYauWo0eFoKzddf0GQJBHYDcNqgpUya9GwhzzP4wOuNW9D1kKqgIbnVqt92xuES1o3qe1ecd1n/8eu1I9szjFWu58C9XzHiXYC9lJD+y0be6Ft1gf4n/ASGC7mJCiiXqnzTlNcEP8Pg8UyqealCn/EdbpKLGfwpl5RgSLpk7jZq3SEo+6wrymp/fhDr2ALlv7gACtYw==]
```

[gallery]: https://www.powershellgallery.com/packages/Crypto.RSA