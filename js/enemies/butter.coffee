class Enemy.Butter extends Enemy
  size: 15
  health: 6
  speed: 15

  constructor: ->
    super(
      new THREE.CubeGeometry @size, @size, 3
      new THREE.MeshPhongMaterial color: 0xff0000
    )

    @shields = {
      top:    new Shield 0
      left:   new Shield Math.TAU * 0.25
      bottom: new Shield Math.TAU * 0.5
      right:  new Shield Math.TAU * 0.75
    }
    @add shield for type, shield of @shields

    @velocity = new THREE.Vector3()
    @turn()

  turn: (direction) ->
    shield.active = yes for type, shield of @shields

    @direction = direction || ['top', 'right', 'bottom', 'left'][Math.floor(Math.random()*4)]
    switch @direction
      when 'top'
        @shields.bottom.active = no
        @velocity.set 0, @speed, 0
      when 'right'
        @shields.left.active = no
        @velocity.set  @speed, 0, 0
      when 'bottom'
        @shields.top.active = no
        @velocity.set 0, -@speed, 0
      when 'left'
        @shields.right.active = no
        @velocity.set -@speed, 0, 0

  update: ->
    super
    shield.update() for type, shield of @shields

  hit: (bullet) ->
    unless @shields[bullet.direction].active
      super

    @turn bullet.direction


class Shield extends THREE.Mesh
  constructor: (angle) ->
    super(
      new THREE.CubeGeometry Enemy.Butter::size * .8, 1.5, 0.5
      new THREE.MeshPhongMaterial color: 0xff8888
    )
    @position.y = Enemy.Butter::size/2 + 1.5

    @position.rotateZ angle
    @rotation.z = angle
    @active = yes

  update: ->
    @material.opacity = if @active then 1 else 0