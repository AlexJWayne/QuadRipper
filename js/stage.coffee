class window.Stage
  constructor: ->
    @mesh = new THREE.Mesh(
      new THREE.PlaneGeometry 200, 200
      new THREE.MeshNormalMaterial()
    )
    scene.add @mesh

    @crosshair = new Crosshair
    @mesh.add @crosshair

    @guns = Gun.create()
    @mesh.add gun for type, gun of @guns

    $(document.body).on 'mousemove', (e) =>
      pointerPos = scene.camera.screenToWorld('xy', e.clientX, e.clientY)
      @crosshair.updatePosition pointerPos
      
      for type, gun of @guns
        gun.updatePosition pointerPos
      
