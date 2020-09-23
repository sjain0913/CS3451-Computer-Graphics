// Class: CS 3451
// Semester: Fall 2020
// Project number: 03
// Project title: Animated Image Warp and Morph
// Student(s): Saumya Jain

//======================= My global variables
PImage PictureOfMyFace; // picture of author's face, should be: data/pic.jpg in sketch folder
PImage PictureOfBanner; // picture of banner, should be: data/pic.jpg in sketch folder

boolean lerp=true, spiral=true; // toggles to display vector interpoations
float b=0, c=0.5, d=1; // initial knots
//String [] PartTitle = new String[10];
String [] titleOfStep = {"?","?","?","?","?","?","?","?","?","?"};
int partShown = 0;

// My Animation
int MyFramesInAnimation=63;
int myCurrentFrame=0; // counting frames for animating my arrow morphs 
float myTime=0; // my time for animating my arrow morphs 

int numberOfParts = titleOfStep.length;
PNTS DrawnPoints = new PNTS(); // class containing array of points, used to standardize GUI
PNTS SmoothenedPoints = new PNTS(); // class containing array of points, used to standardize GUI
DUCKS DucksRow = new DUCKS(20);

//**************************** My text  ****************************
String title ="Class: 3451, Year: 2020, Project 03",            
       name ="Student: Saumya JAIN";
String subtitle = "Tri-Quadratic Warp Animation (TQWA)";    
String guide="MyProject keys: '0' through '9' to activate steps, 'a' to start/stop animation "; // help info

//**************************** Color Ramp  ****************************
COLOR_RAMP colors = new COLOR_RAMP(65);

// Toggles for the project
Boolean 
  showDisks=true, 
  showPillars=true,
  showRobot=true,
  showTriangles=true,
  showVertices=true,
  showEdges=true,
  showVisitedTriangles=false,
  showCorner=true,
  showOpposite=false,
  showVoronoiFaces=true,
  showVoronoiEdges=true,
  showVoronoiArcs=true,

  step0=true,
  step1=false,
  step2=false,
  step3=false,
  step4=false,
  step5=false,
  step6=false,
  step7=false, // true,
  step8=false,
  step9=false,

  live=true;   // updates mesh at each frame

//======================= my setup, executed once at the beginning 
void mySetup()
  {
  DrawnPoints.declare(); // declares all ControlPoints. MUST BE DONE BEFORE ADDING POINTS 
  SmoothenedPoints.declare(); // declares all ControlPoints. MUST BE DONE BEFORE ADDING POINTS 
  DrawnPoints.empty(); // reset pont list P
  SmoothenedPoints.empty(); // reset pont list P
  //initDucklings(); // creates Ducling[] points
  }

//======================= called in main() and executed at each frame to redraw the canvas
void showMyProject(PNTS MySites) // four points used to define 3 vectors
  {
  if(myCurrentFrame==MyFramesInAnimation) myCurrentFrame=0;
  myTime = (float)myCurrentFrame++/MyFramesInAnimation;
  if(easeInOut) myTime = easeInOut(0,0.5,1,myTime);    

    
  if(step0) doStep0(MySites); 
  if(step1) doStep1(MySites); 
  if(step2) doStep2(MySites); 
  if(step3) doStep3(MySites); 
  if(step4) doStep4(MySites); 
  if(step5) doStep5(MySites); 
  if(step6) doStep6(MySites); 
  if(step7) doStep7(MySites); 
  if(step8) doStep8(MySites); 
  if(step9) doStep9(MySites); 
  
  textAlign(LEFT,BOTTOM);
  f(red); 
  int line=2, s=0;
  if(scribeText)
    {
    if(step0) scribeHeader("Step 0: "+titleOfStep[0],line++); 
    if(step1) scribeHeader("Step 1: "+titleOfStep[1],line++); 
    if(step2) scribeHeader("Step 2: "+titleOfStep[2],line++); 
    if(step3) scribeHeader("Step 3: "+titleOfStep[3],line++); 
    if(step4) scribeHeader("Step 4: "+titleOfStep[4],line++); 
    if(step5) scribeHeader("Step 5: "+titleOfStep[5],line++); 
    if(step6) scribeHeader("Step 6: "+titleOfStep[6],line++); 
    if(step7) scribeHeader("Step 7: "+titleOfStep[7],line++); 
    if(step8) scribeHeader("Step 8: "+titleOfStep[8],line++); 
    if(step9) scribeHeader("Step 9: "+titleOfStep[9],line++); 
    }
  textAlign(CENTER,CENTER);
  }


