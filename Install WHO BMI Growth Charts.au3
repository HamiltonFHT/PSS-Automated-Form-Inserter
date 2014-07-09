#cs
This script loops through each record from a search in Telus Practice Solutions and adds a WHO BMI Growth Chart
to them. The search must be done separately for males and females. The title of the custom form for the Growth
Chart must be the only custom form that contains the words "BMI," "WHO," and "boys"/"girls." The first row in
the search window must be highlighted and the patient record window must be closed. If there is an error message
saying a patient must first be selected, simply open the first patient record and then close it again, then
re-run the script. If the script is stuck in the search window, open any other patient record, close it, then
click once on the first patient to highlight, then re-run the script.
#ce

;Waits until window is active; activates window if not active, then waits until it's active
Func _WinWaitActivate($title, $text, $timeout = 0)
	WinWait($title, $text, $timeout)
	If Not WinActive($title, $text) Then WinActivate($title, $text)
	WinWaitActive($title, $text, $timeout)
EndFunc   ;==>_WinWaitActivate

;Ends script if hotkey is pressed
Func _HotKeyPressed()
	Exit
EndFunc   ;==>_HotKeyPressed


;{PAUSE} will run the function _HotKeyPressed, which will stop the script
HotKeySet("{PAUSE}", "_HotKeyPressed")

;Obtain parameters from user
Local $NumRecords = InputBox("", "Enter the number of records:")
If @error = 1 Then Exit
Local $RecTitle = InputBox("", "Patient Record Window Title:")
If @error = 1 Then Exit
Local $Delay = InputBox ("", "Enter delay:")
If @error = 1 Then Exit
Local $Sex = InputBox ("", "'boys' or 'girls'")
If @error = 1 Then Exit

;Setting window title matching to match substring and be case insensitive
Opt("WinTitleMatchMode", -2)

;Loop through each record and insert the Growth Chart
While $NumRecords > 0
	_WinWaitActivate("Patients 2-19 by Doctor", "")

	Send("{ENTER}")
	;Sleep(5000)
	_WinWaitActivate($RecTitle, "")
	Send("{CTRLDOWN}{SHIFTDOWN}i126126{SHIFTUP}{CTRLUP}")
	_WinWaitActivate("Select a Form", "")
	Send("bmi{SPACE}who{SPACE}"&$Sex&"{ENTER}")
	Sleep($Delay)
	WinClose($RecTitle)
	_WinWaitActivate("Patients 2-19 by Doctor", "")
	Send("{DOWN}")
	$NumRecords = $NumRecords - 1
WEnd


;End of script