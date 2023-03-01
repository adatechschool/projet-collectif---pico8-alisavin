pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--main

function _init()
	create_player()
	init_variables()
	init_msg()
	init_asw()
	play_main_music()
	create_pnj()
	create_cochon()
	create_crs()
end

function _update()
	if not messages[1] then
		if c3.deja_parle==0 or c3.deja_parle==4 then
 		player_movement()
 	end
	end
	change_music()
	update_camera()
	update_msg()
	update_asw()
	if c3.deja_parle==1 then
		update_crs()
	end
	_win()
	mort()
end

function _draw()
	draw_map()
	draw_player()
	draw_ui()
	draw_cochon()
	if c3.deja_parle==1 then
		draw_crs()
	end
	draw_msg()
	draw_asw()
end

function init_variables()
	pnj_id=0
	win=false
	cochon=false	
	music_played=0
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

function perte_pv()
	p.vies-=1
	sfx(7)
end

function mort()
	if p.vies==0 then
		p.x=6
		p.y=4
		p.vies=3
		p.dettes-=99
		sfx(8)
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
		p.sprite=39
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
	elseif pnj_id==3 and c3.deja_parle==0 and #messages==1 then
		if btnp(❎) then
			deli(messages,1)
			c3.deja_parle=1
		end
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
		 if answers[2]!="" then
			print("⬅️ "..answers[2],x+2,y+18,7)
			end
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
		perte_pv()
	end
end

function interact_with_pnj(x,y)


--intercation avec pnj1
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
	
	
	--intercation avec pnj2 level2
	if x==c2.x and y==c2.y then
  pnj_id=2
  if c2.deja_parle==0 then
  create_msg("patrick le banquier",
  "bonjour,",
  "voulez-vous contracter \nun pret ?",
  "seulement 10% d'interets") 
		elseif c2.deja_parle==1 then
			create_msg("patrick le banquier",
			"re-bonjour camille",
			"toujours des dettes ?", 
			"un petit pret au\ntarif avantageux\nde 10% d'interet")		
		elseif c2.deja_parle==2 then
			create_msg("patrick le cochon",
			"gron gron quiiiick\nquick",
			"groin groin kik ?")
		end
	end
	
	
	--interaction avec pnj3 screen3
	if x==c3.x and y==c3.y then
		pnj_id=3
		if c3.deja_parle==0 then 
		 create_msg(c3.name,"oh non ! saperlipopette !\nun de mes jets prives\nest en feu !",
		 "c'est qui l'enfoire\nqui l'a brule,\nque je le crible de dettes !","* il vous remarque *",
		 "vous ! la !\nqu'est-ce que vous \nfaites ici ?!","c'est mon aeroport prive !\nvous n'avez rien a faire la !\nvous etes suspect!",
		 "garde !\nfaites quelque chose !\non ne vous paie pas \na rien faire !")
		elseif c3.deja_parle==2 then
			create_msg(crs.name,"dans ta gueule, \nsale activiste !","* donne un coup de matraque *\n\n* vous perdez un pv *")
		elseif c3.deja_parle==3 then
			create_msg(c3.name,"bien fait pour ta gueule !","maintenant embarque moi ca !")
	 elseif c3.deja_parle==4 then
	 	create_msg(c3.name,"maintenant embarque moi ca !")
	 end
	end
	
--pnj 4
	if x==c4.x and y==c4.y then
		pnj_id=4
		if c4.deja_parle==0 then 
		 create_msg(c4.name,"qui etes vous ?","je ne reponds pas \naux journalistes \nislamo-gauchiste, \ncirculez !")
		elseif c4.deja_parle==1 then
			create_msg(c4.name,"hahahahahaha","degage prolo",
			"ou tu vas finir \ncomme les poissons",
			"hahahahahaha \nhah haha (cof cof)\n*tousse*")
		end
	end
end
-->8
--music
function play_main_music()
	music(0)
end

function change_music()
	if c3.deja_parle==4 and music_played==0 then
		music(8)
		music_played=8
	end
