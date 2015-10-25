# Smart Touch
Smart Touch is an easy to use Javascript- Touch- Libary.

Note: You could use it without jQuery.

# Install
`npm install smart-touch --save`

# Examples

## Use this code before every example
```javascript
require('smart-touch'); // will add touch globaly to window.touch

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
**coming soon**
