/// @description Insert description here
// You can write your code in this editor
//Get playerinput
key_left = keyboard_check(vk_left) || keyboard_check(ord("A")) || gamepad_axis_value(0,gp_axislh) < 0;
key_right = keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_axis_value(0,gp_axislh) > 0;
key_jump = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);

//Restart room
if keyboard_check_pressed(ord("R"))
{
	if room == (room0) or room == (room3_5)
	{
			room_goto(2);
	}
	
else
	{
		room_restart();
	}
}

//Inventorystart

if keyboard_check_pressed(ord("O")) && layer_exists("Inventory")

{
	if instance_exists(oInv)
		{
			instance_destroy(oInventoryparent);
		}
	else
		{
			script_execute(Inventoryscript);
		}
}

//Calculate movement
var move = key_right - key_left;

hsp = move * walksp;

vsp = vsp + grv;

//Jump
if (place_meeting(x,y+1,oWallParent)) && (key_jump)
{
	vsp = -7;
}


//Doublejump
if (!place_meeting(x,y+1,oWallParent)) && (key_jump) && (djf >= 1) && (!place_meeting(x+5,y,oWallParent)) && (!place_meeting(x-5,y,oWallParent))
{
	vsp = -7;	
	djf -= 1;
}

//Doublejump reset
if (place_meeting(x,y+1,oWallParent))
{
		djf = 1;
}


//Walljump
if (place_meeting(x+4,y,oWallParent)) && (key_jump) or (place_meeting(x-4,y,oWallParent))  && (key_jump)
{
	vsp = -7;
}

/*Playerzip
if keyboard_check_pressed(vk_control)
{
	hsp = (sign(hsp) * 60);
}
*/

//Horizontal collision
if (place_meeting(x+hsp,y,oWallParent))
{
	while (!place_meeting(x+sign(hsp),y,oWallParent))
	{
			x = x+sign(hsp);
	}
	hsp = 0;
}	
x = x + hsp;

//Vertical collision
if (place_meeting(x,y+vsp,oWallParent))
{
	while (!place_meeting(x,y+sign(vsp),oWallParent))
	{
			y = y+sign(vsp);
	}
	vsp = 0;	
}	
y = y + vsp;

//Call Destroy event
if hp <= 0
{
	instance_destroy();
}

//----Player Animation
//With Runningshoes
if runningshoes = 1
{
	if (!place_meeting(x,y+1,oWallParent))
	{
		//Falling = frame 1 jumping = 0
		sprite_index = sPlayerAir1
		image_speed = 0
		if (sign(vsp) > 0) image_index = 1; else image_index = 0;
	}
	else
	{
		//Standing
		image_speed = 1;
		if (hsp == 0)
		{
			sprite_index = sPlayer1;
		}
		else 
		{
			sprite_index = sPlayerR1;
		}
	}
}
//Without Runningshoes
else
{
	if (!place_meeting(x,y+1,oWallParent))
	{
		//Falling = frame 1 jumping = 0
		sprite_index = sPlayerAir
		image_speed = 0
		if (sign(vsp) > 0) image_index = 1; else image_index = 0;
	}
	else
	{
		//Standing
		image_speed = 1;
		if (hsp == 0)
		{
			sprite_index = sPlayer;
		}
		else 
		{
			sprite_index = sPlayerR;
		}
	}
}
//Modellvändare
if (hsp != 0)
{
	image_xscale = sign(hsp);
}

