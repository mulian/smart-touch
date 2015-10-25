# Smart Touch
Smart Touch is an easy to use Javascript- Touch- Libary.

[Changelog](https://github.com/mulian/smart-touch/blob/master/CHANGELOG.md)

Note: You could use it without jQuery.

# Install
* `cd <your_project_root_folder>`
* `npm install smart-touch --save`

# Examples

## Use this code before every example
Add to your HTML:
```html
<!-- will add touch globaly to window.touch -->
<script src='https://rawgit.com/mulian/smart-touch/master/dist/boundle.js' language='javascript' type='text/javascript' />
```
```javascript
// require('smart-touch'); //if you use browserify

var call = function(e) {
  console.log(e);
}
```

## Move two fingers from right edge (like Mac OS > show Notifications)
```javascript
touch.on().fingers.eq(2).from.right().call(call);
```

## Move three fingers to Top (like Mac OS show Mission Control)
```javascript
touch.on().fingers.eq(3).move.toTop().call(call);
```

## Move one or more fingers from left edge (like windows switch Apps)
```javascript
touch.on().fingers.betweene(1,5).from.left().call(call);
```
## Pinch in with four Fingers (like Mac OS > show Launchpad)
```javascript
touch.on().fingers.eq(4).pinch.in().call(call);
```

# Documentation

[HERE](https://github.com/mulian/smart-touch/blob/master/DOCUMENTATION.md)
