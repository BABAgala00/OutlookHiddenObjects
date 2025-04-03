# Outlook Hidden Objects
Defense Evasion - Outlook Hidden Objects


Outlook Hidden Objects

Using hidden Unicode characters to hide Outlook objects, such as creating a "hidden" folder and hidden Inbox-Rule, and forwarding emails to the "hidden" folder by simply no-name it, just for fun.

This can't be done via the GUI, so I PowerShell to do so.

May trigger a web view authentication window to the user.

Required PowerShell from an elevated shell.

Tested with PSVersion 5.1.22621.4391.







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
