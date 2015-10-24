# Smart Touch
Smart Touch is an easy to use Javascript- Touch- Libary.

Note: You could use it without jQuery.

# Install
`npm install smart-touch --save`

# Examples

## Use this code before every example
```javascript
var Touch = require('smart-touch');
var touch = new Touch()
var call = function(e) {
  console.log(e);
}
```

## Move two fingers from right edge (like Mac OS>Notifications)
```javascript
touch.on(document.body).fingers.eq(2).from.right().call(call);
```

## Move three fingers to Top (like Mac OS show Mission Control)
```javascript
touch.on(document.body).fingers.eq(3).move.toTop().call(call);
```

## Move one or more fingers from left edge (like windows switch Apps)
```javascript
touch.on(document.body).fingers.betweene(1,5).from.left().call(call);
```

# Documentation
**coming soon**
