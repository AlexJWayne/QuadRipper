class window.Level
  @levels = []

  constructor: ->
    @winnable = no
    @timeouts = []

  start: ->

  spawnEnemy: (type, pos, vel) =>
    enemy = new type()

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
