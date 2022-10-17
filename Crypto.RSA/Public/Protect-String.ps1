function Protect-String {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [string]$textToEncrypt,

        [Parameter(Mandatory = $true, Position = 1 )]
        [string]$publicKeyString
    )

    begin {
        Write-Verbose "Cmdlet Protect-String - Begin"
    }

    process {
        Write-Verbose "Cmdlet Protect-String - Process"

        $bytesToEncrypt = [System.Text.Encoding]::UTF8.GetBytes($textToEncrypt)
        Use ($rsa = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)) {
            try {
                $rsa.FromXmlString($publicKeyString.ToString());
                $encryptedData = $rsa.Encrypt($bytesToEncrypt, $true);
                $base64Encrypted = [System.Convert]::ToBase64String($encryptedData);
                $base64Encrypted;
            }
            finally {
                $rsa.PersistKeyInCsp = $false;
            }
        }
    }

    end {
        Write-Verbose "Cmdlet Protect-String - End"
    }
}