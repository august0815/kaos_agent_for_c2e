ovar numeric tmp[99];
ovar numeric temp86[86];
ovar numeric temp87[87];

define isok(numeric x,numeric y) returning numeric
{
  _caos {
    .inline let $return = TMVT $x(r) $y(r);
  };
}
define walldown() returning numeric
{
  _caos {
     .inline let $return = OBST DOWN;
    };
  };
define wallup() returning numeric
{
  _caos {
     .inline let $return = OBST _UP_;
    };
  };


define deth2(agent a) { agent b,c; b=null();c=heldBy(owner);
				if (c!=b)   { a.tmp=99;}
					else 	{ 
							if (owner.stage_of_life==0) {owner.baseIndex=0;framerate(3); a.anim(4);}
							  if (owner.stage_of_life==1) {owner.baseIndex=0;framerate(3); a.anim(5,4);}
							  if (owner.stage_of_life==9 || owner.stage_of_life==10)  {a.baseIndex=0;framerate(5); a.anim(49,39,29,19,9,8,7,6,5,4);}
							kill(a);
							}	
				}
define deth(agent c) { agent a,b; b=null();//a=heldBy(owner);
				//if (a!=b)   { a.tmp=99;}
					//else {
					 kill(c);
					 //}	
				}
				
define check(agent a) {
 numeric temp=0;numeric temp40;

  if (temp==0) { temp40=0; range (500);
  				_caos{esee 1 4 3002;}; temp40=temp40+1;_caos{next;} 
 	 			if (temp40>7) {kill(a); } temp=temp+1;} //deth2(a) 
 	 			
  if (temp==1) { temp40=0;  
       _caos{etch 1 4 3002;}  temp40=temp40+1;_caos{next;}
       if (temp40>2) {kill(a);} }//deth2(a)  

}		

define grow (agent c) {numeric tmpx,tmpy,t1,t2;agent b;
			tmpx=owner.x();tmpy=owner.y();
			b=newcompound(F_INVISIBLE, G_GOODPLANT, S_ORA,"oraponge", 59 ,0 ,4200);
			b.attributes=192;
			b.perm=100;
			b. elasticity=20;
			b. clickAction=(-1);
			b.acceleration=1;
			b.aerodynamics=5;
			b. friction=100;
			b.pose=4;
			t1=isok(tmpx,tmpy);
			if (t1==1) {b.moveto(tmpx,tmpy);}
		       else  {b.kill;stop(); };
		    
			b.age_of_agent=0;
			b.stage_of_life=0;
			b.bioenergy=50;
			b.tick=5;
			_caos{slow;}
			deth(owner);
}


define seed() { numeric tmpx,tmpy,t1,tt,t3,t4,u;agent b;
				tt=0;t4=0;t3=0;b=owner;
				tmpx=b.x()+2;
				tmpy=b.y()-58;
				t1=70; 	range (500);
				tt=0;
				//this has to be changed !!
				_caos {ESEE 1 4 3003 ADDV $tt(rw) 1 NEXT;}
				if (tt<=4) {t3=getRandom(1,3);}
				if ((tt>=5) && (tt<=7))  {t3=getRandom(1,2);}
				if ((tt>=8) && (tt<=10)) {t3=1;}
				if (tt>10) {t3=0;deth2(b);stop();} //deth2(b)
				if (t3>0) {
		 //reps t3
		 		b=newcompound(F_INVISIBLE, G_GOODPLANT ,S_ORA_SEED, "oraponge", 4 ,0,5000);
				b.attributes=199;
				b.behaviour=32;
			 	b.perm=100;
				b. elasticity=0;
				b. clickAction=(-1);
				b.acceleration=0;
				b.aerodynamics=0;
				b. friction=100;
				t1=isok(tmpx,tmpy);
				if (t1==1) {b.moveto(tmpx,tmpy);}
		       		else  {b.kill;stop(); };
				//tt=getRandom((-1),1);
				b.velocity(tt,-3);
				b.age_of_agent=0;
				b.stage_of_life=0;
				b.bioenergy=20;
				b.tick=1;
				//_caos{slow;}
				}
			   b.stage_of_life=10;
				} 
				
define whatroom(agent a) { 
	if (roomOfTarg(a)==9) { a.temp86=a.temp86+1;
							do {if ((a.temp86>=0) && (a.temp86<=6)) {a.temp87=a.temp87+0.03;}
								if ((a.temp86>6) && (a.temp86<200)) {a.temp87=a.temp87+0.08;}
								a.acceleration=a.temp87;
								} until ((roomOfTarg(a)==9) || (a.temp86 >=200))
							if (a.temp86>200) {wait (getRandom (100,400));deth(a);}
							}
	if (roomOfTarg(a)!=9) { a.temp86=0; a.temp87=0;	}
	a.acceleration=a.temp87;				
}
/*
	subr room
		
		
		doif rtyp room ownr = 9
			setv ov86 0
			setv ov87 0
		endi
		accg ov87
	retn
	*/
define rndm(agent a) { agent b;numeric d;
 do  { a.x_heading=getRandom((-2),2);
 	 } until (a.x_heading!=0);
 d=walldown();
 if (d<500) { do  { a.y_heading=getRandom((-1),1); 	 } until (a.y_heading!=0);}
 if (d>500) { do  { a.y_heading=getRandom((-1),2); 	 } until (a.y_heading!=0);}
 
}	
			
define move_it(agent a) { numeric d,u,l,r;
 u=wallup();d=walldown();l=wallleft();r=wallright();
 if ((d<20) && (u>200)) { a.acceleration=3;a.x_heading=1 ;wait(10);_caos{STOP;};}
 if ((d<20) && (u<=200)) {a.y_heading=(-1);} 
 if (l<50) {a.x_heading=getRandom(2,2);}
 if (r<50) {a.x_heading=getRandom((-2),(-1));}
 if (u<20) {a.y_heading=(2);}
}		

