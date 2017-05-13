ripple = require("lib.ripple")
local path = "assets/audio/"

effect = {
    powerupAppear = ripple.newSound(path..'powerup-appears.mp3'),
    powerupPick = ripple.newSound(path.."powerup-pick.mp3"),
    shoot = ripple.newSound(path.."shoot.mp3"),
    hit = ripple.newSound(path.."hit.mp3")
}
