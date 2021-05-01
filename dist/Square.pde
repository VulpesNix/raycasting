class Square{
    float l;
    PVector pos;
    PVector[] corners;
    float max;
    float col;
    color c;
    Square(float l_,PVector pos_){
        c = color(255);
        l = l_;
        max = dist(0,0,l,l);
        pos = new PVector(pos_.x,pos_.y);
        corners = new PVector[4];
        int i = 0;
        for(int y =1;y>=-1;y-=2){
            for(int x =1;x>=-1;x-=2){
                 PVector c= new PVector(pos.x+x*l,pos.y+y*l);
                 corners[i] = c;
                 i++;
            }
        }
    }
    
    void draw(){
        rectMode(CENTER);
        rect(pos.x,pos.y,2*l,2*l);
        for(PVector p: corners){
             point(p.x,p.y);   
        }
    }
    float distance(PVector p){
        float min = abs(dist(corners[0].x,corners[0].y,p.x,p.y));

        for(int i = 1;i<4;i++){
            if(min>abs(dist(corners[i].x,corners[i].y,p.x,p.y))){
                 min = abs(dist(corners[i].x,corners[i].y,p.x,p.y));
            }
        }
        if(abs(pos.x-p.x)>=abs(pos.y-p.y)){
            if(min>((dist(pos.x,pos.y,p.x,p.y)-(l*dist(pos.x,pos.y,p.x,p.y))/abs(pos.x-p.x)))){
                min = ((dist(pos.x,pos.y,p.x,p.y)-(l*dist(pos.x,pos.y,p.x,p.y))/abs(pos.x-p.x)));
                c = color(255,50);
            }
        }
        else{
            if(min>((dist(pos.x,pos.y,p.x,p.y)-(l*dist(pos.x,pos.y,p.x,p.y))/abs(pos.y-p.y)))){
                min = ((dist(pos.x,pos.y,p.x,p.y)-(l*dist(pos.x,pos.y,p.x,p.y))/abs(pos.y-p.y)));
                c = color(255,50);
            }
        }
        if(map(dist(pos.x,pos.y,p.x,p.y),l,max,0,1)>0.9){
             c = color(255,100);   
        }
        else{
             c = color(255,50);   
        }
        return min;
    }
}
