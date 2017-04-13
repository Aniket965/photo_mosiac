
PImage Org_mtg;
PImage small_mtg;
int scaleF = 4,w,h;
PImage[] allImages;
PImage[] brightImages;
float[] brightvalue;


void setup() 
  {
  
  
       size(950,540);
       Org_mtg = loadImage("1234.jpg");
        w = Org_mtg.width/scaleF;
        h = Org_mtg.height/scaleF;

       small_mtg = createImage(w,h,RGB);
       small_mtg.copy(Org_mtg,0,0,Org_mtg.width,Org_mtg.height,0,0,w,h);
       
       /*Load image from files*/
       File[] files = listFiles(sketchPath("data"));
       //printArray(files);
       allImages = new PImage[files.length];
       brightvalue = new float[allImages.length];
       brightImages = new PImage[256];
       for(int i = 0 ;i < allImages.length;i++) {
         
         String filename = files[i].toString();
         allImages[i] = loadImage(filename);
         allImages[i].loadPixels();
         float avg = 0;
         for(int j =0; j < allImages[i].pixels.length;j++) {
          float b = brightness(allImages[i].pixels[j]);
          avg +=b;
         }
         avg /= allImages[i].pixels.length;
             brightvalue[i] = avg ; 
       }

       /* find closes images in sense of brightness*/
       for(int i = 0 ; i< brightImages.length;i++) {
        float record = 256;
        for(int j = 0 ; j < allImages.length;j++) {      
        float diff = abs(i - brightvalue[j]);
        if(diff< record) {
          record = diff;
          brightImages[i] = allImages[j];
        }


        }
       
     }
 
       }
       
       
   
  

void draw()
  {
      //image(Org_mtg,0,0);
      //image(small_mtg,0,0);
      small_mtg.loadPixels();
      for(int x = 0 ; x < w ; x++ )
        {
          for(int y = 0 ; y < h ; y++ )
            {
              int index  = x + w*y;
              color c = small_mtg.pixels[index];
              //fill(c);
              //rect(x*scaleF,y*scaleF,scaleF,scaleF);
              //noStroke();
              int k = int(brightness(c));
              image(brightImages[k],x*scaleF,y*scaleF,scaleF,scaleF);
    
            }
        }
       saveFrame(); 
      noLoop();
  }
  
  
  
  
  
  
  
  
  
File[] listFiles(String dir)
  {
    File file = new File(dir);
    if (file.isDirectory()){
      File[] files = file.listFiles();
      return files;
    } else {
    return null;
    }
    
  }