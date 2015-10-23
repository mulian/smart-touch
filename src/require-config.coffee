require.config {} =
  touch: './touch.js'
  'touch-conditions': './touch-conditions.js'
  'touch-event': './touch-event.js'
  'touch-check-conditions': './touch-check-conditions.js'
  shim: {} =
    touch:
      deps: ['touch-conditions','touch-event','touch-check-conditions']
