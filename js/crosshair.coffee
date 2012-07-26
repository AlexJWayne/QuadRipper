class window.Crosshair extends THREE.Mesh
  size: 3
  bounds: 100

  constructor: ->
    super(
      new THREE.SphereGeometry @size, 4, 24
      new THREE.MeshPhongMaterial color: 0xff0000
    )
    @position.z = @size/2
    @scale.z = 0.001

  updatePosition: (pos) ->
    @position.x = pos.x
    @position.y = pos.y

    @position.x =  @bounds if @position.x >  @bounds
    @position.x = -@bounds if @position.x < -@bounds

    @position.y =  @bounds if @position.y >  @bounds
    @position.y = -@bounds if @position.y < -@bounds
