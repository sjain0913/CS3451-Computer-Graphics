// Class: CS 3451
// Semester: Fall 2020
// Project number: 1
// Project title: Playing with Points and Vectors
// Student(s): Saumya Jain

//======================= My global variables
PImage PictureOfMyFace; // picture of author's face, should be: data/pic.jpg in sketch folder

boolean lerp=true, spiral=true; // toggles to display vector interpoations
float b=0, c=0.5, d=1; // initial knots
int partShown = 0;
String [] PartTitle = new String[10];


int numberOfParts = PartTitle.length;
PNTS DrawnPoints = new PNTS(); // class containing array of points, used to standardize GUI
PNTS SmoothenedPoints = new PNTS(); // class containing array of points, used to standardize GUI
DUCKS DucksRow = new DUCKS(20);

//**************************** My text  ****************************
String title ="Class: 3451, Year: 2020, Project 01",            
       name ="Saumya JAIN";
String subtitle = "Playing with Points and Vectors";    
String guide="MyProject keys: '0' through '9' to select project parts, 'a' to start/stop animation "; // help info

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
void showMyProject(PNT A, PNT B, PNT C, PNT D) // four points used to define 3 vectors
  {
  if(0<=partShown && partShown<numberOfParts)
    {
    switch(partShown) 
      {
      case 0: showPart0(A,B,C,D); break;
      case 1: showPart1(A,B,C,D); break;
      case 2: showPart2(A,B,C); break;
      case 3: showPart3(A,B,currentTime); break;
      case 4: showPart4(A,B,C,D); break;
      case 5: showPart5(A,B,C,D); break;
      case 6: showPart6(A,B,C,D); break;
      case 7: showPart7(A,B,C,D); break;
      case 8: showPart8(A,B,C,D); break;
      case 9: showPart9(A,B,C,D); break;
      }
    }
  }

//====================================================================== PART 0
void showPart0(PNT A, PNT B, PNT C, PNT D) //
  {
  PartTitle[0] = "Experimenting sandbox";
  //cwf(red,4,green); 
  //VCT V = V(A,B);
  //show(A,V,dgreen,"V");
  //VCT R = R(V);
  //show(A,R,blue,"R(V)");
  //VCT W = R(V,PI/6);
  //show(A,W,dred,"R(V,π/6)");
  
  //VCT U = V(A,B);
  //VCT V = V(A,C);
  //show(A,U,dgreen,"U");
  //float w = angle(U,V);
  //float m = n(V)/n(U);
  //show(A,V,dred,"V("+nf(m,1,2)+",R(U,"+nf(w/PI,1,2)+"*PI))");
  //VCT W = V(m,R(U,w));
  //show(A,V,blue);
 
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
  }

//====================================================================== PART 1
void showPart1(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[1] =   "Complete the parallelogram"; // https://en.wikipedia.org/wiki/Parallelogram
  // Making Vector BC and Point X (Point D of Parallelogram)
  VCT BA = V(B,A);
  PNT X = P(C, BA);
  
  // Making triange of initial points and coloring it
  cwfo(dgold,5,yellow,70);
  showLoop(A,B,C);
  // Making triange of initial points and new point X (Point D of Parallelogram)
  cwfo(dgold,5,dmagenta,70);
  showLoop(A,C,X);
  // Highlighting BA vector which is replicated to get point X
  show(B,BA,green,"BA");
  show(C,BA,blue,"BA");
  // Labeling our new point D
  X.circledLabel("Y");

  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); // D.circledLabel("D");
  }

//====================================================================== PART 2
void showPart2(PNT A, PNT B, PNT C) //   
  {
  PartTitle[2] = "Fermat Point"; // https://en.wikipedia.org/wiki/Napoleon%27s_theorem
  cwf(black,3,yellow);
  showLoop(A,B,C);
  
  // Show the first equilateral triangle ABC'
  VCT BA = V(B, A);
  // Turn BA by PI/6 to get BC' (BX)
  VCT BX = R(BA, 2 * PI/6);
  PNT X = P(B, BX);
  cwf(black,3,red);
  showLoop(A, B, X);
  X.circledLabel("C'");
  
  // Show the second equilateral triangle BCA'
  VCT CB = V (C, B);
  // Turn CB by PI/6 to get CA' (CY)
  VCT CY = R(CB, 2 * PI/6);
  PNT Y = P(C, CY);
  cwf(black, 3, blue);
  showLoop(B, C, Y);
  Y.circledLabel("A'");
  
  // Show the third equilateral triangle CAB'
  VCT AC = V (A, C);
  // Turn AC by PI/6 to get AB' (AZ)
  VCT AZ = R(AC, 2 * PI/6);
  PNT Z = P(A, AZ);
  cwf(black, 3, green);
  showLoop(C, A, Z);
  Z.circledLabel("B'");

  // Show the lines from created vertices to opposite vertex of pre-existing triangle. Intersection point is F
  show(A,Y);
  show(B,Z);
  show(C,X);
  
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); // D.circledLabel("D");
  }


