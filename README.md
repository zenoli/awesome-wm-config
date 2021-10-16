# awesome-wm-config
My awesome wm configuration

## Setup
Install awesome wm:
`sudo apt update && sudo apt install awesome`

Pull this repo into `~/.config/awesome`.
In order for the brightness widget to work, make to put `scripts/brightness.bash` into the sudoers file:
`{{USER}} ALL=(ALL) NOPASSWD:/home/{{USER}}/.config/awesome/scripts/brightness.bash`
