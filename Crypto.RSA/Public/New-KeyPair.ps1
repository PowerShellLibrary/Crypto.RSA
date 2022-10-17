function New-KeyPair {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0 )]
        [System.Security.Cryptography.RSACryptoServiceProvider]$cryptoServiceProvider
    )

    begin {
        Write-Verbose "Cmdlet New-KeyPair - Begin"
    }

    process {
        Write-Verbose "Cmdlet New-KeyPair - Process"
        if ($cryptoServiceProvider -eq $null) {
            $cryptoServiceProvider = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)
        }
        $privateKey = $cryptoServiceProvider.ExportParameters($true)
        $publicKey = $cryptoServiceProvider.ExportParameters($false)
        @{
            'public'  = Get-KeyString $publicKey
            'private' = Get-KeyString $privateKey
        }
    }

    end {
        Write-Verbose "Cmdlet New-KeyPair - End"
    }
}