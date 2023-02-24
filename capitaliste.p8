pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--main

function _init()
	create_player()
	init_msg()
	init_asw()
	play_main_music()
	//create_msg("nom pnj","bonjour"
	//,"kill them all")
	//create_asw("bidon","oui : ➡️"
	//,"non : ⬅️","je ne sais pas :⬆️")
	win=false
end

function _update()
	if not messages[1] then
	player_movement()
	end
	update_camera()
	update_msg()
	update_asw()
	_win()
end

function _draw()
	draw_map()
	draw_player()
	draw_ui()
	draw_msg()
	draw_asw()
end
-->8
--map

function draw_map()
	map()
end

function check_flag(flag,x,y)
	local sprite=mget(x,y)
	return fget(sprite,flag)
end

function update_camera()
	camx=flr(p.x/16)*16
	camy=flr(p.y/16)*16
	camera(camx*8,camy*8)
end
-->8
--player

function create_player()
	p={x=6,y=4,
	   sprite=1,
	   dettes=124523,
	   vies=3,
	   name="camille"}
end

function player_movement()
	newx=p.x
	newy=p.y
	if (btnp(⬅️)) newx-=1
	if (btnp(➡️)) newx+=1
	if (btnp(⬆️)) newy-=1
	if (btnp(⬇️)) newy+=1

	interact(newx,newy)
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end
-->8
--ui

function draw_ui()
 camera()
 
 palt(0,false)
 palt(1,true)
	spr(64,2,2)
 palt(0,true)
 palt(1,false)
	print_outline("dettes:"..p.dettes,10,3)
	for i=p.vies,1,-1 do
		spr(65,2+(i-1)*9,10)
	end
end

function print_outline(text,x,y)
	print(text,x-1,y,0)
	print(text,x+1,y,0)
	print(text,x,y-1,0)
	print(text,x,y+1,0)
	print(text,x,y,7)
end

function _win(x,y)
	if (win) then
		p.x=114
		p.y=23
	end
end
-->8
--messages

function init_msg()
	messages={}
end

function init_asw()
	answers={}
end


function create_msg(name,...)
	msg_title=name
	messages={...}
end

function create_asw(name,...)
	asw_title=name
	answers={...}
end

function update_msg()
	if (btnp(❎)) then
		deli(messages,1)
	end
end

function update_asw()
	
end

function draw_msg()
	if messages[1] then
		local y=40
		local x=4
		rectfill (x,y,120,y+35,0)
		rect (x-2,y-2,122,y+37,0)
		print(msg_title,x+6,y+2,8)
		print(messages[1],x+2,y+10,7)
	end
end

function draw_asw()
	if answers[1] then
		local y=82
		local x=4
		rectfill (x,y,120,y+35,0)
		rect (x-2,y-2,122,y+37,9)
		print("camille",x+6,y+2,3)
		print(answers[1],x+2,y+10,7)
		if answers[2] then
			print(answers[2],x+2,y+18,7)
			if answers[3] then
					print(answers[3],x+2,y+26,7)
				//if answer[4] then
					//print(answers[4],x+2,y+34,7)
				//end
			end
		end
	end
end
-->8
--interact

function interact(x,y)
	if not check_flag(0,
																			newx,
																			newy) then
		p.x=newx
		p.y=newy
		if (p.x<0) p.x=0
		if (p.y<0) p.y=0
	end
	if check_flag(1,
															newx,
															newy) then
		if newx==14 and newy==6 then
	 	create_msg("bob","salut","tu as une petite piece ?")
	 end
	 if newx==9 and newy==9 then
	 	create_msg("crs","edrfth")
	 end
	end
end
-->8
--music
function play_main_music()
	music(0)