//====================================================================== PART 3
void showPart3(PNT A, PNT B, float t) //    
  {
  PartTitle[3] = "Symmetrical Recursive Pattern"; // https://en.wikipedia.org/wiki/Pythagoras_tree_(fractal)
  
  // Created base square and its triangle
  VCT AB = V(A, B);
  VCT BC = R(AB);
  PNT C = P(B, BC);
  VCT CD = R(BC);
  PNT D = P(C, CD);
  cwf(gold,5,dmagenta);
  showLoop(A, B, C, D);
  // New point E
  VCT BE = R(AB, PI/6);
  PNT E = P(B, BE);
  VCT CE = V(C, E);
  showLoop(B, C, E);
  
  // Making the generation of new recursive levels time dependent
  int n = (int)(t * 10);
  generateLeft(B, E, BE, n);
  generateRight(C, E, CE, n);
  
  A.circledLabel("A"); B.circledLabel("B");C.circledLabel("C"); D.circledLabel("D"); E.circledLabel("E");
  }
  
  void generateLeft(PNT A, PNT X, VCT AX, int n)
  {
    if (n > 0)
      {
        // Create required square
        VCT XM = R(AX, 3 * PI/2);
        PNT M = P(X, XM);
        VCT MN = R(XM, 3 * PI/2);
        PNT N = P(M, MN);
        showLoop(A, X, M, N);
        // Create required eq triangle
        VCT MO = R(MN, PI/3);
        PNT O = P(M, MO);
        VCT NO = V(N, O);
        showLoop(M, O, N);
        
        // Decrement n and recurse until at required repetition
        n--;
        generateLeft(N, O, NO, n);
        generateRight(M, O, MO, n);
      }
   
  }
  
  void generateRight(PNT A, PNT X, VCT AX, int n)
  {
    if (n > 0)
      {
        // Create required square
        VCT XM = R(AX, PI/2);
        PNT M = P(X, XM);
        VCT MN = R(XM, PI/2);
        PNT N = P(M, MN);
        showLoop(A, X, M, N);
        // Create required eq triangle
        VCT MO = R(MN, -PI/3);
        PNT O = P(M, MO);
        VCT NO = V(N, O);
        showLoop(M, O, N);
        
        // Decrement n and recurse until at required repetition
        n--;
        generateRight(N, O, NO, n);
        generateLeft(M, O, MO, n);
      } 
  }
  
//====================================================================== PART 4
void showPart4(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[4] =   "Log-spiral pattern"; // https://pin.it/7wgYDeq 
  cwF(red,3); show(A,B,C);
  cwF(blue,3);
  drawSpiral(A,B,C,60);
  A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); //D.writeLabel("D");
  }
void drawSpiral(PNT A, PNT B, PNT C, int recursionCount)
  {
  if(recursionCount==0) return;
  PNT D = extrapolateLogSpiral(A,B,C);

 
  }
PNT extrapolateLogSpiral(PNT A, PNT B, PNT C)
  {
  VCT AB = V(A,B);
  VCT BC = V(B,C);
  
  return P(   );
  }

//====================================================================== PART 5
void showPart5(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[5] =   "Michell truss";
  int k=11, r=11;
  PNT[][] T = new PNT[r][k];
  PNT O = ScreenCenter();
  VCT V = V(O,A);
  for(int i=0; i<k; i++) T[0][i]=P(O,R(V,TWO_PI*i/k));
  cw(green,2);
  
  
  // six lines of code
  
  
 
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  //A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
  }
  
//====================================================================== PART 6
int recursionDepth=9;  
void showPart6(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[6] =   "Recursive tree growth";
  PNT E = P(A,V(B,C));

  if(showIDs)
    {
    E.circledLabel("E");
    A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
    }
  guide="I:display IDs, ,/.:recursion depth";
  //A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
  }

  
  
//====================================================================== PART 7
void showPart7(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[7] =   "Cubic interpolating motion";
  cwF(cyan,5); show(A,B,C,D);
  cwF(red,3); drawNeville(A,B,C,D);
 
  guide="MyProject keys: '0' through '9' to select project, 'a' to start/stop animation ";
  A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
  }
void drawNeville(PNT A, PNT B, PNT C, PNT D)
  {
  beginShape();
  
  
  endShape();
  }

  
//====================================================================== PART 8
void showPart8(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[8] =   "Polyline smoothing";
  cwF(black,3); ControlPoints.drawPolyline(); // draws polyline joining control points
  ControlPoints.drawAllVerticesInColor(3,red); // draw dots at vertices
  //if(showIDs) {cwF(blue,1); ControlPoints.writeIDsInEmptyDisks(); }
  if(showIDs) showArrowIDs();
  cwF(red,1); ControlPoints.showPickedPoint(25);
  int n = ControlPoints.pointCount();
  if(keyPressed && key=='f' && n>4)
    {
 
    }
  guide="f:iterate smoothing, I:show/hide IDs";
  //A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
  }
    
//====================================================================== PART 9
void showPart9(PNT A, PNT B, PNT C, PNT D) //    
  {
  PartTitle[9] =   "Smoothing while I draw";
  guide="Place. Press RMB to erase&start. Hold LMB & drag. Wait till all ducks arrive. Release.";
  PNT SmoothP = DucksRow.move(Mouse());
  if(mousePressed && (mouseButton == RIGHT))
    {
    DrawnPoints.empty(); 
    SmoothenedPoints.empty(); 
    DucksRow.init(Mouse());
    }
  if(mousePressed && (mouseButton == LEFT))
    {
    DrawnPoints.addPoint(Mouse()); 
    SmoothenedPoints.addPoint(SmoothP); 
    }
  cwF(orange,3); DrawnPoints.drawCurve();
  cwF(blue,5); SmoothenedPoints.drawCurve(); 
  DucksRow.showRow();
  //A.circledLabel("A"); B.circledLabel("B"); C.circledLabel("C"); D.circledLabel("D");
  }
  
  


    
//======================= called when a key is pressed
void myKeyPressed()
  {
  //int k = int(key); if(47<k && k<58) partShown=int(key)-48;
  if(key=='<') {DucksRow.decrementCount(); }
  if(key=='>') {DucksRow.incrementCount(); }
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
  if (!keyPressed) 
    {
    if(partShown==2 || partShown==3)
      {
      }
    }
  }
  
