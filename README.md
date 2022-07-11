# CloudflareAPI_Updater
Bash scripts for auto updating DNS records on Cloudflare

# Dependencies

MacOS - `brew install jq`
Ubuntu - `sudo apt install jp`

# Setup

## Make scripts executable

In terminal, run:
```
    chmod +x setup.sh
    chmod +x cloudflareAPI.sh
```

## Run setup.sh

In terminal, run:

```
    ./setup.sh
```

Follow script instructions

## Add main cloudflairAPI.sh to tasking

In terminal, run:

```
    crontab -e
```

Insert the following (adjusted) row:

```
    @daily /path/to/file/cloudflareAPI.sh
```