class Game {
    
//---PROPERTIES---//

    //asset filepaths
    String playerSpriteSheetDirectory;
    String enemySpriteSheetDirectory;
    String bulletSpriteSheetDirectory;
    String birdSpriteSheetDirectory;
    String levelSpriteSheetDirectory;
    String effectSpriteSheetDirectory;
    
    //arrays
    PImage[] playerImages;
    PImage[] enemyImages;
    PImage[] levelImages;
    PImage[] effectImages;
    

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

        //create Ranged Enemy Object
        enemyImages = l.loadSpritesheets(playerSpriteSheetDirectory);
        enemyRanged = new EnemyRanged();

        

        //create Bullet Object
        bullet = new Bullet();

        //create Collision Object
        c = new CollisionDetector();
    }
    
    //called every frame on Draw()
    private void updateGame() {
        //update Level
        level.update();

        //update Player
        p.setHitBoxColour(0,0,255,50);
        p.update();

        //update Enemy
        enemy.setHitBoxColour(255,0,0,50);
        enemy.update();

        //update Enemy
        enemyRanged.setHitBoxColour(255,0,0,50);
        enemyRanged.update();
        bullet.update();

        //update Collision Detector
        c.getHit(bullet, p);
        c.getHit(p,enemy);
        c.getHit(p, enemyRanged);
    }
}
    
