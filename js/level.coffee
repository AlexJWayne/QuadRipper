class window.Level
  constructor: ->
    @winnable = no
    @timeouts = []

  start: ->

  spawnEnemy: (pos, vel) =>
    enemy = new Enemy()

    if pos
      enemy.position = pos.clone()
    else
      enemy.position.x += (Math.random()*2-1) * 30
      enemy.position.y += (Math.random()*2-1) * 30

    enemy.velocity = vel.clone() if vel

    scene.stage.enemies.push enemy
    scene.stage.mesh.add enemy
    enemy

  completed: ->
    @winnable and scene.stage.enemies.length is 0

  kill: ->
    clearTimeout timeout for timeout in @timeouts

  after: (seconds, fn) ->
    @timeouts.push(
      setTimeout =>
        fn.call this
      , seconds * 1000
    )

class window.Level1 extends Level
  start: ->
    @after i, @spawnEnemy for i in [3..15] by 3      
    @after i, @spawnEnemy for i in [16..40] by 2
    @after i, @spawnEnemy for i in [41..50] by 1
    @after i, @spawnEnemy for i in [51..60] by 0.35
    @after 60, => @winnable = yes


class window.Level2 extends Level
  train: (rate, time, speed = 35) ->
    forward    = Math.floor(Math.random()*2) is 0
    horizontal = Math.floor(Math.random()*2) is 0

    # Assume forward and horizontal (to the right)
    y = (Math.random()*2-1) * 75
    pos = new THREE.Vector3 -75, y, 0
    vel = new THREE.Vector3 speed, 0, 0

    if not horizontal
      [pos.x, pos.y] = [pos.y, pos.x]
      [vel.x, vel.y] = [vel.y, vel.x]

    if not forward
      pos.multiplyScalar -1
      vel.multiplyScalar -1

    for i in [0..time] by 1/rate
      @after i, => @spawnEnemy pos, vel


  start: ->
    @after 1,  => @train 3, 5, 20
    @after 6,  => @train 3, 5, 20
    @after 10, => @train 3, 4, 20
    
    @after 13, => @train 3, 3, 30
    @after 16, => @train 3, 3, 35
    @after 19, => @train 3, 3, 40
    @after 22, => @train 3, 3, 50
    
    @after 25, => @train 4, 2
    @after 28, => @train 4, 2
    @after 31, => @train 4, 2

    @after 33, => @train 12, 1, 25
    @after 35, => @train 12, 1, 25
    @after 37, => @train 12, 1, 25

    @after 38, => @winnable = yes


