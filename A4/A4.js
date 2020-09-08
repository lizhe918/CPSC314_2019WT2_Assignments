/*
 * UBC CPSC 314, Vjan2019
 * Assignment 4 Template
 */

// CHECK WEBGL VERSION
if ( WEBGL.isWebGL2Available() === false ) {
  document.body.appendChild( WEBGL.getWebGL2ErrorMessage() );
}

// Setup renderer
var container = document.createElement( 'div' );
document.body.appendChild( container );

var canvas = document.createElement("canvas");
var context = canvas.getContext( 'webgl2' );
var renderer = new THREE.WebGLRenderer( { canvas: canvas, context: context } );
renderer.setClearColor(0X808080); // background colour
renderer.shadowMap.enabled = true;
container.appendChild( renderer.domElement );

// Adapt backbuffer to window size
function resize() {
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
}

// Hook up to event listener
window.addEventListener('resize', resize);

// Disable scrollbar function
window.onscroll = function() {
  window.scrollTo(0, 0);
}

// Add scene
var scene = new THREE.Scene(); // display scene

// XYZ axis helper
var worldFrame = new THREE.AxesHelper(2);
scene.add(worldFrame);

// Light(s)
var light = new THREE.DirectionalLight( 0xffffff, 1 );
light.position.set(20.0,20.0,20.0);
light.target = worldFrame;
// Q5 : This light source casts the shadows, set up this light source as the shadow camera
// to be used for shadow mapping
// WRITE YOUR CODE HERE
// Q5 Answer
// Learnt from HelloWorld3.js: we need to let the light cast shadow and zoom the camera to an appropriate extent.
light.castShadow = true;
light.shadow.camera.zoom = 0.5;
scene.add( light );

var lightDirection = new THREE.Vector3();
lightDirection.copy(light.position);
lightDirection.sub(light.target.position);
// Q5 : adjust the view frustum for the shadow camera to include the entire shadow of shay D Pixel, 
// without being too large. Experiement with a few different values.
// WRITE YOUR CODE HERE
// TODO: dont understand the requirement

// Q5 : Optional, but you can visualise the light and the frustum of the shadow camera to debug shadow mapping
// uncomment the lines below
// const lightHelper = new THREE.CameraHelper(light.shadow.camera);
// scene.add(lightHelper);

// Main camera
var camera = new THREE.PerspectiveCamera(40, 1, 0.1, 1000); // view angle, aspect ratio, near, far
camera.position.set(0,15,30);
camera.lookAt(scene.position);
scene.add(camera);

// Camera controls
cameraControl = new THREE.OrbitControls(camera);
cameraControl.damping = 0.2;
cameraControl.autoRotate = false;

// load floor textures
var floorColorTexture = new THREE.TextureLoader().load('images/color.jpg');
floorColorTexture.minFilter = THREE.LinearFilter;
floorColorTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();
var floorNormalTexture = new THREE.TextureLoader().load('images/normal.png');
floorNormalTexture.minFilter = THREE.LinearFilter;
floorNormalTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();
var floorAOTexture = new THREE.TextureLoader().load('images/ambient_occlusion.png');
floorAOTexture.minFilter = THREE.LinearFilter;
floorAOTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();

//load wizard textures
var wizardColorTexture = new THREE.TextureLoader().load( 'images/Pixel_Model_BaseColor.jpg' );
wizardColorTexture.minFilter = THREE.LinearFilter;
wizardColorTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();
var wizardNormalTexture = new THREE.TextureLoader().load('images/Pixel_Model_Normal.jpg');
wizardNormalTexture.minFilter = THREE.LinearFilter;
wizardNormalTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();

// Uniforms
var cameraPositionUniform = {type: "v3", value: camera.position};
var lightColorUniform = {type: "c", value: new THREE.Vector3(1.0, 1.0, 1.0)};
var ambientColorUniform = {type: "c", value: new THREE.Vector3(1.0, 1.0, 1.0)};
var lightDirectionUniform = {type: "v3", value: lightDirection};
var kAmbientUniform = {type: "f", value: 0.1};
var kDiffuseUniform = {type: "f", value: 0.8};
var kSpecularUniform = {type: "f", value: 0.4};
var shininessUniform = {type: "f", value: 50.0};
var lightPositionUniform = { type: "v3", value: light.position};


// YOUR WORK STARTS BELOW 

// load the skybox textures
var skyboxCubemap = new THREE.CubeTextureLoader()
    // Q3 Answer
    // Load images in the correct sequence.
  .setPath( 'images/cubemap/' )
  .load( [
    // Q3 : Load the images for the sides of the cubemap here. Note that order is important
      "cube1.png",
      "cube2.png",
      "cube3.png",
      "cube4.png",
      "cube5.png",
      "cube6.png"
  ] );
skyboxCubemap.format = THREE.RGBFormat;


// Materials

// Q1 HINT : Pass the uniforms - colorMap, normalMap, etc. to the floorMaterial
var floorMaterial = new THREE.MeshPhongMaterial();
// Q1 Answer
// Set the right texture to the correct mapping method and THREE.js will do the work.
floorMaterial.map = floorColorTexture;
floorMaterial.normalMap = floorNormalTexture;
floorMaterial.aoMap = floorAOTexture;

