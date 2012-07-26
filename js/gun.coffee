class window.Gun extends THREE.Mesh
  size: 3
  bounds: 100
  buffer: 12

  @create: ->
    {
      top:    new Gun 'top'
      right:  new Gun 'right'
      bottom: new Gun 'bottom'
      left:   new Gun 'left'
    }

  constructor: (@type) ->
    super(
      new THREE.CubeGeometry @size, @size, @size
      new THREE.MeshPhongMaterial color: 0x0000ff
    )

    @horizontal = @type is 'top' or @type is 'bottom'
    @vertical   = !@horizontal

    @position.y =  100 + @buffer if @type is 'top'
    @position.x =  100 + @buffer if @type is 'right'
    @position.y = -100 - @buffer if @type is 'bottom'
    @position.x = -100 - @buffer if @type is 'left'

    @scale.y = 5 if @horizontal
    @scale.x = 5 if @vertical

  updatePosition: (pos) ->
    if @horizontal
      @position.x = pos.x
      @position.x =  @bounds if @position.x >  @bounds
      @position.x = -@bounds if @position.x < -@bounds
    
    if @vertical
      @position.y = pos.y if @vertical
      @position.y =  @bounds if @position.y >  @bounds
      @position.y = -@bounds if @position.y < -@bounds