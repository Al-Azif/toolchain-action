# toolchain-action

Testgrounds for the Open Orbis Toolchain Action

## TODO:
- [ ] More robust release version detection
  - URL could be wrong if release name, tag.gz release, tag, etc, are not the same
- [ ] Add better messages:
  - echo "::debug::Set the Octocat variable"
  - echo "::warning file={name},line={line},col={col}::{message}"
  - echo "::error file={name},line={line},col={col}::{message}"