end
-->8
--pnj

function create_pnj()
	create_pnj1()
	create_pnj2()
	create_pnj3()
	create_pnj4()
end

--bob le sdf
function create_pnj1()
	c1={x=14,y=6,
	    deja_parle=0,
	    argent_recu=0}  
end


--patrick le banquier
function create_pnj2()
	c2={x=28,y=11,
	    deja_parle=0,
	    argent_recu=0,}  
end


--bernard renault
function create_pnj3()
	c3={x=40,y=7,
	    deja_parle=0,
		name="bernard renault"}
end

--leo le ceo
function create_pnj4()
	c4={x=57,y=2,
	    deja_parle=0,
	  name="leo le ceo"}  
end

function answer_to_pnj(pnj_id)

--pnj 1
	if pnj_id==1 then
		if c1.argent_recu<500 then
	 	create_asw("donner 1","donner 10","donner 50","donner 500")
		else
			create_asw("au revoir")
		end
	end
	if pnj_id==2 then 
		if c2.deja_parle<2 then
			create_asw("emprunter 500 (-50)","emprunter 1000 (-100)",
			"emprunter 1500 (-150)",
			"changer en cochon")
		else
		create_asw("il veut un pret patrick ?",
			"petit, petit petit",
			"lui donner des glands",
			"le prendre dans notre sac")  
		end	
	end

--pnj 3
	if pnj_id==3 then
		if c3.deja_parle==2 then
			create_asw("aie")
		elseif c3.deja_parle==3 then
		 create_asw("je ne me laisserais \n   pas faire !")
		elseif c3.deja_parle==4 then
		 create_asw("leur balancer un \n   cocktail molotov","","s'enfuir")
		end
	end

--pnj 4
	if pnj_id==4 then
		if c4.deja_parle==0 then
		 create_asw("demander un travail","offrir son aide","parler des arbres morts","parler de la pollution")
		end
		if c4.deja_parle==1 then
			create_asw("proposer son aide","l'enfermer dans un bidon","le jeter dans la riviere","tout bruler")
		end
	end
end

function answer_consequence(n)

--pnj 1
	if pnj_id==1 then
		c1.deja_parle=1
		if c1.argent_recu<500 then
			if n==1 then
				c1.argent_recu+=1
			 p.dettes-=1
			 sfx(17)
				interact_with_pnj(newx,newy)
			elseif n==2 then
				c1.argent_recu+=10
				p.dettes-=10
				sfx(17)
				interact_with_pnj(newx,newy)
			elseif n==3 then
				c1.argent_recu+=50
				p.dettes-=50
				sfx(17)
				interact_with_pnj(newx,newy)
			elseif n==4 then
				c1.argent_recu+=500
				p.dettes-=500
				sfx(17)
				interact_with_pnj(newx,newy)
			end
		else
	 	p.x=16
	 	p.y=12
		end
	end

--pnj 2
	if pnj_id==2 then
		if c2.deja_parle != 2 then
			if n==1 then
			 p.dettes-=50
			 sfx(17)
				c2.deja_parle=1
			elseif n==2 then
				p.dettes-=100
				sfx(17)
				c2.deja_parle=1
			elseif n==3 then
				p.dettes-=150
				sfx(17)
				c2.deja_parle=1
			elseif n==4 then
				p.dettes+=950
				sfx(16)
				cochon=true
				c2.deja_parle=2
			end
		else 
			p.x=35
	 	p.y=12
	 	cochon=false
	 end
	end

--pnj 3
	if pnj_id==3 then
		if c3.deja_parle==2 then
			if n==1 then
				perte_pv()
				c3.deja_parle=3
				interact_with_pnj(newx,newy)
			end
		elseif c3.deja_parle==3 then
			c3.deja_parle=4
			interact_with_pnj(newx,newy)
		elseif c3.deja_parle==4 then
			if n==1 then
				p.x=60
				p.y=10
				sfx(16)
			elseif n==3 then
				p.x=60
				p.y=10
				sfx(16)
			end
		end
	end