// Q2 HINT : Pass the uniforms for blinn-phong shading,
// colorMap, normalMap etc to the shaderMaterial
var wizardMaterial = new THREE.ShaderMaterial({
  side: THREE.DoubleSide,
  uniforms: {
    // Q2 Answer
    // Pass in the needed uniforms
    lightColor: lightColorUniform,
    lightDirection: lightDirectionUniform,
    // Add the other uniforms here
    kDiffuse: kDiffuseUniform,
    kAmbient: kAmbientUniform,
    kSpecular: kSpecularUniform,
    shininess: shininessUniform,
    colorMap: { type: "t", value: wizardColorTexture }
  }
});

// Q3 HINT : Pass the necessary uniforms (skybox and camera position)
var skyboxMaterial = new THREE.ShaderMaterial({
  side: THREE.DoubleSide,
  uniforms: {
    // Q3 Answer
    // Pass in the needed uniforms
    cameraPosition: cameraPositionUniform,
    skyboxCubemap: {type: "t", value: skyboxCubemap}
  }
});

// Q4 HINT : Pass the necessary uniforms
var envmapMaterial = new THREE.ShaderMaterial({
  uniforms: {
    // Q4 Answer
    // Pass in the needed uniforms
    cameraPosition: cameraPositionUniform,
    skyboxCubemap: {type: "t", value: skyboxCubemap}
  }
});

// Load shaders
var shaderFiles = [
  'glsl/skybox.vs.glsl',
  'glsl/skybox.fs.glsl',

  'glsl/envmap.vs.glsl',
  'glsl/envmap.fs.glsl',

  'glsl/wizard.vs.glsl',
  'glsl/wizard.fs.glsl'
];

new THREE.SourceLoader().load(shaderFiles, function(shaders) {
  wizardMaterial.vertexShader = shaders['glsl/wizard.vs.glsl'];
	wizardMaterial.fragmentShader = shaders['glsl/wizard.fs.glsl'];

	skyboxMaterial.vertexShader = shaders['glsl/skybox.vs.glsl'];
	skyboxMaterial.fragmentShader = shaders['glsl/skybox.fs.glsl'];

  envmapMaterial.vertexShader = shaders['glsl/envmap.vs.glsl'];
  envmapMaterial.fragmentShader = shaders['glsl/envmap.fs.glsl'];
});

// var ctx = renderer.context;
// stops shader warnings, seen in some browsers
// ctx.getShaderInfoLog = function () { return '' };

// Loaders for object geometry
// Load the pixel gltf
const gltfFileName = "gltf/pixel_v4.glb";
let object
{
    const gltfLoader = new THREE.GLTFLoader();
    gltfLoader.load(gltfFileName, (gltf) => {
      object = gltf.scene;
      object.traverse( function ( child ) {

        if (child instanceof THREE.Mesh) 
        {
            child.material = wizardMaterial;
            // Q5 : Enable shadows for the gltf model
            // This is already done for you, as you aren't familiar with the gltf loader
            child.castShadow = true;
        }

      } );
      object.scale.set(10.0, 10.0, 10.0);
      scene.add( object );
    });
}

var terrainGeometry = new THREE.PlaneBufferGeometry(20, 20);
var terrain = new THREE.Mesh(terrainGeometry, floorMaterial);
// Q5 HINT: Enable the terrain to recieve shadows
// here
// Q5 Answer
// let the terrain to receive Shadow
terrain.receiveShadow = true;
terrain.rotation.set(- Math.PI / 2, 0, 0);
scene.add(terrain);

// Q3 :  create the geometry for the skybox and link it with the skyboxMaterial
// Q3 Answer
// Create a box as instructed and set its geometry and material.
var skyboxGeometry = new THREE.BoxGeometry( 1000, 1000, 1000 );
var skybox = new THREE.Mesh(skyboxGeometry, skyboxMaterial);
scene.add(skybox);

// Q4 : Sphere for environment mapping 
var sphereGeometry = new THREE.SphereGeometry(1, 32, 32);
var sphere = new THREE.Mesh(sphereGeometry, envmapMaterial);
// Q5 : Enable shadows for the environment mapped sphere
// Q5 Answer
// let the sphere to cast shadow
sphere.castShadow = true;
sphere.position.set(0, 1, 5);
scene.add(sphere);

// Input
var keyboard = new THREEx.KeyboardState();

function checkKeyboard() {
  if (keyboard.pressed("A"))
    light.position.x -= 0.2;
  if (keyboard.pressed("D"))
    light.position.x += 0.2;
  if (keyboard.pressed("W"))
    light.position.y += 0.2;
  if (keyboard.pressed("S"))
    light.position.y -= 0.2;

  lightDirection.copy(light.position);
  lightDirection.sub(light.target.position);
  
}

function updateMaterials() {
  envmapMaterial.needsUpdate = true;
  wizardMaterial.needsUpdate = true;
  skyboxMaterial.needsUpdate = true;
}

// Update routine
function update() {
	checkKeyboard();
	updateMaterials();
  cameraPositionUniform.value = camera.position;

	requestAnimationFrame(update);
  renderer.clear();
  renderer.render(scene, camera);
}

resize();
update();
