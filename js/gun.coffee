class window.Gun extends THREE.Mesh
  size: 15
  bounds: 100
  buffer: 12.5
  fireRate: 20

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

    @scale.x = 0.2 if @horizontal
    @scale.y = 0.2 if @vertical

  updatePosition: (pos) ->
    if @horizontal
      @position.x = pos.x
      @position.x =  @bounds if @position.x >  @bounds
      @position.x = -@bounds if @position.x < -@bounds
    
    if @vertical
      @position.y = pos.y if @vertical
      @position.y =  @bounds if @position.y >  @bounds
      @position.y = -@bounds if @position.y < -@bounds

  setActive: (active) ->
    return if @active == active
    @active = active
    
    if @active
      @fire()
      @firingInterval = accurateInterval 1/@fireRate*1000, => @fire()
    else
      @firingInterval?.cancel()

  fire: ->
    bulletStartPos = @position.clone()
    bulletStartPos.x =  110 if @type is 'right'
    bulletStartPos.x = -110 if @type is 'left'
    bulletStartPos.y =  110 if @type is 'top'
    bulletStartPos.y = -110 if @type is 'bottom'

    direction = new THREE.Vector3()
    direction.x =  1 if @type is 'left'
    direction.x = -1 if @type is 'right'
    direction.y =  1 if @type is 'bottom'
    direction.y = -1 if @type is 'top'

    scene.stage.bullets.push new Bullet(bulletStartPos, direction)

  update: ->