# ElixirRenovateDemo

A repository showcasing using Renovate on an Elixir project (here a Phoenix app
deployed to [Fly.io](https://fly.io/)).

[Renovate](https://github.com/renovatebot/renovate) is a highly-configurable
dependency management bot that automates update PRs.

Despite being written in JavaScript, it runs as a GitHub app (there's also
self-hosting options), and is able to manage the dependencies for a lot of 
languages and tools.

## Benefits of this particular config

- Automatically updates the `hexpm/elixir` Docker base image tag (for Fly)
- Keeps Elixir/OTP versions in sync between `asdf` (`.tool-versions`) and
production Docker

## How does it work

1. We use version comments in [`Dockerfile`](./Dockerfile) to tell Renovate
where to find the version information for each part of the image (Debian,
OTP & Elixir)
2. We setup a "Test Docker Build" CI workflow that makes sure the image tag
composed from those three versions actually exist (so Renovate doesn't
auto-merge an inexistant image, if auto-merge is enabled in the first place)
3. We add the `regexManagers:dockerfileVersions` preset and a few package rules
for the Debian versioning
4. That's it :)

When merging update PRs for each component, I find it's best to merge them in
this order: Debian > OTP > Elixir.

## How to replicate this config

1. Copy [`.github/renovate.json5`](./.github/renovate.json5) to your `.github/`
directory
2. Copy [`.github/workflows/test-docker-build.yml`](./.github/workflows/test-docker-build.yml)
to your `.github/workflows/` directory
2. Add the version comments and `base` build stage in
[`Dockerfile`](./Dockerfile)
3. Pick what you want / customize to your liking. You might also want to copy
the rules from my base preset directly in your config
4. [Install Renovate to your repository](https://github.com/apps/renovate/installations/select_target)
5. Profit!

## Notes

- The "Test Docker Build" workflow targets the `base` build stage to only test
base image existence. The rationale behind this choice is to reduce feedback
cycles and cost less Action credits (in this repository the full build is only
~1 min, but once your application grows it can increase significantly). If you
want to test the full image build, change the target to `builder` instead.

## Learn more

- [Renovate documentation](https://docs.renovatebot.com/)
- [Renovate developer portal](https://developer.mend.io/github/): a place to
monitor its activity on your repo and view logs.
- [How should you pin dependencies and why?](https://the-guild.dev/blog/how-should-you-pin-dependencies-and-why):
although it's for JS, I believe it is an interesting read for Elixir as well.
