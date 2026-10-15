# FreeDNS Updater

**Retired: no further development or ongoing support is planned.** This repository
is retained for historical reference. Existing installations are not changed by
this notice.

## Reason for archival

This project began as a small Windows PowerShell script for updating FreeDNS
records when the public IP address changes. A separate modernization effort would
now duplicate capabilities already available in existing DDNS clients: provider
configuration, container operation, ARM support and update history.

The required FreeDNS workflow can be handled by an existing client. Maintaining a
second update engine, its provider integrations and deployment tooling no longer
provides enough benefit to justify the maintenance work. The modernization plans
have therefore been discontinued, and this repository is being archived as a
historical record rather than developed further.

## Recommended alternative

Consider **[qdm12/ddns-updater](https://github.com/qdm12/ddns-updater)**, an independent
project with FreeDNS and other DNS provider integrations, Docker images including
ARM variants, persistent update history and a status WebUI.

Start with its [documentation](https://github.com/qdm12/ddns-updater#readme) and
[FreeDNS setup guide](https://github.com/qdm12/ddns-updater/blob/master/docs/freedns.md).
Choose an upstream version suitable for your platform and follow that version's
instructions. This repository does not maintain or provide support for the
replacement.

FreeDNS migration needs particular care: the replacement's FreeDNS v2 token is
not interchangeable with the legacy `dynamic/update.php` key. See the generic
[migration and retirement notes](docs/retirement.md) before switching updaters.

## Historical source

The original [PowerShell script](src/update-freedns.ps1) remains available unchanged.
It has known limitations, including HTTP defaults and ineffective `-WhatIf`
protection. It is not recommended for new deployments. See the
[legacy reference](docs/legacy-reference.md) for details.

The source keeps its existing [GNU GPL v3 license](LICENSE). The repository's
Git history remains available; archival does not require deleting it.
