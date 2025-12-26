# Interface Design Workflow Testing

An experiment to test a paper-sketch-to-implementation workflow between a human designer and Claude Code.

## The Experiment

**Goal:** Test whether hand-drawn UI sketches on paper can be effectively translated into working code by having Claude interpret the sketch, confirm understanding, and then implement.

**Workflow tested:**
1. Manager draws UI sketch on paper
2. Manager photographs and sends sketch to Claude
3. Claude summarizes the structure it sees (nested rows/columns in elm-ui terms)
4. Manager confirms or corrects the interpretation
5. Claude implements and deploys

## Result

**Extremely successful.** The sketch-to-implementation pipeline worked on the first attempt with no corrections needed.

The sketch showed:
- A header with profile pic and username (top right)
- A feed of items, each containing:
  - Profile pic (left)
  - Content area
  - 4 color buttons (bottom right) that change the feed item's background color

Claude correctly interpreted the nested row/column structure and implemented a working Elm + elm-ui app with interactive color-changing functionality.

## Tech Stack

- **Elm** with **elm-ui** for layout
- Deployed via simple `deploy.sh` script with cache-busting

## Files

- `src/Main.elm` - The Elm application
- `deploy.sh` - Build and deploy script
- `sketch.jpg` - The original hand-drawn sketch (TODO: add)
