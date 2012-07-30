class window.Wall extends THREE.Mesh
  constructor: (orientation) ->
    horizontal = orientation in ['top', 'bottom']

    xy = [10, 220, 15]
    [xy[0], xy[1]] = [xy[1], xy[0]] if horizontal

    super(
      new THREE.CubeGeometry(xy...)
      new THREE.MeshPhongMaterial(color: 0xaaaaaa)
    )

    @position.z = 2.5
    @position.y =  105 if orientation is 'top'
    @position.x =  105 if orientation is 'right'
    @position.y = -105 if orientation is 'bottom'
    @position.x = -105 if orientation is 'left'