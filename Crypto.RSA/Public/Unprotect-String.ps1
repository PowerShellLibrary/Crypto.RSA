function Unprotect-String {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [string]$textToDecrypt,

        [Parameter(Mandatory = $true, Position = 1 )]
        [string]$privateKeyString
    )

    begin {
        Write-Verbose "Cmdlet Unprotect-String - Begin"
    }

    process {
        Write-Verbose "Cmdlet Unprotect-String - Process"

        Use ($rsa = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)) {
            try {

                $rsa.FromXmlString($privateKeyString);

                $resultBytes = [System.Convert]::FromBase64String($textToDecrypt);
                $decryptedBytes = $rsa.Decrypt($resultBytes, $true);
                $decryptedData = [System.Text.Encoding]::UTF8.GetString($decryptedBytes);
                return $decryptedData.ToString()
            }
            finally {
                $rsa.PersistKeyInCsp = $false;
            }
        }
    }

    end {
        Write-Verbose "Cmdlet Unprotect-String - End"
    }
}