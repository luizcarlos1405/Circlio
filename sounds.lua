ripple = require("lib.ripple")
local path = "assets/audio/"

tags = {
    master = ripple.newTag(),
    music = ripple.newTag(),
    narrative = ripple.newTag(),
    sfx = ripple.newTag()
}

effect = {
    powerupAppear = ripple.newSound(path..'powerup-appears.mp3', {tags = {tags.master, tags.sfx}}),
    powerupPick = ripple.newSound(path.."powerup-pick.mp3", {tags = {tags.master, tags.sfx}}),
    shoot = ripple.newSound(path.."shoot.mp3", {tags = {tags.master, tags.sfx}}),
    hit = ripple.newSound(path.."hit.mp3", {tags = {tags.master, tags.sfx}})
}

music = {
    battle = ripple.newSound(path..'battle.mp3', {loop = true, tags = {tags.master, tags.music}})
}

narrative = {
    life = ripple.newSound(path.."life.mp3", {tags = {tags.master, tags.narrative}}),
    fastFire = ripple.newSound(path.."fast-fire.mp3", {tags = {tags.master, tags.narrative}}),
    spreadShot = ripple.newSound(path.."spread-shot.mp3", {tags = {tags.master, tags.narrative}}),
    speedBoost = ripple.newSound(path.."speed-boost.mp3", {tags = {tags.master, tags.narrative}})
}
