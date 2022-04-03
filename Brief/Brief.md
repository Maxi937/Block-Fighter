# Brief

In your second assignment, you are asked to write code to produce a game of your choice with user interaction of your choice in Processing (Java).

The game must include collision detection or collision avoidance between ** at least 2 objects** created from class files that you create and define (similar to Paddle and Ball in the game of Pong that we studied).

The aim of the assignment is for you to demonstrate your understanding of all the structures seen so far. Specifically, you are asked to include the following:

- At least two user-defined Classes, adhering to encapsulation rules, complete with:
  - fields
  - constructors
  - getters
  - setters
  - Other methods (private member methods)
  
- The usual Processing classes containing the draw(), setup(), etc. This class must use your    user-defined class(es) in an appropriate manner.

- Use of selection (if) and iteration (loops).

- Use of primitive arrays.

- Use of object arrays.

The assignment is primarily based on everything covered in the first 6 weeks. Methods, Classes, Arrays, Games, (Collision detection/avoidance), Event handling.

## Complexity

The complexity of the entire code is important, i.e. the more complex the code, the more marks you will achieve. (see marking scheme).

The Pong game v8 that we covered in lectures and labs is an example of excellent marks for complexity.

## A Suggestion
Pong has many elements common to most games. Build your own unique game. You cannot submit Pong!

You must include specific references to games, books, or websites that influence your assignment.

When submitting it is important that you explicitly highlight how you've met each part of the spec in the reflection.

Writing code that is not part of the game just to satisfy the rubric will not be counted for marks.

# Constraints

## Not Allowed

- Handing up the game of Pong (we've already given you the solution)
- 3d Renderers
- Java Collections
  - Arraylists
  - Stacks
  - Queues
  - IntList
- PVector
- Matrix
  - push
  - pop
- Texture()
- Output to the console is not considered for marks purposes
- Do not use WAV files or AIF files (too big)
- Materials
- Enums
- Try/catch
- Super
- Extends

## Allowed

- Old games (but must be customised)
- keyPressed()
- keyCode
- Arrays
  - arrayCopy()
  - multiple arrays
  - multi-dimensional arrays
- if you want to use sounds, that’s fine. Not required at all. mp3 files ok but make sure you store the required files within the folder you are zipping up to handup * free sounds available from:
    - ccmixter.org
    - freesound.org (edited)
- second()
- millis()
- noise()
- PImage
- loadImage() but make sure you store the required files within the folder you are zipping up to handup
- loadFont() but make sure you store the required files within the folder you are zipping up to handup
- beginShape()
- endShape()
- PShape
- vertex() - but only for 2D
- for each loop
- reusing code from Pong e.g. Player Class.
- dist()
- String objects
- JOptionPane
- Arrays
- Scoring
- Anything explicitly ruled IN, in previous assignments
- translate()
- map()
- rotate()
- trigonmentry methods

# Marking Scheme

There are two components to your overall mark:

- Structure of code
- Complexity of code
  
Please read below regarding interviews.

## Structure of Code

### Summary

| %   | Part        |
| --- | ----------- |
| 20% | Parts A,B,C |
| 30% | Part D      |
| 30% | Part E      |
| 20% | Part F      |



| Part | Description                                                                                       | Marks |
| ---- | ------------------------------------------------------------------------------------------------- | ----- |
| A1   | Inclusion of completed Readme                                                                     | (1)   |
| A2   | Inclusion of completed Reflection                                                                 | (5)   |
| A3   | Inclusion of completed Video structured as specified                                              | (5)   |
| B1   | Comments                                                                                          | (1)   |
| B2   | indentation                                                                                       | (1)   |
| B3   | naming                                                                                            | (1)   |
| B4   | structure of code                                                                                 | (1)   |
| C    | Use of standard programming control contructs (if, loop, nesting)                                 | (5)   |
| D1   | Working game                                                                                      | (10)  |
| D2   | Handling Key Events                                                                               | (10)  |
| D3   | Collision Detection/avoidance                                                                     | (10)  |
| E    | **User-defined class (at least two excluding Player class from Pong)**                            |
| E1   | Class Definitions - appropriate fields, constructors, getters, setters, overloading               | (10)  |
| E2   | Class bespoke methods (i.e. help methods) (no return value, return value, parameters, overloaded) | (10)  |
| E3   | How you have USED the classes by creating obkect variables / object arrays in the main program.   | (10)  |
| F    | **Data structure:**                                                                               |
| F1   | Use of arrays (primitive/object) to store information i.e. array                                  | (10)  |
| F2   | Calculations performed on the information stored (e.g. min,max,average, find, detectCollision)    | (10)  |


# Video 

You must include a video (screen recording) [min 3 mins, max 10 mins] to present your assignment. Allow 5 hours for this. The video must include audio voice narration by you (microphone).

There are many software programs that enable you to record the desktop as a video:

- Zoom
- Apple Quicktime
- OBS (free open source)
- Screencast-o-matic
- Loom
- Camtasia (PC)
- ScreenFlow (Mac)
- SnagIt
- Jing
- ShareX

You will need to upload your video to YouTube as unlisted. Use your student number to login to YouTube. Copy the URL and include in the reflection where shown.

**WARNING:** Allow plenty of time to do your Reflection, make your video, and upload it to YouTube especially if you're broadband is slow.

## Structure of Video

| Part             | Description                                                                                                                                                                         | Duration    |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| Intro            | Describing the game                                                                                                                                                                 | (<0.5 min)  |
| Demo             | Showing the game running highlighting all the features that you want considered for marking.                                                                                        | (<3 mins)   |
| Code Walkthrough | Highlight the key/most important classes/methods/elements in your code to demonstrate your understanding of the work being presented. If parts are not working highlight them also. | (<6.5 mins) |