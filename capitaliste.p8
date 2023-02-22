pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--main

function _init()
	create_player()
end

function _update()
	player_movement()
	update_camera()
end

function _draw()
	draw_map()
	draw_player()
	draw_ui()
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
	   health=3,
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

function interact(x,y)
	if not check_flag(0,
																			newx,
																			newy) then
		p.x=newx
		p.y=newy
		if (p.x<0) p.x=0
		if (p.y<0) p.y=0
	end
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end

function player_lose_health()
	p.health-=1
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
	for i=p.health,1,-1 do
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030011088008800220022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882223222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03030011888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882232222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030301888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301088888800222232000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030011008888000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000880000003200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111110010011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111000303000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110333333333010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110300303000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110300303011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110300303011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110300303000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110333333333010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111000303003010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111110303003010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111110303003010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111000303003010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11110333333333010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111000303000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111010111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001010103010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
0308040608040503030302030303080303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0304030303030303030303030303040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308030203030302030303030303040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0408030303030303020303030303050803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0804030303020303030303030302030403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0608080503030305030306080404060803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303040404080405060503050303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030208040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0304030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