--pnj 4
	if pnj_id==4 then
		if c4.deja_parle==0 then
			c4.deja_parle=1
			interact_with_pnj(newx,newy)
  elseif c4.deja_parle==1 then
			if n==1 then
				interact_with_pnj(newx,newy)
			else
				win=true
				sfx(16)
			end
		end
	end
end

function create_cochon()
	pig={x=28,y=11,
	   sprite=103,
	   name="patrick le cochon"}
end

function draw_cochon()
	if (cochon==true) then
	spr(pig.sprite,pig.x+70,pig.y+77)
	end
end


--crs !!!!
function create_crs()
	crs={x=47,y=8,
						speed=0.8,
	     sprite=17,
	     name="jacques le crs"}
end

--deplacement crs
function update_crs()
	if crs.x>8 then
		crs.x-=crs.speed
	else
		c3.deja_parle=2
		interact_with_pnj(newx,newy)
	end
end

function draw_crs()
	spr(crs.sprite,crs.x+70,crs.y+53)
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
6655555600111110333333333333333333333333333553334444444344444444333553333333333300000000000000006666666666666aa55666666600000000
665fff5600fffff03333bab3333333333333333333333333444444434444444433333333333333330000000000000000666666666666aaaa6666666600000000
66f5f5f600f5f5f0333ba9ab666666333366666633666633777777737777777733333333333333330000000000000000666a6666666a999a6666666600000000
66fffff600fffff0333b989bccccc633336ccccc536cc63575557573775757573333333353333333000000000000000066aaa666666555666666666600000000
66112116001111103333bbb3ccccc633336ccccc536cc6357666777377777777333333335333333300000000000000006659aa66665556666666666600000000
66112116001111103333343366666633336666663366663377777773756565653333333333333333000000000000000066559aa6665566666666666600000000
66f111f600f111f033333433333333333333333333333333757575737565656533333333333333330000000000000000666559a6665666666666666600000000
66646466000505003333333333333333333333333335533377777773766666663333333333333333000000000000000066665556666666666666666600000000
777777733444444437777773444444443444444337a7777733333333009999902222222200999990000099900000999000111110111111113355555355555555
7575757334475744375775734444444434a444433a9a5757333bbb3300222222ffffffff02222220000022200000222000fffff0ffffffff335fff535ffffff5
777777763777777737777773777777773a9a7773a989a77733bbbbb300f4f4f2f4ffff4f0299999000009f400000429000f0f0f0f0ffff0f33f0f0f3f0ffff0f
75757573375757573757757375755757398975733a9a575733bbbbb300fffff0f4ffff4f00fffff00000fff00000fff000fffff0f0ffff0f33fffff3f0ffff0f
777777763777777737777773777777773777777337a77777333bbb3300ccccc0ffffffff00ccccc00000ccc00000ccc000111110ffffffff3311c113ffffffff
7575757337575757375aa5737575575737577573375757573333433300ccccc0ffffffff00ccccc00000ccc00000ccc000111110f444444f3311c113f555555f
777777763777777747a99a737775577737755773377777773333433300f111f0fffeefff00f111f000001f1000001f1000f111f044eeee4433f111f3ffeeeeff
77777773377555773a9889a375755757377557733777577733333333000d0d00ffffffff000d0d0000000d0000000d00000505004444444433363633ffffffff
00555550555555553666766636666666333333334444444433334333344444444444444466666666666666666666666633333333444444444444444444444443
005fff505ffffff53666766636677766333333334444444433334333344444447777777766677766666666666667776633333333444444444444444444444443
00f0f0f0f0ffff0f3666666636733376333333337575575744444333377777777575575766733376666666666673337633333333777777777777777777777773
00fffff0f0ffff0f3666766636739376333333337777777733333333375577577777777766732376777677766673837633333333757575755757575757575773
00ddddd0ffffffff3666766636733376333333337575575733333333376677777575575766733376666666666673337633333333777777777777777777777773
00ddddd0f555555f3666766636677766333333337777777733333333377777777777777766677766666666666667776633333333757575755757575765656573
00f111f055eeee553666666636666666333333337575575733333333375577577575575766666666666666666666666644444444777777755777777765656573
00060600555555553666766636666666333333337777777733333333375577577775577736666666333333333333333333333333757575755757575766666673
10030011088008800220022000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882223222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03030011888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301888888882232222200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030301888888882233332200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333301088888800222232000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10030011008888000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111000880000003200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333833cccccccccccccccc33333cccccc3333333333333cccccccc444444448844444433777773ddddddd300000000000000000000000000000000
3333333333338a83cccccccccccccccc333cccccccccc33388333333ccbccccc4444444488dd6dd4337fff733dbdbd3300000000000000000000000000000000
3333333333333833cccccccccbbccccc33cccccccccccc3389938333ccccbcccddddddd48dd668d433f1f1f33ddbdd3300000000000000000000000000000000
333333333e333333cccccccccbbccbcc3cccccccccccccc393339193cbcccccc4dbdbd444dd66dd433fffff33dbdbd3300000000000000000000000000000000
33333333eae33333cccccccccccccccc3cccccccccccccc399998993cccccccc4ddbdd4448dd6dd4331191133ddddd3300000000000000000000000000000000
333333333e333323cccccccccccccccccccccccccccccccc98899833cccccccc4dbdbd44888dd4d4331191133ddddd3300000000000000000000000000000000
33333333333332a2ccccccccccccbbcccccccccccccccccc94894883cccccccc4ddddb448d6d64d433f111f33333333300000000000000000000000000000000
3333333333333323cccccccccccccccccccccccccccccccc94894388cccccbcc4ddddbb44d6d64dd333535333333333300000000000000000000000000000000
33bbbb33333e333333333333ccccccccaaaaaaacaaaccccccccccccc33333333334ccccc334cccccccc43333333333330000000033b333330000000000000000
3bbbb8b333eee33333333333ccccccccaaaaaaacaaacccccccc1818c33333333334ccccc334cccccccc43333333333330000000033bb33330000000000000000
3b8bbbb33eeaee3333333333ccccccccaaaaaaccaaaccccccc11181c33333333334ccccc334cccccccc43333cccccccc00000000333b33330000000000000000
3bbb8bb333eee33344444444ccccccccaaaaacccaaaccccccc11887c33eeeee3334ccccc444cccccccc43333cccccccc00000000444b44440000000000000000
33bbbb33333b3333cccccccc44444444aaaaacccaaaccccccc17788c33eeee1e334ccccccccccccc44443333ccc4444400000000cccbcccc0000000000000000
33344333bb3b3bb3cccccccc33333333aaaaccccaaaccccc1c1c77c83eeeeeee334ccccccccccccc33333333ccc4333300000000ccccbccc0000000000000000
333443333bbbbb33cccccccc33333333aaacccccaaaccccc11ccccc8e3eeeee3334ccccccccccccc33333333ccc4333300000000ccbccccc0000000000000000
33444433333b3333cccccccc33333333aaacccccaaacccccc11cc8cc33e23e23334ccccccccccccc33333333ccc4333300000000cccccbcc0000000000000000
33bbbb33333933333333333333333b1bcccccccc333333334333343333333333ccccc33333333333ccc4333300000000000000003bb333333333b33300000000
3bb3bbb3339993333ddd6dd333333bbbccc1111c333333334443443333333333ccccc33333333333ccc43333000000000000000033bbb3333333b33300000000
3bbbbbb3399a99333dd661d333333bb3cc111f1c399393333343434433333333ccccc33333333333ccc4333300000000000000003333b3333333bb3300000000
3bbbb3b3339993333dd66dd333444bb3cc11777c933391933344444333333333ccccc33333444444ccc433330000000000000000333bb33333333b3300000000
333bbb33333b33333ddd6dd33444bbb3cc17777c999999933333433333333333ccccc333334cccccccc43333000000000000000033bb333333bbbb3300000000
33344333bb3b3bb33dddd3d3344bbbb31c1c77cc999993333333433334433333ccccc333334cccccccc43333000000000000000033b333333bb3333300000000
333443333bbbbb333d6d63d334bb3bb311cccccc943943333333433334433333ccccc333334cccccccc43333000000000000000033bbb3333b33333300000000
33444433333b33333d6d63dd33b43b43c11ccccc943943333333433334433333ccccc333334cccccccc4333300000000000000003333b3333bb3333300000000
__gff__
0000000001050103010000010101010003030000000000000000000001010000010101010101010000000000030003000300000000000001010000000000000000000000000000000000000000000000000001010101010101010301000000000100010101010100010101010001000001000101010101010101010100000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
040804040408040803030803030304032626262626322626262626262626262603080308020405040403050302050304050503585050505b5b5b5b34345b343403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308080405030204060405080405080426262626263226262626262626262626020804030503030305080204050305020505050503582626345b3d3e3e3f5b7603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0306040303030303030303020303020826262626263226262626262626262626030402030303020303030303030302050505585802032634345a507e5034347603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0308030303030203030303030303030626262626263226262626263d3e26262605030909090909091c0909090909090b05035859030326343434507d5050347603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0305030203030303030303020303030826262626263220211238261413122626040309090909090c0d0e09090909090b05035858580326503434507e5050347003030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030808030303030303030303030305062626262626323a3a393a3a393a3a3a3a05020909090909091d1e09090909090b03030303037962626203626d6262626203030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030304030302030303020303030307082626262626322226323c20322226262606080a0a0a0a0a0a0a0a0a0a0a0a0a0b7676567634686652520352576666525203030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030304020303030303030303030302042626262626323c35321626323c3526260808090909090909100909090909090b767676763468526b630363636363636303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
03030808040408030303030303030608262626262632202632122332161226260403090909090909090909090909090b703434347068527a703434347634347603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030804060804050303030203030308032626121818321221323a3a3b3a3a3a3a0205090909090909090909090909090b626203626269527a343476763476767603030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030403030303030303030303030304032626191534323a3a3b262626173f262605030304030203030302030303030208525203526652527a343403030304030503030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
030803020303030203030303030304032626193434322426372625262e34262603040203030403030303030203030305636303636363636a343403050305030503030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
040803030303030302030303030305083a3a3a3a3a393a3a3a3a3a393a3a3a3a040305020303030204030303020305060834343434343434343403030305030803030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0804030303020303030303030302030422262626123216122626263220122626020308040503050503030203030504020534343434345634343403030403030503030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0608080503030305030306080404060826262626263226262626263226262626030303030205030305040304080305030205343434343434343405080306030403030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
0303040404080405060503050303030326262626263226262626263226262626030303030303030302030803020403040502087676707070767603030205050503030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303
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
00100000300702d07029070230701e070180701307007070000500002000000000000000000000000000000000000000000000000000000000000000000000000b05000000000000000000000000000000000000
001200002d1222410224102241022d1222d1222d1222d12226122241022410224102281222812228122281222d1222410224102241022d1222d1222d1222d122261222410229122241022c1222c1222c1222c122
000600000a4500d65013650064500b4000a4000b70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002605025050240502305024050250502505025050250502405024050230502305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001500001525015230172501723018250182301525017250172301825018230152301725017230182501823011250112301325013230152501523011250132501323015250152301325018250182301725017230
001500000943509435094350943509435094350943509435094350943509435094350943509435094350943505435054350543505435054350543505435054350743507435074350743507435074350743507435
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00040000190501b0501d0501f0502205025050290502c0502f0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003e0503905036050330502f0502c050290502605023050200501d0501f0502105000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 01020344
00 01020344
02 01040644
00 41444644
00 41424344
00 41424344
00 41424344
00 41424344
03 0a0b4344

