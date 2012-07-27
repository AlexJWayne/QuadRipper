class window.Bullet extends THREE.Mesh
  size: 1.5
  speed: 350
  spread: 0.06

  constructor: (pos, direction)->
    super(
      new THREE.PlaneGeometry @size, @size
      new THREE.MeshBasicMaterial color: 0xffff00
    )
    scene.stage.mesh.add this

    @position = pos.clone()
    @position.z = 1

    spread = new THREE.Vector3 (Math.random()*2 - 1)*@spread, (Math.random()*2 - 1)*@spread
    @velocity = direction.normalize().addSelf(spread).multiplyScalar @speed

    scaleDistortion = @velocity.clone().normalize().multiplyScalar 3
    scaleDistortion.x = Math.abs(scaleDistortion.x)
    scaleDistortion.y = Math.abs(scaleDistortion.y)
    @scale.addSelf scaleDistortion

  update: ->
    @position.addSelf @velocity.clone().multiplyScalar(scene.stage.delta)

    if Math.abs(@position.x) > 110 or Math.abs(@position.y) > 110
      @expired = yes

    ray = new THREE.Ray @position.clone(), @velocity.clone().normalize()
    hits = ray.intersectObjects(scene.stage.enemies)

    hit = hits[0]
    if hit and hit.distance < @speed * scene.stage.delta
      hit.object.hit this
      @expired = yes
      