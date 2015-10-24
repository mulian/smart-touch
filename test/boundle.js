(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
Array.prototype.inArray = function(item) {
  var aItem, i, len;
  if (this.compare != null) {
    for (i = 0, len = this.length; i < len; i++) {
      aItem = this[i];
      if (this.compare(item, aItem)) {
        return true;
      }
    }
  } else {
    console.log("ERROR: There is no Array.compare(a,b) Function.");
  }
  return false;
};

Array.prototype.pushIfNotExist = function(item) {
  if (!this.inArray(item)) {
    return this.push(item);
  }
  return false;
};


},{}],2:[function(require,module,exports){
var TouchCheckConditions;

module.exports = TouchCheckConditions = (function() {
  function TouchCheckConditions(setCall, conditions) {
    this.setCall = setCall;
    this.conditions = conditions;
  }

  TouchCheckConditions.prototype.resetConditions = function() {
    var con, i, len, ref, results;
    ref = this.conditions;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      con = ref[i];
      results.push(con.checkBit = null);
    }
    return results;
  };

  TouchCheckConditions.prototype.allConditionsCheck = function(e) {
    var con, i, len, ref, results;
    ref = this.conditions;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      con = ref[i];
      results.push(this.checkStartConditions(con, e));
    }
    return results;
  };

  TouchCheckConditions.prototype.checkStartConditions = function(con, e) {
    var obj;
    con.checkBit = true;
    obj = con.conditions['touchstart'];
    if (con.checkBit) {
      con.checkBit = this.checkElement(con, e);
    }
    if (con.checkBit && (obj.move != null)) {
      con.checkBit = this.checkMove(con, e);
    }
    if (con.checkBit && (obj.fingers != null)) {
      con.checkBit = this.checkFingers(con, e);
    }
    if (con.checkBit && (obj.from != null)) {
      con.checkBit = this.checkFrom(con, e);
    }
    if (con.checkBit) {
      if (con.checkBit) {
        return this.setCall(con.callback);
      }
    }
  };

  TouchCheckConditions.prototype.checkFrom = function(con, e) {
    var from;
    from = con.conditions['touchstart'].from;
    if (((from.left != null) && e.avg.diff.x > 0 && e.direction.left < from.left) || ((from.right != null) && e.avg.diff.x < 0 && e.direction.right < from.right) || ((from.top != null) && e.avg.diff.y > 0 && e.direction.top < from.top) || ((from.bottom != null) && e.avg.diff.y < 0 && e.direction.bottom < from.bottom)) {
      return true;
    }
    return false;
  };

  TouchCheckConditions.prototype.checkMove = function(con, e) {
    var move, ref, ref1, ref2, ref3;
    move = con.conditions['touchstart'].move;
    if (((move.x != null) && !(((move.x * -1) < (ref = e.avg.diff.x) && ref < move.x)) && (((move.x * -1) < (ref1 = e.avg.diff.y) && ref1 < move.x))) || ((move.y != null) && !(((move.y * -1) < (ref2 = e.avg.diff.y) && ref2 < move.y)) && (((move.y * -1) < (ref3 = e.avg.diff.x) && ref3 < move.y))) || ((move.toLeft != null) && (move.toLeft < (e.avg.diff.x * -1))) || ((move.toRight != null) && e.avg.diff.x > move.toRight) || ((move.toBottom != null) && e.avg.diff.y > move.toBottom) || ((move.toTop != null) && (e.avg.diff.y * -1) > move.toTop)) {
      return true;
    }
    return false;
  };

  TouchCheckConditions.prototype.checkElement = function(con, e) {
    var check, elements, elmt, isAbove, isIn, ref, tmpElmt;
    check = false;
    elmt = con.element;
    elements = e.avg.elements;
    isIn = elements.inArray(elmt.el);
    if ((elmt.eq === isIn && isIn === true)) {
      return true;
    }
    isAbove = false;
    if (!isIn) {
      tmpElmt = elmt.el;
      while (!tmpElmt.isEqualNode(document.body)) {
        tmpElmt = tmpElmt.parentNode;
        if (elements.inArray(tmpElmt)) {
          isAbove = true;
          break;
        }
      }
    }
    if ((elmt.above === isAbove && isAbove === true)) {
      return true;
    }
    if ((((elmt.above === isAbove && isAbove === isIn) && isIn === (ref = elmt.eq)) && ref === false)) {
      return true;
    }
    return false;
  };

  TouchCheckConditions.prototype.checkFingers = function(con, e) {
    var fingerCount, fingers;
    fingers = con.conditions['touchstart'].fingers;
    fingerCount = e.touches.length;
    if (fingers.betweene != null) {
      if (!(fingerCount >= fingers.from && fingerCount <= fingers.to)) {
        return false;
      }
    } else if (fingers.equals != null) {
      if (fingerCount !== fingers.eq) {
        return false;
      }
    }
    return true;
  };

  return TouchCheckConditions;

})();


},{}],3:[function(require,module,exports){
var TouchConditions;

module.exports = TouchConditions = (function() {
  TouchConditions.prototype._initConditions = function() {
    return this.conditions = {
      touchstart: {},
      touchmove: {},
      touchend: {}
    };
  };

  TouchConditions.prototype._getCondition = function() {
    return this.conditions[this.timing];
  };

  TouchConditions.prototype._addCondition = function(attr, value) {
    return this._getCondition()[attr] = value;
  };

  function TouchConditions() {
    this._initConditions();
    this.onStart();
    this.fingers.head = this;
    this.move.head = this;
    this.from.head = this;
    return this;
  }

  TouchConditions.prototype.call = function(callback) {
    this.callback = callback;
    return this;
  };

  TouchConditions.prototype.onStart = function() {
    this.timing = 'touchstart';
    return this;
  };

  TouchConditions.prototype.element = {
    eq: true,
    above: true,
    el: null
  };

  TouchConditions.prototype.from = {
    left: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('from', {
        left: distance
      });
      return this.head;
    },
    right: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('from', {
        right: distance
      });
      return this.head;
    },
    top: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('from', {
        top: distance
      });
      return this.head;
    },
    bottom: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('from', {
        bottom: distance
      });
      return this.head;
    }
  };

  TouchConditions.prototype.move = {
    x: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('move', {
        x: distance
      });
      return this.head;
    },
    y: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('move', {
        y: distance
      });
      return this.head;
    },
    toRight: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('move', {
        toRight: distance
      });
      return this.head;
    },
    toLeft: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('move', {
        toLeft: distance
      });
      return this.head;
    },
    toTop: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('move', {
        toTop: distance
      });
      return this.head;
    },
    toBottom: function(distance) {
      if (distance == null) {
        distance = 50;
      }
      this.head._addCondition('move', {
        toBottom: distance
      });
      return this.head;
    }
  };

  TouchConditions.prototype.fingers = {
    betweene: function(from, to) {
      this.head._addCondition('fingers', {
        from: from,
        to: to,
        betweene: true
      });
      return this.head;
    },
    eq: function(eq) {
      this.head._addCondition('fingers', {
        eq: eq,
        equals: true
      });
      return this.head;
    }
  };

  return TouchConditions;

})();


},{}],4:[function(require,module,exports){
var TouchEvent,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

module.exports = TouchEvent = (function() {
  function TouchEvent(callBack) {
    this.callBack = callBack;
    this.touch = bind(this.touch, this);
    this.init = bind(this.init, this);
    this.documentReady(this.init);
  }

  TouchEvent.prototype.documentReady = function(callback) {
    return document.addEventListener("DOMContentLoaded", function() {
      document.removeEventListener("DOMContentLoaded", arguments.callee, false);
      return callback();
    }, false);
  };

  TouchEvent.prototype.init = function() {
    document.body.addEventListener('touchstart', this.touch);
    document.body.addEventListener('touchmove', this.touch);
    document.body.addEventListener('touchend', this.touch);
    return document.body.addEventListener('touchcancel', this.touch);
  };

  TouchEvent.prototype.touch = function(e) {
    if (e.type === 'touchstart' && this._lastEnd && this._touchStartCound === 0) {
      this._firstEvent = e;
    }
    this._addCurrentTarget(e);
    this._addAverage(e);
    return this._checkHomeStretch(e);
  };

  TouchEvent.prototype._lastEnd = true;

  TouchEvent.prototype._touchStartTimeout = null;

  TouchEvent.prototype._touchStartCound = 0;

  TouchEvent.prototype._checkHomeStretch = function(e) {
    if (e.type === 'touchend' && e.touches.length === 0) {
      e.end = true;
      this._lastEnd = true;
      return this.callBack(e);
    } else if (e.type === 'touchmove' && this._lastEnd && this._touchStartCound < 10) {
      this._touchStartCound++;
      if (this._touchStartTimeout !== null) {
        clearTimeout(this._touchStartTimeout);
      }
      return this._touchStartTimeout = setTimeout((function(_this) {
        return function() {
          e.startFingers = e.touches.length;
          e.start = true;
          _this._touchStartCound = 0;
          _this._lastEnd = false;
          return _this.callBack(e);
        };
      })(this), 15);
    } else {
      return this.callBack(e);
    }
  };

  TouchEvent.prototype._addCurrentTarget = function(e) {
    var i, len, ref, results, touch;
    if (e.touches.length > 0) {
      ref = e.touches;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        touch = ref[i];
        results.push(touch.element = document.elementFromPoint(touch.clientX, touch.clientY));
      }
      return results;
    }
  };

  TouchEvent.prototype._addAverage = function(e) {
    var elements, i, len, ref, touch, x, y;
    if (e.touches.length > 0) {
      elements = [];
      elements.compare = function(a, b) {
        if (a.isEqualNode(b)) {
          return true;
        }
        return false;
      };
      x = 0;
      y = 0;
      ref = e.touches;
      for (i = 0, len = ref.length; i < len; i++) {
        touch = ref[i];
        x += touch.pageX;
        y += touch.pageY;
        elements.pushIfNotExist(touch.element);
      }
      e.avg = {
        x: x / e.touches.length,
        y: y / e.touches.length,
        elements: elements
      };
      this._addAverageDiff(e);
      return this._addDirections(e);
    }
  };

  TouchEvent.prototype._addAverageDiff = function(e) {
    return e.avg.diff = {
      x: e.avg.x - this._firstEvent.avg.x,
      y: e.avg.y - this._firstEvent.avg.y
    };
  };

  TouchEvent.prototype._addDirections = function(e) {
    return e.direction = {
      left: e.avg.x,
      top: e.avg.y,
      right: window.innerWidth - e.avg.x,
      bottom: window.innerHeight - e.avg.y
    };
  };

  return TouchEvent;

})();


},{}],5:[function(require,module,exports){
var Touch, TouchCheckConditions, TouchConditions, TouchEvent,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

TouchEvent = require('./touch-event');

TouchConditions = require('./touch-conditions');

TouchCheckConditions = require('./touch-check-conditions');

require('./fortify-array');

module.exports = Touch = (function() {
  Touch.prototype.conditions = [];

  function Touch() {
    this.trigger = bind(this.trigger, this);
    this.setCall = bind(this.setCall, this);
    this.touchEvent = new TouchEvent(this.trigger);
    this.check = new TouchCheckConditions(this.setCall, this.conditions);
  }

  Touch.prototype.setCall = function(call) {
    this.call = call;
  };

  Touch.prototype.call = null;

  Touch.prototype.trigger = function(e) {
    e.preventDefault();
    if (this.call === null && e.start) {
      this.check.allConditionsCheck(e);
    }
    if (this.call !== null) {
      this.call(e);
    }
    if (e.end) {
      this.call = null;
      return this.check.resetConditions();
    }
  };

  Touch.prototype.newCondition = function() {
    var con;
    con = new TouchConditions();
    this.conditions.push(con);
    return con;
  };

  Touch.prototype.on = function(element, options) {
    var con, name, val;
    con = this.newCondition();
    if (options != null) {
      for (name in options) {
        val = options[name];
        con.element[name] = val;
      }
    }
    con.element.el = element;
    return con;
  };

  return Touch;

})();

window.touch = new Touch();


},{"./fortify-array":1,"./touch-check-conditions":2,"./touch-conditions":3,"./touch-event":4}]},{},[5])


//# sourceMappingURL=boundle.js.map
