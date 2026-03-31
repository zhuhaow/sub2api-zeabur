# Sub2API Zeabur Template

This repository contains a Zeabur template for deploying [Wei-Shaw/sub2api](https://github.com/Wei-Shaw/sub2api) with:

- `Sub2API`
- `PostgreSQL`
- `Redis`

The template is defined in [template.yaml](/Users/zhuhao/Projects/sub2api-zeabur/template.yaml).

## Local workflow

Test the template with Zeabur CLI:

```bash
npx zeabur@latest template deploy -f template.yaml
```

Create a published template:

```bash
npx zeabur@latest template create -f template.yaml
```

Update an existing template:

```bash
npx zeabur@latest template update -c <template-code> -f template.yaml
```

## Implementation notes

- The template uses the pinned Docker image `weishaw/sub2api:0.1.106`.
- PostgreSQL and Redis use internal networking only with port forwarding disabled.
- The public endpoint is the `Sub2API` HTTP service bound through the `PUBLIC_DOMAIN` variable.
- `TOTP_ENCRYPTION_KEY` is intentionally left unset by default. If you want 2FA to persist across restarts, set it manually after deployment to a 64-character hex string from `openssl rand -hex 32`.
- The displayed admin password is only the initial bootstrap password for a fresh database. Later redeploys do not overwrite an existing admin account password.
- If you want a Git-based Zeabur service instead, the upstream GitHub repository ID is `1118601518`.

## GitHub repo ID

Zeabur's `GIT` service type does not identify GitHub repositories by `owner/name`.
It uses GitHub's immutable numeric repository ID instead.

- Upstream repository: `Wei-Shaw/sub2api`
- GitHub repo ID: `1118601518`

This matters only if you switch the template from a Docker-image deployment to a Zeabur `GIT` service.
The current template uses the published Docker image, so the repo ID is just reference material.

## CI publishing

This repository includes [publish-template.yml](/Users/zhuhao/Projects/sub2api-zeabur/.github/workflows/publish-template.yml), which publishes the template on every push to `main` when `template.yaml` changes.

One-time setup in GitHub:

1. Add repository secret `ZEABUR_TOKEN`.
2. Push to `main` or run the workflow manually.

Behavior:

- The workflow updates template code `BNV1TZ`.
- The template code is hard-coded in the workflow, so no repository variable is required.
