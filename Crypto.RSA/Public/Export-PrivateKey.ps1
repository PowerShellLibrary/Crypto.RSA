# src: https://gist.github.com/therightstuff/aa65356e95f8d0aae888e9f61aa29414
function Export-PrivateKey {
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [System.Security.Cryptography.RSACryptoServiceProvider]$csp
    )

    $outputStream = [System.IO.StringWriter]::new()
    if ($csp.PublicOnly) {
        throw [System.ArgumentException]::new("CSP does not contain a private key", "csp")
    }
    $parameters = $csp.ExportParameters($true);


    Use ($stream = [System.IO.MemoryStream]::new()) {
        $writer = [System.IO.BinaryWriter]::new($stream);
        $writer.Write([byte]0x30); # SEQUENCE
        Use ($innerStream = [System.IO.MemoryStream]::new()) {
            $innerWriter = [System.IO.BinaryWriter]::new($innerStream);
            EncodeIntegerBigEndian $innerWriter @([byte]0x00)
            EncodeIntegerBigEndian $innerWriter $parameters.Modulus
            EncodeIntegerBigEndian $innerWriter $parameters.Exponent
            EncodeIntegerBigEndian $innerWriter $parameters.D
            EncodeIntegerBigEndian $innerWriter $parameters.P
            EncodeIntegerBigEndian $innerWriter $parameters.Q
            EncodeIntegerBigEndian $innerWriter $parameters.DP
            EncodeIntegerBigEndian $innerWriter $parameters.DQ
            EncodeIntegerBigEndian $innerWriter $parameters.InverseQ
            [int]$length = $innerStream.Length;
            EncodeLength $writer $length
            $writer.Write($innerStream.GetBuffer(), 0, $length);
        }

        $base64 = [System.Convert]::ToBase64String($stream.GetBuffer(), 0, [int]$stream.Length).ToCharArray();
        $outputStream.Write("-----BEGIN RSA PRIVATE KEY-----`n");
        for ($i = 0; $i -lt $base64.Length; $i += 64) {
            $outputStream.Write($base64, $i, [System.Math]::Min(64, $base64.Length - $i));
            $outputStream.Write("`n");
        }
        $outputStream.Write("-----END RSA PRIVATE KEY-----");
    }

    return $outputStream.ToString();
}