//====================================================================== PART 0
PNT[][][] P = new PNT [3][3][3]; // 3x3x3 grid of points
void doStep0(PNTS MySites) //
  {
  titleOfStep[0] = "Make 3x3x3 grid";

  // constructs 3D array P f control points P[i=t][j=v][k=u]
  int p=0;
  if(Sites.pointCount>=27)
    for(int i=0; i<3; i++)
     for(int j=0; j<3; j++)
      for(int k=0; k<3; k++)
        P[i][j][k] = Sites.G[p++];
        
  // shows 3 grids
  cwF(orange,7); 
  for(int t=0; t<3; t++) // for time index t = 0, 1, 2 
    show3x3grid(P[t]); // show the grid Q[][]=P[t]

  // show IDs of control points and circles the one most recently selected
  if(showIDs) // toggle with 'I'
    {
    cwF(dgreen,1); Sites.writeIDsInEmptyDisks();
    cwF(dred,1); Sites.showPickedPoint(16);
    }

  guide="My keys: '0'...'9' to activate/deactivate step, 'I' to hide/show Ids";
  }
// draws 3x3 control grid given a 3x3 array Q[][]
void show3x3grid(PNT[][] Q)
  {
  for(int j=0; j<3; j++) show(Q[j][0],Q[j][1],Q[j][2]);
  for(int k=0; k<3; k++) show(Q[0][k],Q[1][k],Q[2][k]);  
  }

//====================================================================== PART 1
PNT[][] Pt = new PNT [3][3];
void doStep1(PNTS R) //
  {
  titleOfStep[1] = "Compute & show 3x3 grid at time t";
  // compute 3x3 control grid at currentTime
   for (int i = 0; i < 3; i++) {
     for (int j = 0; j < 3; j++) {
       Pt[i][j] = L(0, P[0][i][j], 0.5, P[1][i][j], 1, P[2][i][j], currentTime);
     }
   }
   show3x3grid(Pt);
   
  guide="My keys: '0'...'9' to activate/deactivate step, 'a' to animate";
  }
  
