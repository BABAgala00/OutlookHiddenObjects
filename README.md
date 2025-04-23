## Outlook Hidden Objects - Defense Evasion \ Evading Pattern Detection ##

### Yet another way of inbox-manipulation-rules using characters that are hidden in ASCII to "hide" Outlook objects.<br/><br/>




### Inspired from:<br/>
[Search-StringInAD](https://github.com/YossiSassi/Search-StringInAD) which lookup for (hidden) Unicode characters in AD Objects (e.g hidden account):<br/>
<br/>

From [Microsoft Inbox-manipulation-rules Investigation steps](https://learn.microsoft.com/en-us/defender-xdr/alert-grading-playbook-inbox-manipulation-rules):<br/>
_An attacker might manipulate the Inbox-rule only to emails that contain certain words. You can find these keywords under certain attributes such as: "BodyContainsWords," "SubjectContainsWords," or "SubjectOrBodyContainsWords."_ and "MoveToFolder" - **But what if we use Non-printing characters?** 
<br/><br/>


### This script assumes you have the necessary permissions to:<br/>

* Install PowerShell modules
* Connect to Exchange Online
* Create mailbox folders & inbox-rules (Default permission to mailbox owner for domain users)
<br/><br/>

### PoC

https://github.com/user-attachments/assets/167022b3-9bb5-4bb7-b081-df3f7a88a82c



