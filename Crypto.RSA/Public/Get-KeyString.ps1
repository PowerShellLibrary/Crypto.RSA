function Get-KeyString {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [System.Security.Cryptography.RSAParameters]$publicKey
    )

    begin {
        Write-Verbose "Cmdlet Get-KeyString - Begin"
    }

    process {
        Write-Verbose "Cmdlet Get-KeyString - Process"
        $stringWriter = [System.IO.StringWriter]::new()
        $xmlSerializer = [System.Xml.Serialization.XmlSerializer]::new([System.Security.Cryptography.RSAParameters])
        $xmlSerializer.Serialize($stringWriter, $publicKey)
        $stringWriter.ToString()
    }

    end {
        Write-Verbose "Cmdlet Get-KeyString - End"
    }
}