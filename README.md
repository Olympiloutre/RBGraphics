Overview
============
This Pod contains severa custom outlets extensions, which will mostly be IBDesignable so it can be use directly in interface builder. 

_Written in Swift_

## Installation 

You can simply clone the repo and paste it directly onto your XCode project, or either use cocoapod.


## Usage

#### ProgressButton

__ProgressButton__ is a subclass of UIView which has 3 states 
1. .start - which represent a dowbnloading arrow 
2. .progress - which displays an arc with grow according to progression 
3. .done - a validation sigil

It's mainly designed to display a downloading. 

Add an ```UIView``` in your storyboard and set it's class to ```ProgressButton```. Then link it to your ViewController. 

You can control the ```state``` property to switch between view : 
```swift
MyProgressButton.state = .start 
MyProgressButton.state = .progress 
MyProgressButton.state = .done 
```

The ```.progress``` state is bound to ```percent``` variable which can be updated at anytime : 
```swift
MyProgressButton.percent = 0.9
```

When editing one of these parameters, the ProgressButton will redraw automatically.

Finally, you can set an action when user clicks on the button while state equals ```start``` : 
```swift
MyProgressButton.downloadAction = {
  self.beginDownload()
  MyProgressButton.state = .progress
}
```


## Todo
- Add more and more Custom objects 
- Insert gifs inside this spec 
- Developp specs' installation part 


## About
Romuald Brochard 
This is my first attempt to share my work, if you see any improvement please tell me, it will help me to get better. 
Still it's a bit empty for now, but I'll share more outlets soon _( if my laptop survive this winter )_
