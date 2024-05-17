## Notes on scripts

A few scripts are run through `systemd` and require the `$BWS_ACCESS_TOKEN` secret. Create `bws-access-token-env` file that assigns `$BWS_ACCESS_TOKEN` to the value of your BitWarden Secrets Manager Access Token.

Source: [Baeldung Linux](https://www.baeldung.com/linux/systemd-services-environment-variables)
