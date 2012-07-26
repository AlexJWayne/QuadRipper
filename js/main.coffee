jQuery ($) ->
  abort = no
  
  # Shared objects
  stats = scene = renderer = camera = null
  
  # init the scene
  init = ->
    init.renderer()
    return if abort

    init.stats()
    init.camera()
    init.resize()

    init.stage()

  init.renderer = ->
    if Detector.webgl
      window.scene = scene = new THREE.Scene()

      scene.renderer = renderer = new THREE.WebGLRenderer antialias: true      
      renderer.setClearColorHex 0xBBBBBB, 1
      renderer.setSize window.innerWidth, window.innerHeight
      document.getElementById('container').appendChild renderer.domElement
      
    else
      Detector.addGetWebGLMessage()
      abort = true

  # add Stats.js - https://github.com/mrdoob/stats.js
  init.stats = ->
    stats = new Stats()
    stats.domElement.style.position = 'absolute'
    stats.domElement.style.bottom = '0px'
    document.body.appendChild stats.domElement

  # put a camera in the scene
  init.camera = ->
    scene.camera = camera = new THREE.PerspectiveCamera 50, window.innerWidth / window.innerHeight, 1, 10000
    camera.position.set 0, -75, 300
    camera.lookAt new THREE.Vector3(0, 0, 0)
    scene.add camera

    ambient = new THREE.AmbientLight 0xffffff, 0.25
    scene.add ambient

    # White directional light at half intensity shining from the top.
    directionalLight = new THREE.DirectionalLight 0xffffff, 1
    directionalLight.position.set -1, 1, 1
    scene.add directionalLight

  # transparently support window resize
  init.resize = -> THREEx.WindowResize.bind renderer, camera

  init.stage = ->
    scene.stage = new Stage()



  # animation loop
  animate = ->
    # loop on request animation loop
    # - it has to be at the begining of the function
    # - see details at http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating
    requestAnimationFrame animate

    # do the render
    render()

    # update stats
    stats.update()

  # render the scene
  render = -> renderer.render scene, camera
  
  # Bootup
  init()
  animate() unless abort
