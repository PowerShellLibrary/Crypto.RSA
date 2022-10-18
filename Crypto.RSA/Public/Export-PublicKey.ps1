# src: https://gist.github.com/therightstuff/aa65356e95f8d0aae888e9f61aa29414
function Export-PublicKey {
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [System.Security.Cryptography.RSACryptoServiceProvider]$csp
    )

    $outputStream = [System.IO.StringWriter]::new()
    $parameters = $csp.ExportParameters($false);
    Use ( $stream = [System.IO.MemoryStream]::new()) {
        $writer = [System.IO.BinaryWriter]::new($stream);
        $writer.Write([byte]0x30); # SEQUENCE
        Use ($innerStream = [System.IO.MemoryStream]::new()) {
            $innerWriter = [System.IO.BinaryWriter]::new($innerStream);
            $innerWriter.Write([byte]0x30); # SEQUENCE
            EncodeLength $innerWriter 13
            $innerWriter.Write([byte]0x06); # OBJECT IDENTIFIER
            $rsaEncryptionOid = @(0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01 )
            EncodeLength $innerWriter $rsaEncryptionOid.Length
            $innerWriter.Write($rsaEncryptionOid);
            $innerWriter.Write([byte]0x05); # NULL
            EncodeLength $innerWriter 0
            $innerWriter.Write([byte]0x03); # BIT STRING
            Use ($bitStringStream = [System.IO.MemoryStream]::new()) {
                $bitStringWriter = [System.IO.BinaryWriter]::new($bitStringStream);
                $bitStringWriter.Write([byte]0x00); # # of unused bits
                $bitStringWriter.Write([byte]0x30); # SEQUENCE
                Use ($paramsStream = [System.IO.MemoryStream]::new()) {
                    $paramsWriter = [System.IO.BinaryWriter]::new($paramsStream);
                    EncodeIntegerBigEndian $paramsWriter $parameters.Modulus  # Modulus
                    EncodeIntegerBigEndian $paramsWriter $parameters.Exponent  # Exponent
                    [int]$paramsLength = $paramsStream.Length;
                    EncodeLength $bitStringWriter $paramsLength
                    $bitStringWriter.Write($paramsStream.GetBuffer(), 0, $paramsLength);
                }
                [int]$bitStringLength = $bitStringStream.Length;
                EncodeLength $innerWriter $bitStringLength
                $innerWriter.Write($bitStringStream.GetBuffer(), 0, $bitStringLength);
            }
            [int]$length = $innerStream.Length;
            EncodeLength $writer $length
            $writer.Write($innerStream.GetBuffer(), 0, $length);
        }

        $base64 = [System.Convert]::ToBase64String($stream.GetBuffer(), 0, [int]$stream.Length).ToCharArray();
        $outputStream.Write("-----BEGIN PUBLIC KEY-----`n");
        for ($i = 0; $i -lt $base64.Length; $i += 64) {
            $outputStream.Write($base64, $i, [System.Math]::Min(64, $base64.Length - $i));
            $outputStream.Write("`n");
        }
        $outputStream.Write("-----END PUBLIC KEY-----");
    }

    return $outputStream.ToString();
}