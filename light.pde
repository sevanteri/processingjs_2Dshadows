
int[] boxes = new int[0];
int[] shadows = new int[0];

bgColor = 0;

PVector mPos, pPos, cPos;

/* @pjs preload="img.png"; */ 
PImage iL;
iLw = iLh = 600;


void setup() {
    size(800,600);
    background(bgColor);
    noLoop();
    
    iL = loadImage("img.png");

    test();

}

void draw() {
    background(bgColor);
    image(iL, mouseX-(iLw/2), mouseY-(iLh/2), iLw, iLh);
    calculateShadows();
    paintBoxes();
    
} 
void mouseMoved() {
    draw();
}
void paintBoxes() {
    fill(40);
    strokeWeight(1);
    stroke(30);
    for (int b = 0; b < boxes.length; b++) {
        beginShape();
        for (int p=0; p<boxes[b].length; p++) {
            vertex(boxes[b][p][0], boxes[b][p][1]);
        }
        endShape(CLOSE);
    }
}
void calculateShadows() {
    strokeWeight(1);
    stroke(1);
    PFont fontA = loadFont("Courier New");  
    textFont(fontA, 18);
    
    shadows = new int[0];
    for (int b = 0; b < boxes.length; b++) {
        append(shadows, []);
        for (int p=0; p<boxes[b].length; p++) {
            mPos = new PVector(mouseX, mouseY);
            pPos = new PVector(boxes[b][p][0], boxes[b][p][1]);

            if (mPos.dist(pPos) > 300) {
                continue;
            }

            cPos = mPos;            
            cPos.sub(pPos);
            cPos.normalize();
            cPos.mult(-600);
            pPos.add(cPos);
            
            a = pPos.array();
            //line(boxes[b][p][0], boxes[b][p][1], a[0], a[1]);
            append(shadows[b], [boxes[b][p][0], boxes[b][p][1]]);
            append(shadows[b], [a[0], a[1]]);
        }
        if (shadows[b].length > 2) {
            append(shadows[b], shadows[b][0]);
            append(shadows[b], shadows[b][1]);
        }
    }
    paintShadows();
}
void paintShadows() {
    fill(0);
    stroke(0);
    strokeWeight(0);
    
    for (int s = 0; s < shadows.length; s++) {
        beginShape(QUAD_STRIP);
        for (int p=0; p < shadows[s].length; p++) {
            vertex(shadows[s][p][0], shadows[s][p][1]);
        }
        endShape(CLOSE);
    }
    /*
    for (int s = 0; s < shadows.length; s++) {
        beginShape(TRIANGLE_STRIP);
        for (int p=0; p < shadows[s].length; p++) {
            vertex(shadows[s][p][0], shadows[s][p][1]);
        }
        endShape(CLOSE);
    }
    */
}
int[][] getBoxes() {
    return boxes;
}
int[][] getShadows() {
    return shadows;
}
void addBox(data) {
    append(boxes, data);
}

void test() {
    addBox([
         [250,300]
        ,[300,400]
        ,[200,400]
    ]);
    addBox([
         [250,100]
        ,[250,200]
        ,[200,200]
        ,[200,100]
    ]);
    draw();
}

void mouseClicked() {
    Box b = new Box(mouseX, mouseY, 25, 25);
    b.draw();
}

class Box {
    int xpos, ypos, width, height;
    int[] points = new int[4];
    Box(x,y,w,h) {
        xpos = x; ypos = y;
        width = w; height = h;
        
        points[0] = [xpos, ypos];
        points[1] = [xpos+w, ypos];
        points[2] = [xpos+w, ypos+h];
        points[3] = [xpos, ypos+h];
    }
    void draw() {
        /*
        beginShape();
        for (int p=0;p<points.length;p++) {
            vertex(points[p][0], points[p][1]);
        }
        endShape(CLOSE);
        */
        addBox(points);
    }
}
