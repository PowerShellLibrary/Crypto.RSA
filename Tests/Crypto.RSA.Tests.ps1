Clear-Host
Import-Module -Name Pester -Force
Import-Module .\Crypto.RSA\Crypto.RSA.psm1 -Force

Describe 'Crypto.RSA.Tests' {
    Context "Keys generation" {
        It "Generates public and private keys" {
            $keys = New-KeyPair
            $keys.public | Should -Not -BeNullOrEmpty
            $keys.private | Should -Not -BeNullOrEmpty
        }

        It "Generates private key - using the same csp" {
            $csp = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)
            $keys = New-KeyPair $csp
            Get-PrivateKey $csp | Should Be $keys.private
        }

        It "Generates private key - using different csp" {
            $keys = New-KeyPair
            Get-PrivateKey | Should Not Be $keys.private
        }

        It "Generates public key - using the same csp" {
            $csp = [System.Security.Cryptography.RSACryptoServiceProvider]::new(2048)
            $keys = New-KeyPair $csp
            Get-PublicKey $csp | Should Be $keys.public
        }

        It "Generates public key - using different csp" {
            $keys = New-KeyPair
            Get-PublicKey | Should Not Be $keys.public
        }
    }

    Context "String encryption - happy path" {
        $keys = New-KeyPair
        $plain = "Crypto.RSA"

        $encryptedText = Protect-String $plain $keys.public
        $decryptedText = Unprotect-String $encryptedText $keys.private

        It "Encrypted text is NOT the same as plain" {
            $encryptedText | Should -Not -Be $plain
        }
        It "Decrypted text is the same as plain" {
            $decryptedText | Should -Be $plain
        }
    }

    Context "String encryption - incorrect private key" {
        $keys = New-KeyPair
        $incorrect_keys = New-KeyPair
        $plain = "Crypto.RSA"
        $encryptedText = Protect-String $plain $keys.public

        It "Decrypted with valid key works" {
            Unprotect-String $encryptedText $keys.private | Should -Be $plain
        }

        It "Decrypted with invalid key throws an exception" {
            { Unprotect-String $encryptedText $incorrect_keys.private } | Should Throw "Cryptography_OAEPDecoding"
        }
    }
}