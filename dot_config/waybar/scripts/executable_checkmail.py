#!/usr/bin/env python3

import imaplib
import os
import configparser

dirname = os.path.split(os.path.abspath(__file__))[0]
accounts = configparser.RawConfigParser()
accounts.read(os.path.abspath(dirname + '/accounts.ini'))
str_formatted = ""

def check_imap(imap_account):
  if imap_account["useSSL"] == "true":
    client = imaplib.IMAP4_SSL(imap_account["host"], int(imap_account["port"]))
  else:
    client = imaplib.IMAP4(imap_account["host"], int(imap_account["port"]))
    client.login(imap_account["login"], imap_account["password"])
    if "folder" in imap_account:
      client.select(imap_account["folder"])
    else:
      client.select()
    return len(client.search(None, 'UNSEEN')[1][0].split())

if __name__ == "__main__":
  for account in accounts:
    current_account = accounts[account]
    print(current_account)
    if account == "DEFAULT":
      continue
    if current_account["password_cmd"]:
      if "password" in current_account:
        print("Password and password_cmd are both set. Please use only one.")
        continue
      current_account["password"] = os.popen(current_account["password_cmd"]).read().strip()
    if not current_account["icon"]:
      icon = accounts["DEFAULT"]["icon"]
    else:
      icon = current_account["icon"]
    if current_account['protocol'] == "GmailAPI":
      unread = 0
      pass
    else:
      unread = check_imap(current_account)
    str_formatted += str(unread)
  print(str_formatted)
