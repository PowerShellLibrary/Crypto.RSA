function Get-PublicKey {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0 )]
        [System.Security.Cryptography.RSACryptoServiceProvider]$cryptoServiceProvider
    )

    begin {
        Write-Verbose "Cmdlet Get-PublicKey - Begin"
    }

    process {
        Write-Verbose "Cmdlet Get-PublicKey - Process"
        if ($cryptoServiceProvider -eq $null) {
            $cryptoServiceProvider = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)
        }
        Get-KeyString $cryptoServiceProvider.ExportParameters($false)
    }

    end {
        Write-Verbose "Cmdlet Get-PublicKey - End"
    }
}