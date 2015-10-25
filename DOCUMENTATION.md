# Documentation

## Create a condition
(You can create more than one condition.)

### .on() Function (is nacessary + always the first function)
```javascript
touch.on(DOMElement,ObtionsObject). ...
```

* First Parameter (DOM Element)

Contains a native DOM Element. (If you use jQuery pull the nativ DOM element from jQuery Obj. like [this](https://learn.jquery.com/using-jquery-core/faq/how-do-i-pull-a-native-dom-element-from-a-jquery-object/).)

If there is no parameter, it will be triggered on every DOM Element.

* Secound Parameter (Obtions Object)

There are two Boolean Values.
Default is `{eq:true,above:true}`.

|   eq    |   above    | Description                                |
| ------- | ---------- | ------------------------------------------ |
|  true   |   true     | Touch on Element or above (on dom branch). |
|  true   |   false    | Touch only on element.                     |
|  false  |   true     | Touch not on Element, but on above.        |
|  false  |   false    | Touch anywere not on and above.            |

### .fingers (is necessary)
It defines the Number of Finger to Trigger the call function.

`.fingers`
* `.eq(p)`
Fingers equals (#fingers==p).

* `.betweene(p1,p2)`
Fingers betweene (p1<=#finger<=p2).

### move
Move on Page.

The distance parameter defines the minimal action distance to Trigger the call function. Every distance parameter is default 50 (if undefined).

`.move`
* `.x(distance)`
Horizontal move

* `.y(distance)`
Vertical move

* `.toRight(distance)`
Move from left to Right.

* `.toLeft(distance)`
Move from right to Left.

* `.toTop(distance)`
Move from bottom to Top.

* `.toBottom(distance)`
Move from top to Bottom.

### .from
Add edge trigger conditions.

The distance defines the minimal distance to trigger from edge. Every distance parameter is default 50 (if undefined).

`.from`
* `.left(distance)`
* `.right(distance)`
* `.top(distance)`
* `.bottom(distance)`

### .pinch
For example: pinch to zoome.

The distance defines the minimal distance width betweene all fingers to call the Trigger function. Every distance parameter is default 50 (if undefined).

`.pinch`
* `.in(distance)`
* `.out(distance)`

### .call (is necessary)
The callback function is triggered when all the conditions accepted.

`.call(callback_function)`

The callback_function is passed the expanded event object.

## Expanded touch event
This object contains all normal [touch-event](https://developer.mozilla.org/en-US/docs/Web/API/TouchEvent) information. Plus some calculated smart-touch informations like:

* `avg `{Object}
Contains the calculated fingers-point average.
  * `x` {Number}
The avg. of `event.PageX.`
  * `y` {Number}
The avg. of `event.pageY`.
  * `elements` {DOMElement}
An array of all the DOM element that will be affected.
  * `pitch` {Number}
The max. distance betweene all Fingers.

Then there are also the difference to the first fingers touch.
  * `diff` {Object}
    * `x` {Number}
    * `y` {Number}
    * `pitch` {Number}

And smart-touch adds further an object with the directions (on body based). Like CSS definition.
* `direction`
  * `left`
  * `right`
  * `top`
  * `bottom`

## Inline Docu (Docco)
[Inline Docu](http://rawgit.com/mulian/smart-touch/master/docs/touch.html)
