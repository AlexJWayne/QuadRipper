class Enemy.Blip extends Enemy
  health: 2

  constructor: ->
    super(
      new THREE.CubeGeometry @size, @size, @size
      new THREE.MeshPhongMaterial color: 0xff0000
    )

    @rotVel   = new THREE.Vector3(Math.random()-0.5, Math.random()-0.5, Math.random()-0.5).multiplyScalar 5

  update: ->
    super
    @rotation.addSelf @rotVel.clone().multiplyScalar(scene.stage.delta)