//====================================================================== PART 2
void doStep2(PNTS MySites) //
  {
  titleOfStep[2] = "Evaluate Pt[u][v] where (u,v) is Mouse()";
  PNT M= Mouse();
  PNT X = Evaluate(M.x/width,M.y/height,Pt);
  cwf(black,1,dred); show(X,4);
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
PNT Evaluate(float u, float v, PNT Q[][])
  {
    PNT A = L(0, Q[0][0], 0.5, Q[0][1], 1, Q[0][2], u);
    PNT B = L(0, Q[1][0], 0.5, Q[1][1], 1, Q[1][2], u);
    PNT C = L(0, Q[2][0], 0.5, Q[2][1], 1, Q[2][2], u);
    
    PNT X = L(0, A, 0.5, B, 1, C, v);
    return X;
    //return P(); // replace this!
  }

//====================================================================== PART 3
int numberOfTiles=8;
void doStep3(PNTS MySites) //
  {
  titleOfStep[3] = "Show fine grid with nxn tiles  at time t";
  cwf(dred,3,yellow); showFineGrid(Pt,numberOfTiles); 
  guide="My keys: '0'...'9' to activate/deactivate step, use ';' or ''' to change n";
  }
void showFineGrid(PNT[][] Q, int n) 
  {
  for(int j=0; j<n; j++)
    for(int k=0; k<n; k++)
      {
      float u0 = (float)j/n, v0 = (float)k/n;
      float u1 = (float)(j+1)/n, v1 = (float)(k+1)/n;
      PNT A = Evaluate(u0,v0,Q);
      PNT B = Evaluate(u0,v1,Q);
      PNT C = Evaluate(u1,v1,Q);
      PNT D = Evaluate(u1,v0,Q);
      beginShape();
      vert(A);
      vert(B);
      vert(C);
      vert(D);  
      endShape(CLOSE);     
      }
  }

 //====================================================================== PART 4
void doStep4(PNTS MySites) //
  {
  titleOfStep[4] = "Show fine grid with nxn textured tiles at time t";
  noFill(); noStroke(); showFineGridTextured(Pt,numberOfTiles); 
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
void showFineGridTextured(PNT[][] Q, int n) 
  {
  for(int j=0; j<n; j++)
    for(int k=0; k<n; k++)
      {
      float u0 = (float)j/n, v0 = (float)k/n;
      float u1 = (float)(j+1)/n, v1 = (float)(k+1)/n;
      PNT A = Evaluate(u0,v1,Q);
      PNT B = Evaluate(u0,v0,Q);
      PNT C = Evaluate(u1,v0,Q);
      PNT D = Evaluate(u1,v1,Q);
      beginShape();
      texture(PictureOfMyFace); 
      vert(A,u0,v1);          // using 1-v because texture coordiates go down
      vert(B,u0,v0);
      vert(C,u1,v0);
      vert(D,u1,v1);  
      endShape(CLOSE);     
      }
  }

 //====================================================================== PART 5
void doStep5(PNTS MySites) //
  {
  titleOfStep[5] = "Transparency on";
  tint(255,currentTime*255); // semi-transparent
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
  
 //====================================================================== PART 6
void doStep6(PNTS MySites) //
  {
  titleOfStep[6] = "Transparency off";
  noTint();
  guide="My keys: '0'...'9' to activate/deactivate step";
  }


 //====================================================================== PART 7
void doStep7(PNTS MySites) //
  {
  titleOfStep[7] = "???";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
  
 //====================================================================== PART 8
void doStep8(PNTS MySites) //
  {
  titleOfStep[8] = "?";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }
  
 //====================================================================== PART 9
void doStep9(PNTS MySites) //
  {
  titleOfStep[9] = "?";
  guide="My keys: '0'...'9' to activate/deactivate step";
  }


    
//======================= called when a key is pressed
void myKeyPressed()
  {
  if(key=='<') MyFramesInAnimation=max(9,MyFramesInAnimation/2);
  if(key=='>') MyFramesInAnimation*=2;
  if(key==';') numberOfTiles=max(1,numberOfTiles-1);; 
  if(key=='\'') numberOfTiles++;  
  if(key=='+') 
    {
    float w = PictureOfMyFace.width, h = PictureOfMyFace.height;
    //float w = PictureOfBanner.width, h = PictureOfBanner.height;
    float s = min(150./w,200/h);
    w*=s; h*=s;
    float d=100;
    Sites.G[1]=P(Sites.G[0],V(w,0));
    Sites.G[2]=P(Sites.G[1],V(w,0));
    Sites.G[3]=P(Sites.G[0],V(0,h));
    Sites.G[4]=P(Sites.G[3],V(w,0));
    Sites.G[5]=P(Sites.G[4],V(w,0));
    Sites.G[6]=P(Sites.G[3],V(0,h));
    Sites.G[7]=P(Sites.G[6],V(w,0));
    Sites.G[8]=P(Sites.G[7],V(w,0));
    }  println(MyFramesInAnimation);
  }

  
//======================= called when the mouse is dragged
void myMouseDragged()
  {
  if (keyPressed) 
    {
    //if (key=='b') b+=2.*float(mouseX-pmouseX)/width;  // adjust knot value b    
    //if (key=='c') c+=2.*float(mouseX-pmouseX)/width;  // adjust knot value c    
    //if (key=='d') d+=2.*float(mouseX-pmouseX)/width;  // adjust knot value a 
    }
  }

//======================= called when the mouse is pressed 
void myMousePressed()
  {
  }
  
