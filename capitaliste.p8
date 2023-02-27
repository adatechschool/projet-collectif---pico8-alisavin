pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--main

function _init()
	create_player()
	init_msg()
	init_asw()
	play_main_music()
	init_pnj_id()
	create_pnj1()
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
	mort()
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
	p={x=38,y=4,
	   sprite=39,
	   dettes=-3520,
	   vies=3,
	   name="camille"}
end

function player_movement()
	newx=p.x
	newy=p.y
	if btnp(➡️) then
		newx+=1
		p.sprite=42
	end
	if (btnp(⬅️)) then
	 newx-=1
		p.sprite=43
	end
	if (btnp(⬇️)) then
	 newy+=1
	 p.sprite=39
	end
	if (btnp(⬆️)) then
	 newy-=1
	 p.sprite=41
	end
	
	interact(newx,newy)
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end

function mort()
	if p.vies==0 then
		p.x=6
		p.y=4
		p.vies=3
		p.dettes-=99
		create_msg("clinique st pierre","oups, passage \npar la case hopital\nvous payez 99")
	end
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
		p.x=118
		p.y=30
		p.dettes=0
	end
end
-->8
--messages

function init_msg()
	messages={}
end

function create_msg(name,...)
	msg_title=name
	messages={...}
end

function update_msg()
	if msg_title=="clinique st pierre" then
		if (btnp(❎)) deli(messages,1)
	else
	 if (btnp(❎)) and #messages>1 then
		 deli(messages,1)
	 elseif #messages==1 then
		 answer_to_pnj(pnj_id)
	 end
	end
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

function init_asw()
	answers={}
end

function create_asw(...)
	answers={...}
end

function update_asw()
	if btnp(⬆️) and #answers>0 then
		deli(messages,1)
		answers={}
		answer_consequence(1)
	elseif btnp(⬅️) and #answers>1 then
		deli(messages,1)
		answers={}
		answer_consequence(2)
	elseif btnp(⬇️) and #answers>2 then
		deli(messages,1)
		answers={}
		answer_consequence(3)
	elseif btnp(➡️) and #answers>3 then
		deli(messages,1)
		answers={}
		answer_consequence(4)
	end
end

function draw_asw()
	if answers[1] then
		local y=82
		local x=4
		rectfill (x,y,120,y+40,0)
		rect (x-2,y-2,122,y+42,9)
		print("camille",x+6,y+2,3)
		print("⬆️ "..answers[1],x+2,y+10,7)
		if answers[2] then
			print("⬅️ "..answers[2],x+2,y+18,7)
			if answers[3] then
					print("⬇️ "..answers[3],x+2,y+26,7)
				if answers[4] then
					print("➡️ "..answers[4],x+2,y+34,7)
				end
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
		interact_with_pnj(newx,newy)
		
	 
	elseif check_flag(2,newx,newy) then
		p.vies-=1
	end
end

function interact_with_pnj(x,y)
	if x==c1.x and y==c1.y then
  pnj_id=1
  --fin qd joueur donne 500
  if c1.argent_recu>=500 then
  	create_msg("bob","merci bien !")
	 elseif c1.deja_parle==0 then
	 	create_msg("bob",
	 	"psssst ! eh toi!", "t'as vu ta dette ? \nen haut a gauche \ntu veux l'effacer ?",
	 	"hahahahahahah ! haha ! \npas moyen ! \nfaut tout bruler !", 
		"he ! pars pas, \nj'ai un autre conseil !","les cactus : ca pique !","allez ! \nmaintenant que je t'ai aide\ntu as une petite piece ?")
		elseif c1.deja_parle>0 and
		c1.argent_recu<500 then
			create_msg("bob","c'est pas mal ...","une autre peut-etre ?")
		end
	end
	if newx==9 and newy==9 then
	 create_msg("crs","edrfth")
	end
end
-->8
--music
function play_main_music()
	music(0)
end
-->8
--pnj

function init_pnj_id()
	pnj_id=0
end

function create_pnj1()
	c1={x=14,y=6,
	    deja_parle=0,
	    argent_recu=0}  
end

function answer_to_pnj(pnj_id)
	if pnj_id==1 then
		if c1.argent_recu<500 then
	 	create_asw("donner 1","donner 10","donner 50","donner 500")
		else
			create_asw("au revoir")
		end
	end
	
	
end

function answer_consequence(n)
	if pnj_id==1 then
		c1.deja_parle=1
		if c1.argent_recu<500 then
			if n==1 then
				c1.argent_recu+=1
			 p.dettes-=1
				interact_with_pnj(newx,newy)
			elseif n==2 then
				c1.argent_recu+=10
				p.dettes-=10
				interact_with_pnj(newx,newy)
			elseif n==3 then
				c1.argent_recu+=50
				p.dettes-=50
				interact_with_pnj(newx,newy)
			elseif n==4 then
				c1.argent_recu+=500
				p.dettes-=500
				interact_with_pnj(newx,newy)
			end
		else
	 	p.x=16
	 	p.y=12
		end
	end
	
	
