class Game {
    
    //---PROPERTIES---//

    int screenBorder;
    
    //images
    ArrayList<PImage> playerImages;
    int totalImages;
    
    //asset filepaths
    String spriteSheetDirectory;
    String[] assetFolders;
    int numofassetfolders;
    
    
    //---CONSTRUCTOR---//

    Game() {
        //Set FilePaths
        spriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\MainCharacter\\";
        screenBorder = width - 7;
    }
    
    //---METHODS---//

    private void drawBorder() {
        fill(0, 255,0, 100);
        rect(3, 0, screenBorder, height);
    }
    
    //called once on Setup()
    private void loadGame() {
        loadSpritesheets(spriteSheetDirectory);
        
        //create Player
        p = new Player();
    }
    
    //called every frame on Draw()
    private void updateGame() {
        background(255);
        g.drawBorder();
        
        
        //update Player
        p.hitboxcolour(0,0,255,0);
        p.update();
        p.display();
    }
    
    private ArrayList<PImage> loadSpritesheets(String spriteSheetDirectory) {
        /*
        This method creates a dynamic Array List > searches a variable Directory and adds all files from any subfolders found to an Array of Images. 
        This Array will be referenced later to display animations for game elements.
        The frames inside each folder must have the same name as the folder they are in with the frame suffix. 
        Example:   In the Idle folder - "Idle00.png".
        In the Running folder - "Running00.png""
        */
        print("\nDirectory: ", spriteSheetDirectory);
        
        numofassetfolders = getnumoffiles(spriteSheetDirectory);
        assetFolders = getAssetFolders(spriteSheetDirectory);
        
        print("\nNumber of Asset Folders: ", numofassetfolders);
        for (int i = 0; i < numofassetfolders; i++) {
            print("\nAsset Folders: ", assetFolders[i]);
        }
        
        print("\n\nFile Manifest:");
        for (int i = 0; i < numofassetfolders; i++) {
            totalImages = totalImages + getnumoffiles(spriteSheetDirectory + assetFolders[i]);
            printlistoffilestoconsole(spriteSheetDirectory + assetFolders[i]);
        }
        
        print("\nTotal number of images: ",totalImages,"\n");
        
        playerImages = new ArrayList();
        for (int i = 0; i < numofassetfolders; i++) {
            print("\nFolder: ",assetFolders[i], "\nNumber of files to load:" + getnumoffiles(spriteSheetDirectory + assetFolders[i]));
            loadAssets(playerImages,spriteSheetDirectory + assetFolders[i], getnumoffiles(spriteSheetDirectory + assetFolders[i]));
        }
        
        print("\nImage Array: ");
        for (int i = 0; i < playerImages.size(); i++) {
            print("\n", "[",i,"]", playerImages.get(i));
        }
        return playerImages;
    }
    
    private ArrayList<PImage> loadAssets(ArrayList<PImage> array, String path, long numimagestoload) {
        
        path = path + "\\" + path.substring(path.lastIndexOf("\\") + 1);
        
        print("\nLOADING IMAGES\n");
        for (int i = 0; i < numimagestoload;i++) {
            {
                array.add(loadImage(path + nf(i,2) + ".png"));
                print(path + nf(i,2) + ".png\n");
            }
        }
        return array;
    }
    
    
    private int getnumoffiles(String pathtofolder)
        {
        String[] files;
        File f = new File(pathtofolder);
        files = f.list();
        
        return int(files.length);
    }
    
    private void printlistoffilestoconsole(String pathtofolder)
        {
        String[] files;
        File f = new File(pathtofolder);
        files = f.list();
        
        for (int i = 0;i < files.length; i++) {
            print("\n", files[i]);
        }
    }
    
    private String[] getAssetFolders(String pathtofolder)
        {
        String[] files;
        File f = new File(pathtofolder);
        files = f.list();
        return files;
    }
    
}
