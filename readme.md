# Quick Start
- input your 24 key words into file $HOME/.coctohug/mnc.txt
- ./cchpass.sh
- answer yes to generate passphrase
- then it will prompt twice for setting a passphrase
- then it will prompt once to decrypt the encoded mnemonic file
- 5 mins later, all mnemonic.txt will be removed from your computer

# forget password
- gpg --delete-secret-key coctohug && gpg --delete-key coctohug
- then following above initialization steps to create a new password

## Trademark Notice
CHIA NETWORK INC, CHIA™, the CHIA BLOCKCHAIN™, the CHIA PROTOCOL™, CHIALISP™ and the “leaf Logo” (including the leaf logo alone when it refers to or indicates Chia), are trademarks or registered trademarks of Chia Network, Inc., a Delaware corporation. *There is no affliation between this Coctohug project and the main Chia Network project.*