end
__gfx__
00000000022222204444444444444444444444444443343444444444000000004444444400000000000000000000000000000000000000000000000000000000
0000000002ffff204444444444444444444444444443343444777744000000004444444400000000000000000000000000000000000000000000000000000000
00700700020f0f204544445444444444444555444343333447777774666660004444444400000000000000000000000000000000000000000000000000000000
0007700002ffff22444444444444444445555554434334444707707466ffdd334444444400000000000000000000000000000000000000000000000000000000
000770000255552044444444444444444555555543333434477777746f5fd4344444444400000000000000000000000000000000000000000000000000000000
007007000055550044445444444444445555555544433434447777446fffdd434455544400000000000000000000000000000000000000000000000000000000
000000000044440045444444444444445555555544433334444444446f5f8d334555554400000000000000000000000000000000000000000000000000000000
00000000044444404444444444444444555555554443344444770744666080035555555400000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777770044444440777777044444444044444400a9a777744434555004444402222222200444440000044400000444000111910111111110055555055555555
7575757004475744075775704444444404a44440a989a7574343555500222222ffffffff00222220000022200000222000fffff0ffffffff005fff505ffffff5
777777760777777707777770777777770a9a77700a9a777743435a5500f4f4f2f4ffff4f0044444000024f4000004f4000f5f5f0f5ffff5f00fdfdf0fdffffdf
757575700757575707577570757557570989757007a757574343a9a500fffff0f4ffff4f00fffff00000fff00000fff000fffff0f5ffff5f00fffff0fdffffdf
7777777607777777077777707777777707777770077777774333989500333330ffffffff00333330000033300000333000111110ffffffff0011c110ffffffff
7575757007575757075aa5707575575707577570075777574443335500333330ffffffff00333330000033300000333000111110f444444f0011c110f555555f
777777760777777707a99a707775577707755770077757774443444500f111f0fffeefff00f111f000001f1000001f1000f111f044eeee4400f111f0ffeeeeff
77777770077555770a9889a075755757077557700777577744434444000d0d00ffffffff000d0d0000000d0000000d00000505004444444400060600ffffffff
00555550555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
005fff505ffffff50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00f6f6f0f6ffff6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00fffff0f6ffff6f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ddddd0ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ddddd0f555555f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00f111f055eeee550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00060600555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030011088008800220022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882223222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03030011888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882232222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030301888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301088888800222232000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030011008888000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000880000003200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333833cccccccccccccccc33333cccccc3333300000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333338a83cccccccccccccccc333cccccccccc33300000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333833cccccccccbbccccc33cccccccccccc3300000000000000000000000000000000000000000000000000000000000000000000000000000000
333333333e333333cccccccccbbccbcc3cccccccccccccc300000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333eae33333cccccccccccccccc3cccccccccccccc300000000000000000000000000000000000000000000000000000000000000000000000000000000
333333333e333323cccccccccccccccccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333332a2ccccccccccccbbcccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333323cccccccccccccccccccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
33bbbb33333e333333333333ccccccccaaaaaaacaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbbb8b333eee33333333333ccccccccaaaaaaacaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
3b8bbbb33eeaee3333333333ccccccccaaaaaaccaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbb8bb333eee33344444444ccccccccaaaaacccaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
33bbbb33333b3333cccccccc44444444aaaaacccaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
33344333bb3b3bb3cccccccc33333333aaaaccccaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
333443333bbbbb33cccccccc33333333aaacccccaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
33344333333b3333cccccccc33333333aaacccccaaaccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000
33bbbb33333933333333333333333b1bcccccccc3333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
3bb3bbb3339993333ddd6dd333333bbbccc1111c3333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbbbbb3399a99333dd661d333333bb3cc111f1c3993933300000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbbb3b3339993333dd66dd333444bb3cc11777c9333919300000000000000000000000000000000000000000000000000000000000000000000000000000000
333bbb33333b33333ddd6dd33444bbb3cc17777c9999999300000000000000000000000000000000000000000000000000000000000000000000000000000000
33344333bb3b3bb33dddd3d3344bbbb31c1c77cc9999933300000000000000000000000000000000000000000000000000000000000000000000000000000000
333443333bbbbb333d6d63d334bb3bb311cccccc9439433300000000000000000000000000000000000000000000000000000000000000000000000000000000
33344333333b33333d6d63dd33b43b43c11ccccc9439433300000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001010103010000000000000000000000000000000000000000000000000000000000000000000000030003000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0408040404080408030308030303040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308080405030204060405080405080403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0306040303030303030303020303020803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308030303030203030303030303030603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0305030203030303030303020303030803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308080303030303030303030303050603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303040303020303030203030303070803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303040203030303030303030303020403030203030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303080804040803030303030303060804030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308040608040503032c02030303080303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0304030303030303030303030303040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308030203030302030303030303040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0408030303030303020303030303050803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0804030303020303030303030302030403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0608080503030305030306080404060803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303040404080405060503050303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030208040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0304030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030303030303020804030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030208040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350605050505050505050505050505050
0403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030360506050507250505050505050716161
0304030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030362626262626262030362626262626262
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030352525252525252030352525252525252
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030363636363636363030363636363636363
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350515050505050505050505050506060
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350505070505050505051505050506071
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350505070705050507550505050505050
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350505050505050505050505050505050
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350505050505051505050505050515150
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030370505051505050505050616171505050
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030370507350505050505051615452525352
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030370505050505050505050645252525252
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030370705050506050505050655274525252
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030370505171505050505051655252525252
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030370707071716150505075655352525252
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001200001554015540155401554015540155401554015540115401154011540115401054010540105401054015540155401554015540155401554015540155401154011540115401154010540105401054010540
001200002444023440214402144021440214401d4401d44021440214401d4401d4401c4401c44020440204402444023440214402144021440214401d4401d44021440214401d4401d4401c4401c4402044020440
001200002d1222410224102241022d1222d1222d1222d12226122241022410224102281222812228122281222d1222470224602006022d1222d1222d1222d1222612200102000000000028122281222812228122
00120000244502445021450214501d4501d45021450214501a4501a4501a450000001c4501c4502045000000244500000021450000001d4500000021450000001a4501a4501a450000001c4501c4502045000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001200002d1222410224102241022d1222d1222d1222d12226122241022410224102281222812228122281222d1222410224102241022d1222d1222d1222d122261222410229122241022c1222c1222c1222c122
000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 01020344
00 01020344
00 01020344
02 01040644

