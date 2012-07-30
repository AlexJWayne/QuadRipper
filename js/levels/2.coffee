Level.levels[2] =
  class Level2 extends Level
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


