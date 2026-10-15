# Retirement and migration notes

Development of FreeDNS Updater has ended. The project is retained as historical
source; its own multi-provider engine, container implementation and Windows task
management GUI will not be developed. Existing clients cover the required DDNS
use case with less duplicated maintenance.

## Replacement

The recommended alternative is the independent
[qdm12/ddns-updater](https://github.com/qdm12/ddns-updater) project. Follow its
[README](https://github.com/qdm12/ddns-updater#readme) and the
[FreeDNS guide](https://github.com/qdm12/ddns-updater/blob/master/docs/freedns.md)
for the version you choose. Its WebUI provides status and manual updates; it is
not a Windows Scheduled Task management GUI.

## Generic migration checklist

1. Identify the records, address families and linked-update behavior maintained by
   the old installation. Preserve its configuration privately for rollback.
2. For FreeDNS, enable the required records in the provider's v2 interface and
   obtain the appropriate token. Do not reuse the legacy `dynamic/update.php` key
   as a v2 token. Keep credentials in restricted private deployment storage.
3. Configure the intended provider and record explicitly. Validate the detected
   public address, particularly on hosts using VPNs or multiple WAN connections.
4. Make a controlled handover to one active updater. Disable the old schedule
   before the replacement handles production records; keep a usable rollback.
5. Verify an actual address change, the provider response and external DNS results.
   A running or healthy container alone does not prove a successful DNS update.
   DNS caches can delay when another client sees the new address.
6. Check persistence, restart/recovery behavior and bounded logging in the chosen
   deployment. Follow upstream guidance for check intervals, update cooldowns and
   logging levels. Keep runtime logs and credentials outside this repository.
7. If rollback is necessary, stop the replacement before re-enabling the previous
   updater. Avoid two active clients competing to maintain the same records.

Deployment-specific hostnames, domains, paths, addresses and credentials are not
part of these notes. The upstream project maintains its own supported-provider
list, instructions and support channels.

## Repository closure

This documentation PR prepares repository archival; it does not change the
GitHub archive flag. After the owner reviews and merges it into the default branch:

- Review any remaining open issues or pull requests and close obsolete work as
  discontinued, rather than marking unimplemented features complete.
- Archive the repository through GitHub Settings so its source and history remain
  readable. Deleting the repository or its branches is unnecessary.
- Keep private deployment configuration and operational records outside the
  published repository. Archival does not stop or remove installed software.

No script behavior, dependency or license change is included in retirement.
See the [README](../README.md) and [legacy limitations](legacy-reference.md).
