import java.awt.Robot;
import java.awt.AWTException;
Robot rob;
Ray ray;
Ray walk;
Square s_;
Square t_;
Square r_;
float xit;
float aoff = PI;
Shapes s;
PVector pos;
PVector angl;
void setup(){
	try{
		rob = new Robot();
	}
	catch(AWTException e){
		exit();   
	}
	pos = new PVector(200,200);
	//size(600,600);
	fullScreen();
	background(0);
	stroke(255);
	noFill();
	rectMode(CENTER);
	ray= new Ray(vecpac(200,200),PVector.fromAngle(0));
	walk = new Ray(vecpac(200,200),PVector.fromAngle(0));
	s = new Shapes();
	int[][] map = {{0,0,0,1},
				   {1,0,1,1},    
				   {1,0,0,1},
				   {1,1,1,1}};
	maze(5);
	ellipseMode(CENTER);
	angl = new PVector(0,0);
	//s.draw();
	xit = width/iteration;
	rob.mouseMove(width/2,height/2);
}


PVector vecpac(float x,float y){
	 PVector temp = new PVector(x,y);   
	 return temp;
}


float theta = aoff;
float fov = radians(127);
float iteration = 100*PI;
float iterate = fov/iteration;
float size;
float aperture =80;
float xoff = xit;
float diff = theta - (aoff+fov/2);
static float sq2 = 1.41;
static float maxdist = 600*sq2;

void draw(){
	noStroke();
	background(0);
	xoff = xit/2;
	theta = aoff;
	walk.ang = vecpac(cos(aoff+fov/2),sin(aoff+fov/2));
	walk.pos.x = pos.x;
	walk.pos.y = pos.y;
	noStroke();
	for(int i = 0;i<=iteration;i++){
		diff = theta - (aoff+fov/2);
		//PVector mouse = new PVector(mouseX,mouseY);
		ray.ang = vecpac(cos(theta),sin(theta));
		ray.pos.x = pos.x;
		ray.pos.y = pos.y;
		ray.draw();
		size = maxdist-dist(ray.pos.x,ray.pos.y,pos.x,pos.y)+(aperture/cos(diff));
		size = map(size,0,maxdist,0,height);
		if(ray.r > 200){
			size = 0;   
		}
		//fill(255,50);
		rect(xoff,height/2,xit,size);
		fill(255,20);
		rect(xoff,size+3*(height-size)/4,xit,(height-size)/2);
		fill(255,200);
		rect(xoff,(height-size)/4,xit,(height-size)/2);
		xoff += xit;
		if(theta>=(aoff+fov)){
			 theta = aoff;
		}
		else{
			 theta += iterate;
		}
		text(frameRate,0,60);
	}
	if(keyPressed){
	 	if(key == 'a'){
			walk.ang.rotate(-HALF_PI);
			walk.draw();
			if(dist(walk.pos.x,walk.pos.y,pos.x,pos.y)>4){
				pos.x += 3*walk.ang.x;
				pos.y += 3*walk.ang.y;
			}
			walk.ang.rotate(HALF_PI);
		}
		if(key == 'd'){
			walk.ang.rotate(HALF_PI);
			walk.draw();
			if(dist(walk.pos.x,walk.pos.y,pos.x,pos.y)>4){
				pos.x += 3*walk.ang.x;
				pos.y += 3*walk.ang.y;
			}
			walk.ang.rotate(-HALF_PI); 
		}
		if(key=='s'){
			walk.ang.rotate(-PI);
			walk.draw();
			if(dist(walk.pos.x,walk.pos.y,pos.x,pos.y)>4){
				pos.x += 3*walk.ang.x;
				pos.y += 3*walk.ang.y;
			}
			walk.ang.rotate(PI); 
		}
		if(key=='w'){
			walk.draw();
			if(dist(walk.pos.x,walk.pos.y,pos.x,pos.y)>4){
				pos.x += 3*walk.ang.x;
				pos.y += 3*walk.ang.y;
			} 
		}
		if(key=='j'){
			aoff += PI/30;
		}
		if(key=='h'){
			aoff -= PI/30;   
		}
	}
	stroke(255,0,0);
	text(frameRate,0,60);
	//stroke(255,255,0);
	//s.draw();
}




/*MAP GENERATE FUNCTIONS
	Contains:
		generate
*/





// void generate(int[][] map){
// 	   float h = (height/map.length)/2;
// 	   float xoff = h;
// 	   float yoff = h;
// 	   s.squares.add(l);
// 	   for(int y = 0;y < map.length;y++){
// 		   for(int x = 0;x <map[0].length;x++){
// 				if(map[y][x] ==1){
// 					Square sq = new Square(h,vecpac(xoff,yoff));
// 					//s.squares.add(sq);
// 				}
// 				xoff += 2*h;
// 		   }
// 		   xoff = h;
// 		   yoff += 2*h;
// 	   }
// }
void maze(int size){
	int[][] map = new int[size][size];
	Line l;
	kruskal(map);
	float xit = 600/size;
	float yit = xit;
	for(int y = 0;y<size;y++){
		for(int x = 0;x<size-1;x++){
			if(map[y][x] != 2 && map[y][x+1] != 1){
				l = new Line((x+1)*xit,y*yit,(x+1)*xit,(y+1)*yit);
				s.squares.add(l);
			}
		}
	}
	for(int y = 0;y < size-1;y++){
		for(int x = 0;x < size;x++){
			if(map[y][x] != 4 && map[y+1][x] != 3){
				l = new Line(x*xit,(y+1)*yit,(x+1)*xit,(y+1)*yit);
				s.squares.add(l);
			}
		}
	}
	l = new Line(0,0,0,600);
	s.squares.add(l);
	l = new Line(0,0,600,0);
	s.squares.add(l);
	l = new Line(0,600,600,600);
	s.squares.add(l);
	l = new Line(600,0,600,600-yit);
	s.squares.add(l);
}

void kruskal(int[][]map){
	int w = map[0].length;
	int h = map.length;
	int lose = 0;
	int[][] regions = new int[h][w];
	int [][] visited = new int[h][w];
	int iterate = 0;
	for(int i = 0;i < h;i++){
		 for(int j = 0;j < w;j++){
				regions[i][j] = iterate;
				iterate++;
		 }
	}
	for(int y =0;y < h;y++){
		for(int x = 0;x < w;x++){
			int n = 0;
			short[] ne = new short[4];
			int nei = 0;
			if(x > 0){
				if(regions[y][x] != regions[y][x-1]){
					ne[n] = 1;
					n++;
				}
			}
			if(x <  w -1){
				if(regions[y][x] != regions[y][x+1]){
					ne[n] = 2;
					n++;
				}
			}
			if(y >0){
				if(regions[y][x] != regions[y-1][x]){
					ne[n] = 3;
					n++;
				}
			 }
			if(y < h-1){
				if(regions[y][x] != regions[y+1][x]){
					ne[n] = 4;
					n++;
				  }
			}
			int rand = floor(random(0,n));
			nei = (int)ne[rand];
			switch(nei){
				case 1:
					lose = regions[y][x-1];
					break;
				case 2:
					lose = regions[y][x+1];
					break;
				case 3:
					lose = regions[y-1][x];
					break;
				case 4:
					lose = regions[y+1][x];
					break;	
			}
			map[y][x] = nei;
			for(int yy = 0;yy < h;yy++){
				for(int xx = 0;xx < w;xx++){
					if(regions[yy][xx] == lose){
						regions[yy][xx] = regions[y][x];   
					}
				}
			}
		}
	}
}
