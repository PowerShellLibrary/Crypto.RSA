function EncodeLength {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [System.IO.BinaryWriter]$stream,
        [Parameter(Mandatory = $true, Position = 1 )]
        [int]$length
    )

    process {
        if ($length -lt 0) {
            throw [System.ArgumentOutOfRangeException]::new("$length", "Length must be non-negative")
        }
        if ($length -lt 0x80) {
            # Short form
            $stream.Write([byte]$length)
        }
        else {
            # Long form
            $temp = $length;
            $bytesRequired = 0;
            while ($temp -gt 0) {
                $temp = $temp -shr 8;
                $bytesRequired++;
            }
            $stream.Write([byte]($bytesRequired -bor 0x80));
            for ($i = $bytesRequired - 1; $i -ge 0; $i--) {
                $stream.Write([byte]($length -shr (8 * $i) -band 0xff));
            }
        }
    }
}