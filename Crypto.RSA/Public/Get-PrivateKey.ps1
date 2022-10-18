function Get-PrivateKey {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0 )]
        [System.Security.Cryptography.RSACryptoServiceProvider]$cryptoServiceProvider
    )

    begin {
        Write-Verbose "Cmdlet Get-PrivateKey - Begin"
    }

    process {
        Write-Verbose "Cmdlet Get-PrivateKey - Process"
        if ($cryptoServiceProvider -eq $null) {
            $cryptoServiceProvider = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)
        }
        Get-KeyString $cryptoServiceProvider.ExportParameters($true)
    }

    end {
        Write-Verbose "Cmdlet Get-PrivateKey - End"
    }
}