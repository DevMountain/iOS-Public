<img src="https://s3.amazonaws.com/devmountain/readme-logo.png" width="250" align="right">

# Deck of One C

## Summary 

## Overview

### Step 1 - Understand the RESTful API, Models


### Step 2 - Controller

### Step 3 - User Interface / Bridging Swift and Objective-C

## Part 1 - Understanding the JSON and Creating Models

### JSON 

Go to `http://deckofcardsapi.com/` and read over the documentation for drawing a single card. 

1. Once you've found the correct endpoint to acheieve the goal of our app, start analyzing the JSON, and start mapping out what types are needed to parse this into our model object.

    <Details>
        <summary> Code Hint </summary>

    ```json
    { // <--- Top Level
    "remaining": 51,
    "cards": [ // <--- Array of cards, we only want the first
        {
        "suit": "DIAMONDS",
        "value": "2",
        "code": "2D",
        "images": {
            "svg": "https://deckofcardsapi.com/static/img/2D.svg",
            "png": "https://deckofcardsapi.com/static/img/2D.png"
        },
        "image": "https://deckofcardsapi.com/static/img/2D.png" // <--- This is what we're after
        }
    ]
    } 
    ```
    </Details>


* Note: Codable does not work in ObjectiveC, therefore we will be using `NSJSONSerialization` to parse this into our model object 

### Model





## Part 2 - Writing the Model Controller

### Model Controller 

### Draw Card method

### Fetch Image method

## Part 3 - Bridging Swift and Objective C

### Add Bridging File 


### User Interface
 
## Copyright

© DevMountain LLC, 2017. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.

<p align="center">
<img src="https://s3.amazonaws.com/devmountain/readme-logo.png" width="250">
</p>