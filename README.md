# devcontainer

This project contains custom devcontainers for use in our repositories.


## Images

Image | Description | Dockerfile
-- | -- | -- 
`ghcr.io/home-assistant/devcontainer:addons` | For Add-on development | [./Dockerfile](./Dockerfile)

## Example files

Example files to use with Visual Studio Code 

## Notes

### `addons`

- Use the command `supervisor_run` to start Home Assistant inside the devcontainer, or run the task "Start Home Assistant" if you copied the tasks file.
- Use `ha` to use the custom Home Assistant CLI (Needs the supervisor to be running).

