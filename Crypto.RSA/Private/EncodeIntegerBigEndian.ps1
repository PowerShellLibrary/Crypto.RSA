function EncodeIntegerBigEndian {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0 )]
        [System.IO.BinaryWriter]$stream,
        [Parameter(Mandatory = $true, Position = 1 )]
        [byte[]]$value,
        [Parameter(Mandatory = $false, Position = 2 )]
        [bool]$forceUnsigned = $true
    )

    process {
        $stream.Write([byte]0x02); # INTEGER
        $prefixZeros = 0;
        for ($i = 0; $i -lt $value.Length; $i++) {
            if ($value[$i] -ne 0) {
                break
            }
            $prefixZeros++;
        }
        if ($value.Length - $prefixZeros -eq 0) {
            EncodeLength $stream 1
            $stream.Write([byte]0);
        }
        else {
            if ($forceUnsigned -and $value[$prefixZeros] -gt 0x7f) {
                # Add a prefix zero to force unsigned if the MSB is 1
                EncodeLength $stream ($value.Length - $prefixZeros + 1)
                $stream.Write([byte]0);
            }
            else {
                EncodeLength $stream ($value.Length - $prefixZeros)
            }
            for ($i = $prefixZeros; $i -lt $value.Length; $i++) {
                $stream.Write($value[$i]);
            }
        }
    }
}