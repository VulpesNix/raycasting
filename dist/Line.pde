class Line{
	PVector A;
	PVector B;
	color c;
	Line(float a1,float a2,float b1,float b2){
		A = new PVector(a1,a2);
		B = new PVector(b1,b2);
		c = color(255,50);
	}
	float distance(PVector p){
		c = color(255,100);
		PVector Ap = new PVector(p.x-A.x,p.y-A.y);
		PVector Bp = new PVector(p.x-B.x,p.y-B.y);
		PVector AB = new PVector(B.x-A.x,B.y-A.y);
		float Ap_AB = (Ap.x * AB.x + Ap.y*AB.y);
		float Bp_AB = (Bp.x * AB.x + Bp.y*AB.y);
		if(Bp_AB > 0){
			return sqrt(Bp.x*Bp.x+Bp.y*Bp.y);
		}else if(Ap_AB < 0){
			return sqrt(Ap.x*Ap.x+Ap.y*Ap.y);
		}else{
			c = color(255,50);
			float mod = sqrt(AB.x*AB.x+AB.y*AB.y);
			float res = abs(AB.x*Ap.y-AB.y*Ap.x)/mod;
			if(abs(res-sqrt(Ap.x*Ap.x+Ap.y*Ap.y)) < 1.5 || abs(res-sqrt(Bp.x*Bp.x+Bp.y*Bp.y)) < 1.5){
				c = color(255,100);
			}
			return res;
		}

	}
	void draw(){
		line(A.x,A.y,B.x,B.y);
	}
}
