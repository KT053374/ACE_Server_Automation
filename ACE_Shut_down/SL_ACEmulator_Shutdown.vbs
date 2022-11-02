strComputer = "."
Dim objWMIService
Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colProcesses = objWMIService.ExecQuery("SELECT * FROM Win32_Process WHERE ExecutablePath = 'C:\\ACE\\Server\\ACE.Server.exe'")

For Each objProcess in colProcesses
    If objProcess.GetOwner(User, Domain) = 0 Then
	Set WshShell = WScript.CreateObject("WScript.Shell")
		WshShell.AppActivate(objProcess.ProcessId)
		WshShell.SendKeys "@set-shutdown-interval 300"
		WshShell.SendKeys "{ENTER}"
		WScript.Sleep 1000
		WshShell.SendKeys "@Shutdown"
		WshShell.SendKeys "{ENTER}"
    Else
        WScript.Echo "Problem " & Rtn & " getting the owner for process " & objProcess.Caption
    End If
Next