boolean flag;
void setup(){
	size(500,500);
	background(0);
	flag = true;
}
void draw(){
	if(flag){
		background(0);
		int[][] map = new int[5][5];
		kruskal(map);
		float yit = width/5;
		float xit = width/5;
		stroke(255);
		for(int y = 0;y<5;y++){
			for(int x = 0;x<4;x++){
				if(map[y][x] != 2 && map[y][x+1] != 1){
					line((x+1)*xit,y*yit,(x+1)*xit,(y+1)*yit);
				}
			}
		}
		for(int y = 0;y < 4;y++){
			for(int x = 0;x < 5;x++){
				if(map[y][x] != 4 && map[y+1][x] != 3){
					line(x*xit,(y+1)*yit,(x+1)*xit,(y+1)*yit);
				}
			}
		}
		flag = false;
	}
}
void keyTyped() {
	flag = true;
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
			for(int i = 0;i <5;i++){
				for(int j = 0;j<5;j++){
					print(regions[i][j],"");
				}
				println();
			}
			println();
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
