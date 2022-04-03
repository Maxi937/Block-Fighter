import java.io.*;

Player p;

//images
ArrayList<PImage> playerImages;
int totalImages;

//asset filepaths
String filepathSpriteSheets;
String[] assetFolders;
int numofassetfolders;


void setup() {
    size(800, 600);
    background(255);

    filepathSpriteSheets = sketchPath() + "\\assets\\Spritesheets\\";
    loadSpritesheets(filepathSpriteSheets);

    p = new Player();
}

void draw() {
    background(255);
    p.hitboxcolour(0,0,255,0);
    p.display();
    
    if (keyPressed) {
        if(key == 'D'){
            p.debugdisplayspritesheet(playerImages.size()-1);
        }
    }
    
}

ArrayList<PImage> loadSpritesheets(String directory){
  /*
  This method creates a dynamic Array List > searches a variable Directory and adds all
  files from any subfolders found to an Array of Images. 
  This Array will be reference later to display animations for game elements.
  The frames inside each folder must have the same name as the folder they are in with the frame suffix. 
  Example:   In the Idle folder - "Idle00.png".
             In the Running folder - "Running00.png""
  */
  
    numofassetfolders = getnumoffiles(directory);
    assetFolders = getAssetFolders(directory);

    print("\nNumber of Asset Folders: ", numofassetfolders);
        for (int i = 0; i < numofassetfolders; i++){
            print("\nAsset Folders: ", assetFolders[i]);
        }
    
    print("\nFile Manifest:");
    for (int i = 0; i < numofassetfolders; i++){
        totalImages =+ getnumoffiles(directory + assetFolders[i]);
        printlistoffilestoconsole(directory + assetFolders[i]);
    }

    print("\nTotal number of images: ",totalImages + numofassetfolders,"\n");

    playerImages = new ArrayList();
        for (int i = 0; i < numofassetfolders; i++){
            print ("\nNumber of files to load:" + getnumoffiles(directory + assetFolders[i]));
            loadAssets(playerImages, directory + assetFolders[i], getnumoffiles(filepathSpriteSheets + assetFolders[i]));
        }

        print ("\nImage Array: ");
        for (int i = 0; i < totalImages + numofassetfolders; i++){
            print ("\n", playerImages.get(i));
        }
    return playerImages;
}
    

ArrayList<PImage> loadAssets(ArrayList<PImage> array, String path, long numimagestoload) {

    path = path + "\\" + path.substring(path.lastIndexOf("\\") + 1);

    print("\nLOADING IMAGES\n");
    for(int i = 0; i < numimagestoload;i++){
         {
            array.add(loadImage(path + nf(i,2) + ".png")) ;
            print(path + nf(i,2) + ".png\n");
        }
    }
    return array;
}


int getnumoffiles(String pathtofolder)
{
    String[] files;
    File f = new File(pathtofolder);
    files = f.list();

    return int(files.length);
}

void printlistoffilestoconsole(String pathtofolder)
{
    String[] files;
    File f = new File(pathtofolder);
    files = f.list();

    for(int i =0;i < files.length; i++){
        print("\n", files[i]);
    }
}

String[] getAssetFolders(String pathtofolder)
{
    String[] files;
    File f = new File(pathtofolder);
    files = f.list();
    return files;
}
