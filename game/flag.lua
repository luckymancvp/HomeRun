module(...,package.seeall)

function newFlag(x,y)
	require "movieclip"
	local flagAni = movieclip.newAnim( { "images/flag1-1.png", "images/flag1-2.png", "images/flag1-3.png"} )
	flagAni.x = x
	flagAni.y = y
	flagAni:play{startFrame=1, endFrame=3, loop=4, remove=true}
	return flagAni
end