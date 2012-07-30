# Convert from screen coordinates to world coordinates.
# Assumes a full screen canvas.
# `type` can be 'xy', 'xz' or 'yz' depending on which origin intersecting plane you want
# coordinated on.
THREE.Camera::screenToWorld = (type, x, y)->
  # generate some reusable objects
  @screenToWorld.projector ||= new THREE.Projector()
  @screenToWorld.planes ||=
    xy: @screenToWorld.makePlane('xy')
    xz: @screenToWorld.makePlane('xz')
    yz: @screenToWorld.makePlane('yz')

  # Check the desired world plane exists
  worldPlane = @screenToWorld.planes[type]
  throw "World plane type '#{type}' not supported. Try 'xy', 'xz' or 'yz'" unless worldPlane

  # Get a "screen" vector
  vector = new THREE.Vector3(
    (x / window.innerWidth) * 2 - 1,
    - (y / window.innerHeight) * 2 + 1,
    0.5
  )

  # Unproject the screen coordinate to world space
  @screenToWorld.projector.unprojectVector vector, this

  # Create a ray from the camera position to toward the projected point
  ray = new THREE.Ray @position, vector.subSelf(@position).normalize()

  # intersect with the desired point
  intersection = ray.intersectObject(@screenToWorld.planes[type])

  # return the world position of the itersection
  intersection[0]?.point

THREE.Camera::screenToWorld.makePlane = (axis) ->
  plane = new THREE.Mesh(
    new THREE.PlaneGeometry 1000000, 1000000
    new THREE.MeshNormalMaterial()
  )

  plane.doubleSided = yes
  plane.rotation.x += Math.PI/2 if axis is 'xz'
  plane.rotation.y += Math.PI/2 if axis is 'yz'

  plane



# Log a vector to the console
THREE.Vector2::log = -> console.log "THREE.Vector2", @x, @y
THREE.Vector3::log = -> console.log "THREE.Vector3", @x, @y, @z
THREE.Vector4::log = -> console.log "THREE.Vector4", @x, @y, @z, @w
