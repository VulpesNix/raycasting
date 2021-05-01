class Ray{
     PVector ang;
     PVector pos;
     float r;
     Ray(PVector p_,PVector a_){
         pos = p_;
         ang = a_;
         r = 0;
         
     }
    void draw(){
         r = s.distance(pos);
         while(r >0.01 && r < 400){
             r = s.distance(pos);
                 //ellipse(pos.x,pos.y,2*r,2*r);
             line(pos.x,pos.y,pos.x+ang.x*r,pos.y+ang.y*r);
             pos.x += (ang.x*r);
             pos.y += (ang.y*r);
         }
         if(r < 200){
             point(pos.x,pos.y);
         }
         
         
     }
}
