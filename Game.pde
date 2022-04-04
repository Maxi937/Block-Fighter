class Game {
    
    //---PROPERTIES---//

    //asset filepaths
    String playerSpriteSheetDirectory;
    String enemySpriteSheetDirectory;
    String bulletSpriteSheetDirectory;
    String birdSpriteSheetDirectory;
    String levelSpriteSheetDirectory;
    
    //arrays
    PImage[] playerImages;
    PImage[] enemyImages;
    PImage[] levelImages;
    

    //---CONSTRUCTOR---//

    Game() {
        //Set FilePaths
        playerSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Player\\";
        enemySpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Enemy\\";
        bulletSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bullet\\";
        birdSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Bird\\";
        levelSpriteSheetDirectory = sketchPath() + "\\assets\\Spritesheets\\Level\\";

        playerImages = new PImage[0];
        enemyImages = new PImage[0];
    }
    
    //---METHODS---//
    
    //called once on Setup()
    private void loadGame() {

        //create Loader Object
        l = new Loader();

        //create Level Object
        levelImages = l.loadSpritesheets(levelSpriteSheetDirectory);
        level = new Level();

        //create Player Object
        playerImages = l.loadSpritesheets(playerSpriteSheetDirectory);
        p = new Player();

        //create Enemy Object
        enemyImages = l.loadSpritesheets(playerSpriteSheetDirectory);
        enemy = new Enemy();


    }
    
    //called every frame on Draw()
    private void updateGame() {
        //update Level
        level.display();

        //update Player
        p.hitboxcolour(0,0,255,50);
        p.update();
        p.display();

        //update Enemy
        enemy.hitboxcolour(255,0,0,50);
        enemy.update();
        enemy.display();
    }
}
    
