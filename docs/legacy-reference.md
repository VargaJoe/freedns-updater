# Legacy script reference

The preserved [src/update-freedns.ps1](../src/update-freedns.ps1) is a one-shot
Windows PowerShell updater. It takes mandatory `Domain` and `Key` parameters,
compares the detected public address with a DNS answer, requests a FreeDNS update
when they differ, and writes a log. It can be invoked periodically by Task
Scheduler. It is historical source, not recommended for a new deployment.

## Known limitations

- Public-IP discovery and the default FreeDNS update endpoint use HTTP.
- Although the script declares `SupportsShouldProcess`, the provider request is
  not guarded by `ShouldProcess`. `-WhatIf` can still send a real update.
- A missing log directory is not created automatically.
- Provider-level failures returned in an HTTP 200 body are not interpreted as
  failures and may still lead to exit code 0.
- The script uses the first DNS answer and does not explicitly select an address
  family; DNS errors and multiple records need careful handling.

An installed launcher may differ from the repository script. Preserve and assess
that installation separately rather than overwriting it with this historical file.
Opening an update URL in a browser can modify a record; do not treat it as a
read-only diagnostic.

The retirement change does not modify the script or fix these limitations. Use
the recommended replacement and [migration checklist](retirement.md) instead.
The source remains under its existing [license](../LICENSE).
