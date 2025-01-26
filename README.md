# 📧 silverlps.email
BisonBackup modules for handling email operations

This module package was written for the BisonBackup software but outside of the project just for my personal needs. For more information about the project and detailed usage instructions, please refer to the [project site](https://github.com/SilverLPs/BisonBackup).

---

## Requirements
This package relies on the following software:
- [offlineimap](https://en.wikipedia.org/wiki/OfflineIMAP)

Before using the modules in this package, please ensure that the listed software and all its dependencies are installed and available on your system.

---

## Modules
Below is a list of all modules currently included in this package, along with their respective parameters:

**sync** - Synchronizes a mail account, including all its contents, to a local folder via IMAP.
- SOURCE = The URL of the IMAP server. Example: "imap.mymailprovider.com"
- DESTINATION = The local directory where the mail account will be synchronized. A new folder will automatically be created in the specified directory, named after the ACCOUNTNAME parameter.
- ACCOUNTNAME = A unique name for the account's local settings. This name must be unique and should not be reused for another account.
- USERNAME = The username for authentication with the IMAP server.
- PASSWORD = The password for authentication with the IMAP server.

---

## Known Issues and Additional Notes

- **Non-ASCII/UTF7 characters in filenames:** Filenames containing such characters (e.g., from email subjects) may cause issues. However, the email content itself will remain unaffected.
- **Read-only sync:** This module configures OfflineIMAP to handle mail accounts in a read-only mode. For added security, you should regularly back up your local email synchronization folder using incremental backup software like Borg to safeguard against potential data loss in your mail account.
- **Verbose output:** OfflineIMAP offers only two output modes: completely quiet or fully detailed. To provide useful feedback, this module uses the detailed mode. Be aware that the initial synchronization may produce extensive output or fill your log files.
- **Cache folders:** OfflineIMAP creates cache folders for each local MailDir and remote mail account in $HOME/.offlineimap. Modifying, renaming, or deleting these cache folders without proper care can lead to issues such as redownloading emails, data corruption, or loss. If you need to make changes, ensure you also delete the corresponding cache or MailDir folders and start fresh to avoid problems.
- **File permissions:** OfflineIMAP ignores umasks, which may require you to manually adjust file and folder permissions after synchronization. You can use the bisonbackup.general.permissions module to streamline this process.
- **OAuth2 limitations:** OfflineIMAP does not fully support OAuth2. As a result, some accounts may encounter issues. For example, Microsoft 365/Outlook accounts are not currently supported, although Gmail should still work for now.
- **Rare errors:**
  - Occasionally, the following error may occur: ERROR: UID XXX (<Unknown Message-ID>) has defects preventing it from being processed! UnicodeEncodeError: 'ascii' codec can't encode characters in position XXX: ordinal not in range(128)'. This issue typically affects only the specific emails involved and does not disrupt other synchronizations.
  - A separate issue involving incorrect or missing separators has been observed but could not be reliably reproduced.
- **Experimental nature:** This module is currently a "better-than-nothing" solution. It is not guaranteed to be error-free, and users should be prepared for potential issues.

---

## Roadmap
- **Evaluate a switch to isync/mbsync:** These tools may resolve many of the issues associated with OfflineIMAP.
- **Optional backend support:** Consider retaining OfflineIMAP as an optional backend, allowing users to switch between backends via a parameter.

---

## License and Disclaimer

This software is licensed under the MIT License. See [LICENSE](LICENSE) for more details.

### Disclaimer of Warranty and Responsibility

BisonBackup is a private project developed in my spare time. It is provided "as is" without any warranty of any kind, either expressed or implied. I cannot offer any guarantees regarding its functionality, security, or suitability for a specific purpose. Anyone using the software does so entirely at their own risk.

### Use at Your Own Risk

Users are encouraged to thoroughly review the scripts and modules before using them. The software, including BisonBackup itself and all associated modules, is intended for technically proficient users who understand the potential risks and can assess whether the software meets their requirements. If you are not confident in your technical ability to understand or review the code, I strongly advise against using this software.

### Recommendations for Technical Users

- Carefully review the provided scripts and configurations before running them.
- Test the software in a safe environment before applying it to critical data or systems. 
- Use the software only if you are comfortable with its functionality and limitations.

This project is not intended for non-technical users, and I explicitly discourage anyone without a strong technical understanding from using this software.
