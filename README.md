## Notes on scripts

A few scripts are run through `systemd` and require the `$BWS_ACCESS_TOKEN` secret. Create `bws-access-token-env` file that assigns `$BWS_ACCESS_TOKEN` to the value of your BitWarden Secrets Manager Access Token.

1. Get the `bws` CLI from the [Bitwarden SDK GitHub releases page](https://github.com/bitwarden/sdk-sm/releases).
2. Move the `bws` file to `/usr/local/bin`
3. `su`
4. `cd ~`
5. `touch bws-access-token-env`
6. Go to the [Bitwarden Secrets Manager website](https://vault.bitwarden.com/#/sm/65a6e97b-2468-40ec-98d4-b172014ff7c8).
  1. (Optional) Go to the [machine accounts section](https://vault.bitwarden.com/#/sm/65a6e97b-2468-40ec-98d4-b172014ff7c8/machine-accounts) and revoke any existing machine accounts.
7. Press "+New" button.
8. Create a new machine account.
9. `echo "BWS_ACCESS_TOKEN=<YOUR_ACCESS_TOKEN>" > bws-access-token-env`
10. `exit`

Source: [Baeldung Linux](https://www.baeldung.com/linux/systemd-services-environment-variables)
