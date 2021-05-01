class Shapes{
     ArrayList<Line> squares;
     Shapes(){
         squares = new ArrayList();   
     }
     void add(Square s){
         //squares.add(s);
     }
    float distance(PVector p){;
         float min = squares.get(0).distance(p);
         for(Line s : squares){
              if(s.distance(p) < min){
                  min = s.distance(p);
                  fill(s.c);
              }   
         }
         //line(p.x,p.y,p.x-(col.x*min),p.y-(col.y*min));
         return min;
    }
    void draw(){
         for(Line s : squares){
            s.draw();
         }     
    }
}
