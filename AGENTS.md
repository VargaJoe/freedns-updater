# Repository content privacy

Treat every file in this source workspace as potentially publishable, including
untracked and ignored files. Repository documentation, examples and fixtures must
use general wording and synthetic values.

- Keep private machine names, internal domains/IP addresses, account names, actual
  installation paths, deployment inventories and access diagnostics outside this
  workspace. Private operational memory must not be copied into repository docs.
- Never place real credentials, tokens, task exports or runtime logs here.
- Run real deployments outside the checkout. Workspace tests must use synthetic
  credentials, addresses and fixture data.
- Use clearly named placeholders, `example.com` / `example.org`, documentation-only
  IP ranges, and generic paths for examples. Loopback addresses and public upstream
  project/provider identifiers may be used where technically relevant.
- Review all changed and new file contents before staging or publishing. Ignore
  rules do not make private content acceptable in this workspace.
- Preserve necessary compatibility requirements in general terms; retain concrete
  deployment details only in private operational records outside the checkout.

## Explicitly authorized private transfer bundle

`/local-deployment/` is a user-authorized exception for private deployment transfer
packages. The entire directory must remain Git-ignored and must never be staged,
committed or published, including with force-add. Actual deployment settings may
appear only inside this exception when authorized. Do not copy its contents into
public docs, fixtures, tool output or another workspace file. Review and test with
synthetic environment values; keep live execution outside the checkout.
