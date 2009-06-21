/**
    Script: orang.k
    ___________________________________________________________________________
    Version 0.1
    Copyright (C) 2009 august0815
   * under GNU
 * -----------------------------------------------------------------------------
 * Agent  : F_INVISIBLE, G_GOODPLANT, S_ORA
 * Sprites: oraponge.c16 //form C3 
 * -----------------------------------------------------------------------------
 */
/* Save this as orang.k  an compile with run_kaos.sh orang.k (run_kaos.bat orang.k ) */
// include files must be in the same folder  !!
define numeric F_INVISIBLE = 1 ;
define numeric G_GOODPLANT = 4;
define numeric S_ORA =3002;
define numeric S_ORA_SEED=3003;
#include predef.k 

#include mymacro.k 

ovar numeric temp40[40];

install {
numeric ypos=9500; // in DS meso
numeric xpos=1250; // in DS meso
numeric t=0;
do{
t=t+1;
        agent opal;numeric x,y,z;
      	opal = newcompound(F_INVISIBLE, G_GOODPLANT, S_ORA,"oraponge", 59 ,0 ,4200);
      	opal.attributes=197;
		opal.perm=100;
		opal.elasticity=0;
		opal.clickAction=(-1);
		opal.acceleration=1;
		opal.aerodynamics=5;
		opal.friction=100;
		opal.pose=4;
		x=(t*20)+1250;//xops
		 	
      	opal.moveto(x,ypos); 
      	opal.age_of_agent=399;
		opal.stage_of_life=8;
		opal.bioenergy=55;
		opal.tick=10;
	} while t<2
}
script ( F_INVISIBLE, G_GOODPLANT, S_ORA, 9) {agent a=owner; numeric randval;
   a.age_of_agent=a.age_of_agent+1;
   if (roomOfTarg(a)==9) {deth2(a);}//NOT IN WATER :)
   
   if (a.age_of_agent>700) {deth2(a);}
   if ((a.age_of_agent>0) && (a.age_of_agent<25)) {a.pose=4; a.stage_of_life=0;};
   if ((a.age_of_agent>=25) && (a.age_of_agent<75) && (a.stage_of_life==0) ) {a.pose=5; a.stage_of_life=1;};
   if ((a.age_of_agent>=75) && (a.age_of_agent<100)&& (a.stage_of_life==1)) {a.pose=6; a.stage_of_life=2;};
   if ((a.age_of_agent>=100) && (a.age_of_agent<150) && (a.stage_of_life==2)) {a.pose=7; a.stage_of_life=3;};
   if ((a.age_of_agent>=150) && (a.age_of_agent<200) && (a.stage_of_life==3)) {a.pose=8; a.stage_of_life=4;};
   if ((a.age_of_agent>=200) && (a.age_of_agent<250) && (a.stage_of_life==4)) {a. baseIndex=9; a.stage_of_life=5;};//set base 9
   if ((a.age_of_agent>=250) && (a.age_of_agent<300) && (a.stage_of_life==5)) {a. baseIndex=19; a.stage_of_life=6;};
   if ((a.age_of_agent>=300) && (a.age_of_agent<350) && (a.stage_of_life==6)) {a. baseIndex=29; a.stage_of_life=7;};
   if ((a.age_of_agent>=350) && (a.age_of_agent<400) && (a.stage_of_life==7)) {a. baseIndex=39; a.stage_of_life=8;};
   if ((a.age_of_agent>=400) && (a.age_of_agent<450) && (a.stage_of_life==8)) {a. baseIndex=49; a.stage_of_life=9;};

   if ((a.stage_of_life>4) && (a.stage_of_life<10) ) {a.anim(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 255);};
   
   if (a.age_of_agent>700) {kill(a);}/* {deth2(a);}*/; //is needed?
   
   if ((a.stage_of_life>0) || (a.stage_of_life<2) ) {check(a);};
   
   if (a.stage_of_life==10) { a.temp40=a.temp40+1;
   								if (a.temp40==20) {a.stage_of_life=9;}
   							}	
 
	
	if (a.stage_of_life==9)  {randval=getRandom(1,20); if (randval=10) {seed();} };
	
  }

  
 script ( F_INVISIBLE, G_GOODPLANT, S_ORA_SEED, 9) {agent a=owner;
 		if (a.stats==0) { whatroom(a); a.age_of_agent=a.age_of_agent+2;
 			if ((a.tmp==99) || (a.age_of_agent>1500)) {deth (a);}
 			if ((a.age_of_agent>1000) && (a.age_of_agent<1500)) {a.acceleration=0.50;a.stats=1;/*wait 75? */}
 			a.anim(0, 1, 2, 3, 255);
			} 
 		if (a.stats!=0)	{ grow(a);}	/* and not carr!!*/
 		rndm(a);
 		move_it(a);
 		a.velocity (a.x_heading,a.y_heading);
}

remove {
     enum ( F_INVISIBLE, G_GOODPLANT, S_ORA) {|p| p.kill();}
     enum ( F_INVISIBLE, G_GOODPLANT, S_ORA_SEED) {|p| p.kill();}    
	// Zap the scripts.
	deletescript(  F_INVISIBLE, G_GOODPLANT, S_ORA,9);
	deletescript(F_INVISIBLE, G_GOODPLANT ,S_ORA_SEED,9);
}
