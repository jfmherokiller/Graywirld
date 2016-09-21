
// Project: Graywirld 
// Created: 2016-03-04

// set window properties
#include "defines and such.agc"
screenwidth=256
screenheight=240
SetWindowTitle( "Graywirld" )
SetWindowSize( screenwidth*3, screenheight*3, 0 )

// set display properties
SetVirtualResolution( screenwidth, screenheight )
SetOrientationAllowed( 1, 1, 1, 1 )

rem ultimate test flag!!!
rem 1=active, 0=inactive
UltimateTestFlag = 1

rem load images
GrayOverworld = LoadImage("Main Character.png")
TestMarker = loadimage("Background 1.jpg")
TileMapRoom1 = loadimage("Room1.png")
collision = loadimage("colission.jpg")

rem test room finish later!
tiles = TileMapRoom1


rem antialias 
SetImageMinFilter (GrayOverworld,0)
SetImageMagFilter (GrayOverworld,0)
SetImageMinFilter (TileMapRoom1,0)
SetImageMagFilter (TileMapRoom1,0)



rem skip title to go to game!
if UltimateTestFlag=1
	goto _game
endif

rem title
do



	
Sync()
loop

_game:

rem sprite initialization

_initializesprites:


rem test background
rem createsprite(2,TestMarker)


rem gray sprite

rem setup gray entity
global gray as Entity
gray.x=128
gray.y=120
gray.z=20


createsprite(1,GrayOverworld)
setspriteanimation(1,16,32,16)
SetSpritePosition(1,gray.x-8,gray.y-8)
SetSpriteDepth(1,1)
SetSpriteShape (1,2)


rem room 1 subroutine
gosub room1
rem be sure to add if statements depending on the area

rem generate the tilemap

index=500 rem sprite index
global collisionArray as integer[] rem colission array it contains the sprite indexes with collision enabled


rem master level building algorithm.
for buildy=0 to roomy
	for buildx=0 to roomx step 2
		createsprite(index,tiles)
		setspriteanimation(index,16,16,8)
		if val(mid(room[buildy],buildx,1))=0
			DeleteSprite(index)
		endif
		if val(mid(room[buildy],buildx,1))=1
			SetSpriteFrame(index,1)
			collisionArray.insert(index)
			SetSpriteShape (index, 2)
		endif
		if val(mid(room[buildy],buildx,1))=8
			SetSpriteFrame(index,8)
		endif
		
		SetSpritePosition(index,(buildx*8)-16,(buildy*16))
		inc index
		
	next
	print("")
next



rem main game
do

rem just print out the x and y values of the sprite's position
print (gray.x)
print (gray.y)

remstart
rem test the tilemap values
for buildy=0 to roomy
	for buildx=0 to roomx step 2
		printc(val(mid(room[buildy],buildx,1)))
	next
	print("")
next
remend

rem constantly updates the sprite's position
SetSpritePosition(1,gray.x-8,gray.y-8)
SetViewOffset(gray.x-128,gray.y-120)



rem this checks for collisions between the collision tiles and possibly future entities
gosub collisioncheck
print(sidecheck)





rem this adjusts the x or y value of the sprite's position
if (getrawkeystate(KEY_UP) AND NOT (sidecheck = 1))
	dec gray.y	
endif
if (getrawkeystate(KEY_DOWN) AND NOT (sidecheck = 2))
	inc gray.y
endif
if (GetRawKeyState(KEY_RIGHT) AND NOT (sidecheck =3))
	inc gray.x
endif
if (GetRawKeyState(KEY_LEFT) AND NOT (sidecheck =4))
	dec gray.x
endif






	
sync()
loop

collisioncheck:

//wall check loop
for i=0 to collisionArray.length
sidecheck = collisioncheck(collisionArray[i])
	//if a hit is found then exit for loop
	if(not sidecheck = 0)
		exit
	endif
next

return

function collisioncheck(indexToCheck)
	hitside =0
	//if a collision is not detected then exit function
	if not (GetSpriteCollision (1, indexToCheck ) = 1)
		exitfunction hitside
	endif
		//top check top = 1
		if (GetSpriteY(indexToCheck) - gray.y +8) = -16
			hitside = 1
		endif
		//bottom check bottom = 2
		if (GetSpriteY(indexToCheck) - gray.y +8) = 32
			hitside = 2
		endif
		//right check right = 3
		if(GetSpriteX(indexToCheck) - gray.x +8) = 16
			hitside =3
		endif
		//left check left = 4
		if (GetSpriteX(indexToCheck) - gray.x +8) = -16
			hitside=4
		endif
endfunction hitside

rem create the title
Function RoughTitle()
CreateText(1,"Graywirld")
SetTextAlignment(1,1)
settextsize(1,12)
settextposition(1,128,80)

	
endfunction


rem sets up the first room
remstart
01=collide title
remend
room1:

room as string [15]
roomx=16*2
roomy=15

room[0 ]="01010101010101010101010101010101"
room[1 ]="01080808080808080808080808080801"
room[2 ]="01080808080808080808080808080801"
room[3 ]="01080808080808080808080808080801"
room[4 ]="01080808080808080808080808080801"
room[5 ]="01080808080808080808080808080801"
room[6 ]="01080808080808080808080808080801"
room[7 ]="01080808080808080808080808080801"
room[8 ]="01080808080808080808080808080801"
room[9 ]="01080808080808080808080808080801"
room[10]="01080808080808080808080808080801"
room[11]="01080808080808080808080808080801"
room[12]="01080808080808080808080808080801"
room[13]="01080808080808080808080808080801"
room[14]="01080808080808080808080808080801"
room[15]="01010101010101010101010101010101"


return
