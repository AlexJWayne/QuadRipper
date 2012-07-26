// Generated by CoffeeScript 1.3.1
(function() {

  THREE.Camera.prototype.screenToWorld = function(type, x, y) {
    var intersection, ray, vector, _base, _base1, _ref;
    (_base = this.screenToWorld).projector || (_base.projector = new THREE.Projector());
    (_base1 = this.screenToWorld).planes || (_base1.planes = {
      xy: this.screenToWorld.makePlane('xy'),
      xz: this.screenToWorld.makePlane('xz'),
      yz: this.screenToWorld.makePlane('yz')
    });
    vector = new THREE.Vector3((x / window.innerWidth) * 2 - 1, -(y / window.innerHeight) * 2 + 1, 0.5);
    this.screenToWorld.projector.unprojectVector(vector, this);
    ray = new THREE.Ray(this.position, vector.subSelf(this.position).normalize());
    intersection = ray.intersectObject(this.screenToWorld.planes[type]);
    return (_ref = intersection[0]) != null ? _ref.point : void 0;
  };

  THREE.Camera.prototype.screenToWorld.makePlane = function(axis) {
    var plane;
    plane = new THREE.Mesh(new THREE.PlaneGeometry(1000000, 1000000), new THREE.MeshNormalMaterial());
    plane.doubleSided = true;
    if (axis === 'xz') {
      plane.rotation.x += Math.PI / 2;
    }
    if (axis === 'yz') {
      plane.rotation.y += Math.PI / 2;
    }
    return plane;
  };

  THREE.Vector2.prototype.log = function() {
    return console.log("THREE.Vector2", this.x, this.y);
  };

  THREE.Vector3.prototype.log = function() {
    return console.log("THREE.Vector3", this.x, this.y, this.z);
  };

  THREE.Vector4.prototype.log = function() {
    return console.log("THREE.Vector4", this.x, this.y, this.z, this.w);
  };

}).call(this);
