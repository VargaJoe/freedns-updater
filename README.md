# freedns-updater
powershell script for update ip of freedns

# what's this

It is a small powershell script to update dynamic ip of your ["Free DNS"](http://freedns.afraid.org/) domains if the host ip is changed.

# how it works

Simply call the script with your domains and keyL

```powershell
.\update-freedns.ps1 -Domain "yoursubdomain.afraid.org" -Key "yourupdatekey"
```

The script wil create a log under `logs` subfolder by default. Another path can be set via `-LogFolder` parameter.

```powershell
.\update-freedns.ps1 -Domain "yoursubdomain.afraid.org" -Key "yourupdatekey" -LogFolder "C:\your\log\folder\path"
```

It can be used with Windows Task Scheduler to automate the process.