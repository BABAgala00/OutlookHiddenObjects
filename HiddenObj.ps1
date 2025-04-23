# Use Hidden-Unicode characters to create Non-printable characters for creating a subfolder under the inbox. 
# Use Hidden-Unicode characters to create an Inbox-rule to forward messages that contain the word "test" in the subject to the "Hidden" folder.

# Define variables - replace these with your actual values
$email = "<your.email@domain.com>"    # Replace with your full email
$username = "your.email"              # Replace with your email without @domain.com

try {
    # Check if ExchangeOnlineManagement module is installed
    if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
        Write-Host "Installing ExchangeOnlineManagement module..."
        Install-Module -Name ExchangeOnlineManagement -Force -ErrorAction Stop
    }
    
    # Import the module
    Import-Module ExchangeOnlineManagement -ErrorAction Stop
    
    # Connect to Exchange Online
    Write-Host "Connecting to Exchange Online..."
    Connect-ExchangeOnline -UserPrincipalName $email -ErrorAction Stop
    
    # Create new mailbox folder with zero-width space
    Write-Host "Creating new folder..."
    New-MailboxFolder -Parent "$username:\Inbox" -Name "$([char]0x200B)" -ErrorAction Stop
    
    # Get Inbox subfolders and display
    Write-Host "Retrieving Inbox subfolders..."
    Get-MailboxFolder -Identity "$email:\Inbox" -GetChildren -ErrorAction Stop | Format-List Name, FolderPath
 
    
    # Create new inbox rule to move emails with "test" in subject
    Write-Host "Creating new inbox rule..."
    New-InboxRule -Name "$([char]0x200B)" `
                  -SubjectContainsWords "test" `
                  -MoveToFolder "$email:\Inbox\$([char]0x200B)" `
                  -ErrorAction Stop

    # Get existing inbox rules
    Write-Host "Retrieving existing inbox rules..."
    Get-InboxRule -ErrorAction Stop

    
    Write-Host "Script completed successfully!" -ForegroundColor Green
}
catch {
    Write-Error "An error occurred: $($_.Exception.Message)"
    Write-Error "Error details: $($_.Exception)"
}
