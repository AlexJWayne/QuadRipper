class window.Enemy extends THREE.Mesh
  size: 6
  speed: 15

  constructor: ->
    super(
      new THREE.CubeGeometry @size, @size, @size
      new THREE.MeshPhongMaterial color: 0xff0000
    )

    @velocity = new THREE.Vector3(Math.random() - 0.5, Math.random() - 0.5).setLength @speed
    @health = 3

    @rotVel = new THREE.Vector3(Math.random()-0.5, Math.random()-0.5, Math.random()-0.5).multiplyScalar 5

  update: ->
    @position.addSelf @velocity.clone().multiplyScalar(scene.stage.delta)
    @rotation.addSelf @rotVel.clone().multiplyScalar(scene.stage.delta)

    if @showHit
      @material.color = new THREE.Color 0xffffff
      @showHit = no
    else
      @material.color = new THREE.Color 0xff0000

    switch
      when @position.x > 100
        scene.stage.hit this
        @position.x = 100
        @velocity.x *= -1
      
      when @position.x < -100
        scene.stage.hit this
        @position.x = -100
        @velocity.x *= -1

      when @position.y > 100
        scene.stage.hit this
        @position.y = 100
        @velocity.y *= -1
      
      when @position.y < -100
        scene.stage.hit this
        @position.y = -100
        @velocity.y *= -1

  hit: (bullet) ->
    @health -= 1
    @expired = yes if @health <= 0
    @showHit = yes
