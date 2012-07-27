class window.Crosshair extends THREE.Mesh
  size: 4
  bounds: 100

  constructor: ->
    super(
      new THREE.PlaneGeometry @size, @size
      new THREE.MeshBasicMaterial color: 0xffffff
    )
    @position.z = 0.1
    @scale.z = 0.001

  updatePosition: (pos) ->
    @position.x = pos.x
    @position.y = pos.y

    @position.x =  @bounds if @position.x >  @bounds
    @position.x = -@bounds if @position.x < -@bounds

    @position.y =  @bounds if @position.y >  @bounds
    @position.y = -@bounds if @position.y < -@bounds

  update: ->