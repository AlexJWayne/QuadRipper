Level.levels[1] =
  class Level1 extends Level
    start: ->

      @after i,  (=> @spawnEnemy Enemy.Blip) for i in [3..15]  by 3
      @after 10, (=> @spawnEnemy Enemy.Butter)
      @after i,  (=> @spawnEnemy Enemy.Blip) for i in [16..40] by 2
      @after 40, (=> @spawnEnemy Enemy.Butter)
      @after i,  (=> @spawnEnemy Enemy.Blip) for i in [41..50] by 1
      @after i,  (=> @spawnEnemy Enemy.Blip) for i in [51..60] by 0.35

      @after 61, => @winnable = yes
