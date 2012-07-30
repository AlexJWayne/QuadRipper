Level.levels[1] =
  class Level1 extends Level
    start: ->
      @after i, @spawnEnemy for i in [3..15] by 3      
      @after i, @spawnEnemy for i in [16..40] by 2
      @after i, @spawnEnemy for i in [41..50] by 1
      @after i, @spawnEnemy for i in [51..60] by 0.35
      @after 60, => @winnable = yes
