# Crypto.RSA

This is a PowerShell module for doing slack history backups.

# Installation
Module is available on [Powershell Gallery][gallery]

### Install
```powershell
PS> Install-Module -Name Crypto.RSA
```

### Import
```powershell
PS> Import-Module Crypto.RSA
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