end
__gfx__
000000000222222044444444444444444444444444433434444444444444444444444444666666666666666666664466656aaa66666665556666666600000000
0000000002ffff204444444444444444444444444443343444777744444444444444444466666666666666666664646665aaaaa666a666555666aa6600000000
00700700020f0f20454444544444444444455544434333344777777466666444444444446666666666666666664664666599999a6aaa6665566aaaa600000000
0007700002ffff22444444444444444445555554434334444757757466ffdd334444444466666666777677766666646665559955aaaaa555555a99a600000000
000770000255552044444444444444444555555543333434477777746f5fd4344444444466666666777677766666446665555555a999a5555555576600000000
007007000055550044445444444444445555555544433434447777446fffdd434455544466666666666666666664646665555555555555555555576600000000
000000000044440045444444444444445555555544433334444444446f5f8d334555554466666666666666666646646665555555555555555555776600000000
00000000044444404444444444444444555555554443344444776744666484435555555466666666666666666666646666666666666666655666666600000000
6655555666111116000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666aa55666666600000000
665fff5666fffff600000000000000000000000000000000000000000000000000000000000000000000000000000000666666666666aaaa6666666600000000
66f5f5f666f5f5f600000000000000000000000000000000000000000000000000000000000000000000000000000000666a6666666a999a6666666600000000
66fffff666fffff60000000000000000000000000000000000000000000000000000000000000000000000000000000066aaa666666555666666666600000000
6611211666111116000000000000000000000000000000000000000000000000000000000000000000000000000000006659aa66665556666666666600000000
66112116661111160000000000000000000000000000000000000000000000000000000000000000000000000000000066559aa6665566666666666600000000
66f111f666f111f600000000000000000000000000000000000000000000000000000000000000000000000000000000666559a6665666666666666600000000
66646466666565660000000000000000000000000000000000000000000000000000000000000000000000000000000066665556666666666666666600000000
777777733444444437777773444444443444444337a7777733333333009999902222222200999990000099900000999000111110111111113355555355555555
7575757334475744375775734444444434a444433a9a5757333bbb3300222222ffffffff02222220000022200000222000fffff0ffffffff335fff535ffffff5
777777763777777737777773777777773a9a7773a989a77733bbbbb300f4f4f2f4ffff4f0299999000009f400000429000f0f0f0f0ffff0f33f0f0f3f0ffff0f
75757573375757573757757375755757398975733a9a575733bbbbb300fffff0f4ffff4f00fffff00000fff00000fff000fffff0f0ffff0f33fffff3f0ffff0f
777777763777777737777773777777773777777337a77777333bbb3300ccccc0ffffffff00ccccc00000ccc00000ccc000111110ffffffff3311c113ffffffff
7575757337575757375aa5737575575737577573375757573333433300ccccc0ffffffff00ccccc00000ccc00000ccc000111110f444444f3311c113f555555f
777777763777777747a99a737775577737755773377777773333433300f111f0fffeefff00f111f000001f1000001f1000f111f044eeee4433f111f3ffeeeeff
77777773377555773a9889a375755757377557733777577733333333000d0d00ffffffff000d0d0000000d0000000d00000505004444444433363633ffffffff
00555550555555553666766633333333333333333334443333344433344444444444444466666666666666666666666633333333333443333666666633334333
005fff505ffffff53666766633333333333333333334443333344433344444447777777766677766666666666667776633333333333443333667776633334333
00f0f0f0f0ffff0f3666666633333333333333333334443333344433377777777575575766733376666666666673337633333333333443333673337644444333
00fffff0f0ffff0f3666766633333333333333333334443333344433375577577777777766732376777677766673837633333333333443333673937633333333
00ddddd0ffffffff3666766644444444333333333334443344444433376677777575575766733376666666666673337633333333333443333673337633333333
00ddddd0f555555f3666766643344334333333333334443343344433377777777777777766677766666666666667776633333333333443333667776633333333
00f111f055eeee553666666643344334333333333334443343344433375577577575575766666666666666666666666644444444333443333666666633333333
00060600555555553666766644444444333333333334443344444433375577577775577736666666333333333333333333333333333443333666666633333333
10030011088008800220022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882223222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03030011888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882232222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030301888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301088888800222232000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030011008888000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000880000003200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333833cccccccccccccccc33333cccccc3333333333333000000000000000000000000000000000000000000000000000000000000000000000000
3333333333338a83cccccccccccccccc333cccccccccc33388333333000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333833cccccccccbbccccc33cccccccccccc3389938333000000000000000000000000000000000000000000000000000000000000000000000000
333333333e333333cccccccccbbccbcc3cccccccccccccc393339193000000000000000000000000000000000000000000000000000000000000000000000000
33333333eae33333cccccccccccccccc3cccccccccccccc399998993000000000000000000000000000000000000000000000000000000000000000000000000
333333333e333323cccccccccccccccccccccccccccccccc98899833000000000000000000000000000000000000000000000000000000000000000000000000
33333333333332a2ccccccccccccbbcccccccccccccccccc94894883000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333323cccccccccccccccccccccccccccccccc94894388000000000000000000000000000000000000000000000000000000000000000000000000
33bbbb33333e333333333333ccccccccaaaaaaacaaaccccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000
3bbbb8b333eee33333333333ccccccccaaaaaaacaaacccccccc1818c000000000000000000000000000000000000000000000000000000000000000000000000
3b8bbbb33eeaee3333333333ccccccccaaaaaaccaaaccccccc11181c000000000000000000000000000000000000000000000000000000000000000000000000
3bbb8bb333eee33344444444ccccccccaaaaacccaaaccccccc11887c000000000000000000000000000000000000000000000000000000000000000000000000
33bbbb33333b3333cccccccc44444444aaaaacccaaaccccccc17788c000000000000000000000000000000000000000000000000000000000000000000000000
33344333bb3b3bb3cccccccc33333333aaaaccccaaaccccc1c1c77c8000000000000000000000000000000000000000000000000000000000000000000000000
333443333bbbbb33cccccccc33333333aaacccccaaaccccc11ccccc8000000000000000000000000000000000000000000000000000000000000000000000000
33444433333b3333cccccccc33333333aaacccccaaacccccc11cc8cc000000000000000000000000000000000000000000000000000000000000000000000000
33bbbb33333933333333333333333b1bcccccccc3333333343333433333333330000000000000000000000000000000000000000000000000000000000000000
3bb3bbb3339993333ddd6dd333333bbbccc1111c3333333344434433333333330000000000000000000000000000000000000000000000000000000000000000
3bbbbbb3399a99333dd661d333333bb3cc111f1c3993933333434344333333330000000000000000000000000000000000000000000000000000000000000000
3bbbb3b3339993333dd66dd333444bb3cc11777c9333919333444443333333330000000000000000000000000000000000000000000000000000000000000000
333bbb33333b33333ddd6dd33444bbb3cc17777c9999999333334333333333330000000000000000000000000000000000000000000000000000000000000000
33344333bb3b3bb33dddd3d3344bbbb31c1c77cc9999933333334333344333330000000000000000000000000000000000000000000000000000000000000000
333443333bbbbb333d6d63d334bb3bb311cccccc9439433333334333344333330000000000000000000000000000000000000000000000000000000000000000
33444433333b33333d6d63dd33b43b43c11ccccc9439433333334333344333330000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000001050103010000000000000003030000000000000000000000000000010101010101010000000000030003000300000000000001010000000000000000000000000000000000000000000000000000000000010000000000000000000100000000000000000000000000000001000101000001000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0408040404080408030308030303040326262626263226262626262626262626030803080204050404030503020503040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308080405030204060405080405080426262626263226262626262626262626020804030503030305080204050305020303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0306040303030303030303020303020826262626263226262634343434343426030402030303020303030303030302050303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030803030303020303030303030303062626262626322626343434343434342605030909090909091c0909090909090b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0305030203030303030303020303030826262626263234343434343434343426040309090909090c0d0e09090909090b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030808030303030303030303030305062626263434323a3a393a3a393a3a392605020909090909091d1e09090909090b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030304030302030303020303030307082626343434322626323c20322226322606080a0a0a0a0a0a0a0a0a0a0a0a0a0b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
03030402030303030303030303030204262634343432252632222632262432260808090909090909100909090909090b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030308080404080303030303030306082626343434323f26323c2032233d32260403090909090909090909090909090b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030804060804050303030203030308032626343434322621323a3a393a3a3b260205090909090909090909090909090b0303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0304030303030303030303030303040326263434343e3a3a3b34343234343426050303040302030303020303030302080303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030803020303030203030303030304032626343434323821372438322e343426030402030304030303030302030303050303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
040803030303030302030303030305083a3a3a3a3a393a3a3a3a3a393a3a3a3a040305020303030204030303020305060303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0804030303020303030303030302030426263434343234343434343234343426020308040503050503030203030504020303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0608080503030305030306080404060826262626343226262626263234262626030303030205030305040304080305030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303040404080405060503050303030326262626263226262626263226262626030303030303030302030803020403040303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303030303030208040303030303030303030303030403030303030403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030350605050505050505050505050505050
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
00040000080500a0500c0500d0500f0500f05011050110501c05027050120501405015050180501a0501e0502205024050280502d05033050380503b0503f0503e0503f0503f0500000000000000003f0503f050
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

