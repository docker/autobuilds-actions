# Docker Hub Autobuilds Actions

This repository demonstrates how to configure GitHub Actions workflows to replicate Docker Hub Automated Builds (Autobuilds) functionality, helping users migrate from Docker Hub to GitHub Actions for automated container image building.

## Overview

Autobuilds provided automatic image builds triggered by repository changes. This project shows how to achieve the same functionality using GitHub Actions, making it easier to migrate your build workflows.

## Features

- Automated Docker image builds on push.
- Tag management and versioning.
- Push to Docker Hub registry.
- Optionally run pre and post hook files during workflow.
- Optionally run docker-compose test files before pushing the image.

## Getting Started

See the `.github/workflows` directory for example workflow configurations that replicate common Autobuilds patterns.

## Migration Guide

### Review your existing Autobuilds configuration

Navigate to the Docker Hub repository on hub.docker.com you wish to migrate from Autobuilds to GitHub Actions and go to it's "Builds" tab.

On the Builds tab, select "Build Configuration" to display the existing Autobuilds configuration for this repository.

You will need to take note of:

1. The "Source Repository": This will be the GitHub repository where you will need to configure the GitHub Action workflow.
2. Autotest: If enabled you will want to use the `full-autobuilds.yaml` workflow example from this repository in order to run `docker compose` to test your code before pushing the image to Docker Hub.
3. Build Rules: This will specify the "Source" branch or tag, target "Docker Tag", "Dockerfile location", and "Build Context" path that will need to be configured in the GitHub Action workflows.

### Configure repository secrets for registry credentials

In order to push an image to Docker Hub you will first need credentials to login.

- If the target Docker Hub repository is under a User then create a [Personal Access Token](https://docs.docker.com/security/access-tokens/) with "Read & Write" permissions.
- If the target Docker Hub repository is under an Organization then create an [Organization Access Token](https://docs.docker.com/enterprise/security/access-tokens/) with "Read public repositories", "Image Pull", and "Image Push" permissions.

Store the login details under the GitHub repository as [repository secrets](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets):

- `DOCKER_USERNAME`: this should be set to the username/org-name of the User or Organization the Docker Hub repository sits under.
- `DOCKER_PASSWORD`: this is the token you created.

### Configure the GitHub Action workflow

Two example workflows are included in this repository:

- [.github/workflows/simple-build.yaml](./.github/workflows/simple-build.yaml): This workflow simply builds a Docker Image and pushed it to Docker Hub.
- [.github/workflows/full-autobuilds.yaml](./.github/workflows/full-autobuilds.yaml): This workflow duplicates the full Autobuilds functionality including running optional hook files and running `docker compose` to test code before pushing the resulting Docker Image it to Docker Hub.

Copy the workflow you want into your GitHub repository under the `.github/workflows` directory at the root of repository.

For both workflows you must configure the branch/tag triggers under `on`, the `env` environment variables, and adjust the `meta` step's tagging rules to match your existing Autobuilds build configuration.

Note that the `hooks/` directory, `Dockerfile`, `docker-compose.test.yml`, and `run_tests.sh` files do not need to be copied to your GitHub repository. They are here for demonstration purposes only.

## Resources

- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [Docker Metadata Action](https://github.com/docker/metadata-action)
