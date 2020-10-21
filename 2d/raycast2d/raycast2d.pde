int[] map = {1,0,1,0,0,0,
			 0,0,0,0,0,0,
			 1,1,1,0,1,0,
			 0,0,0,0,0,0,
			 0,1,0,1,0,1,
			 0,0,0,0,0,0,
			 1,0,1,1,1,0,
			 0,0,0,0,0,0};
int mapx = 6;
int mapy = 8;
void settings() {
	fullScreen(P2D);
}
int currx = width/2;
int curry = height/2;
void setup(){
		strokeWeight(2);
}
void draw() {
	background(0);
	for(float theta = 0;theta < TWO_PI;theta+=radians(0.8)){
		int ro = 0;
		int x  = currx;
		int y = curry;
		int value = 0;
		while(x < width&&x > 0&&y < height&&y>0&&value==0){
			stroke(255,255,0,50);
			x = floor(currx + (ro * cos(theta)));
			y = floor(curry + (ro* sin(theta)));
			int y_ = int(map(y,0,height,0,mapy-1));
			int x_ = int(map(x,0,width,0,mapx-1));
			value = map[(x_+y_*mapx)];
			ro++;
			point(x,y);
		}
		stroke(255);
		point(x,y);
	}
	currx = mouseX;
	curry = mouseY;
}
