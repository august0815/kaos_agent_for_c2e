/**
   Script: simplemonitor
    ___________________________________________________________________________
    Version 0.1
    Copyright (C) 2008 august0815
   * under GNU
 * -----------------------------------------------------------------------------
 * Agent  : F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR
 * Sprites: monitor
 * -----------------------------------------------------------------------------
 */
#include classifiers.k 
#include predef.k 

ovar numeric hidden[99];//true=1 false =0
install {
        agent simplemonitor;
      	simplemonitor = newcompound(F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR, "ds gui", 77,2, 5000);
      	simplemonitor.attributes = A_CAMERASHY|A_FLOATABLE|A_INVISIBLE;;
        simplemonitor.floatat(-331, 400);
        simplemonitor.tick = 2;
        simplemonitor.hidden=1;
      	simplemonitor.newtextinputpart(1, "ds gui", 4, 100, 100, 0, 0, "whiteontransparentchars");
        simplemonitor.changepart(1);
		simplemonitor.textformat(1 ,1, 1, 1, 1, 1, 0);	
		simplemonitor.newtextinputpart(2, "ds gui", 4, 100, 115, 0, 0, "whiteontransparentchars");
        simplemonitor.changepart(2);
		simplemonitor.textformat(1 ,1, 1, 1, 1, 1, 0);	
		simplemonitor.newbutton(3, "ds gui", 14, 77, 331, 0,  0 ,"[]", 2000, 1);
		simplemonitor.newbutton(4, "ds gui", 16, 77, 331, 170,  0 ,"[]", 2001, 1);
		  }
     
script (F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR,2000) {agent a=owner;
 if (a.hidden==0) {a.velocity((-20),0);wait(15);velocity(a,(0),0);}
 a.hidden=1;
  }

script (F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR,2001) {agent a=owner;
 if (a.hidden==1) { velocity(a,(20),0);wait(15);velocity(a,(0),0);}
 a.hidden=0;
  }     
    
script ( F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR, 9) {
	agent s;s=owner;numeric room;numeric x;numeric y;numeric type;string fo;numeric foo;string fooo;
	string ausgabe="Room ";numeric xx;numeric yy;
	s.changepart(1);
	room=getroomid(mouseX(),mouseY());
    //ausgabe= addstring(ausgabe,NumToStr(room));
    //if (room>(-1)) { ausgabe=addstring(ausgabe,"@");ausgabe=addstring(ausgabe,returnLocation(room));}
    //s.parttext=ausgabe;
    ausgabe="X:  " ;
    xx = pointer.x;
    ausgabe=addstring(ausgabe,NumToStr(xx));
    s.parttext=ausgabe;
	s.changepart(2); 
    ausgabe="Y:  " ;
    yy = pointer.y;
    ausgabe=addstring(ausgabe,NumToStr(yy));
    s.parttext=ausgabe;
}

remove {
     enum (F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR) {|p| p.kill();}
	// Zap the scripts.
	deletescript( F_INVISIBLE, G_SYSTEM, S_SIMPLEMONITOR,9);
}
