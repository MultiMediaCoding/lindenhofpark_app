// ---------- Schnittstelle zur Flutter-App ----------
// Flutter ruft ParkApp.* auf und bekommt Ereignisse als JSON über ParkChannel.postMessage:
//   {t:'ready'} · {t:'tree', id} · {t:'place', title} · {t:'heading', deg} · {t:'outside'}
// Puffergröße immer an Layout und Pixeldichte der WebView koppeln (nicht nur an
// window.resize): sonst bleibt der Canvas nach Layoutwechseln im WKWebView zu klein
// und wird unscharf hochskaliert.
(function () {
  var lastW = 0, lastH = 0, lastR = 0;
  function sync() {
    var r = Math.min(window.devicePixelRatio || 1, 2);
    if (canvas.clientWidth !== lastW || canvas.clientHeight !== lastH || r !== lastR) {
      lastW = canvas.clientWidth; lastH = canvas.clientHeight; lastR = r;
      renderer.setPixelRatio(r); resize();
    }
  }
  if (window.ResizeObserver) new ResizeObserver(sync).observe(canvas);
  window.addEventListener('orientationchange', sync);
  sync();
})();
var ParkApp = window.ParkApp = {};
var paused = false, running = false;
function post(msg) { try { if (window.ParkChannel) window.ParkChannel.postMessage(JSON.stringify(msg)); } catch (e) {} }
function resume() { paused = false; if (running) return; running = true; clock.getDelta(); requestAnimationFrame(frame); }
var lastHeading = null, lastHeadingAt = 0;
function reportHeading(deg) {
  var now = performance.now();
  if (lastHeading !== null && (Math.abs(deg - lastHeading) < 0.5 || now - lastHeadingAt < 50)) return;
  lastHeading = deg; lastHeadingAt = now; post({ t: 'heading', deg: deg });
}

// Park-Koordinaten (Meter, x = Ost, y = Nord) <-> WGS84; Ursprung wie im Kataster
var LAT0 = 47.55735, LON0 = 9.6614, KX = 75130, KY = 111320;
function geoToXY(lat, lon) { return [(lon - LON0) * KX, (lat - LAT0) * KY]; }
me.visible = false;

// ---------- Auswahl ----------
var selected = null, pin = $('pin');
// Symbol im Pin: Laub- oder Nadelbaum (t.n = 1 für Nadelbäume).
var PIN_LEAF = '<path d="M12 2.5C7.5 6.5 5.5 10 5.5 14a6.5 6.5 0 0 0 13 0c0-4-2-7.5-6.5-11.5z" fill="#fff"/><path d="M12 20.5V10" stroke="#4fae52" stroke-width="1.6" stroke-linecap="round" fill="none"/>';
var PIN_CONIFER = '<path d="M12 2L6.8 9.5h2.7L5 16h14l-4.5-6.5h2.7z" fill="#fff"/><path d="M11 15.5h2V21h-2z" fill="#fff"/>';
var pinIcon = (function () {
  var g = document.createElementNS('http://www.w3.org/2000/svg', 'g');
  g.setAttribute('transform', 'translate(9.5 9.5) scale(0.625)');
  pin.querySelector('svg').appendChild(g); return g;
})();
function setColor(t, c) { t.mesh.setColorAt(t.slot, c); t.mesh.instanceColor.needsUpdate = true; }
var selBase = 1;
// Fokus: nach der Auswahl heranzoomen und ganz langsam um das Objekt kreisen, bis der Nutzer die Karte anfasst
var focusDist = null, outDist = null, preFocus = null, orbiting = false, ORBIT_SPEED = 0.07, selPlace = null;
// Bäume: nah heran; Bauwerke: weiter weg, damit der ganze Komplex im Bild bleibt. Immer in die schräge 3D-Ansicht.
function startFocus(d) {
  if (!preFocus) preFocus = { dist: camera.position.distanceTo(controls.target), target: controls.target.clone() };
  focusDist = d; outDist = null; orbiting = !reduce;
  if (!is3D) { is3D = true; post({ t: 'tilt', on: true }); }
  tiltGoal = TILT3D;
}
function stopFocus() { focusDist = null; outDist = null; preFocus = null; orbiting = false; }
// Auswahl aufgehoben: wieder auf die Distanz und Position vor dem Heranzoomen hinausfahren
function releaseFocus() {
  var p = preFocus; stopFocus();
  if (!p) return;
  outDist = p.dist; targetGoal = p.target;
}
selRing.material.color.set(0x1fae5a); selRing.material.opacity = 1;
function setPlaceSel(p) {
  if (selPlace) selPlace.el.classList.remove('sel');
  selPlace = p; if (p) p.el.classList.add('sel');
}
function select(t, fly) {
  setPlaceSel(null);
  if (selected) setColor(selected, selected.col.clone().convertSRGBToLinear());
  selected = t; pin.hidden = !t; selRing.visible = !!t;
  if (!t) return;
  pinIcon.innerHTML = t.n ? PIN_CONIFER : PIN_LEAF;
  // Goldgelb statt Grün: der gewählte Baum fällt zwischen 476 grünen sofort auf
  setColor(t, new THREE.Color().setHSL(0.13, 0.9, 0.6).convertSRGBToLinear());
  sit(selRing, t.x, t.y, 0.25); selBase = t.dd * 0.5 + 2.2; selRing.scale.setScalar(selBase);
  if (fly !== false) { targetGoal = new THREE.Vector3(t.x, t.gy, -t.y); startFocus(90); }
}
function stepFx(dt, time) {
  if (selRing.visible) selRing.scale.setScalar(selBase * (1 + 0.1 * Math.sin(time * 4)));
  if (focusDist !== null) {
    off.copy(camera.position).sub(controls.target); var len = off.length();
    if (len > focusDist + 0.5) { off.multiplyScalar((len + (focusDist - len) * Math.min(1, dt * 4)) / len); camera.position.copy(controls.target).add(off); }
  }
  if (outDist !== null) {
    off.copy(camera.position).sub(controls.target); var olen = off.length();
    if (olen >= outDist - 0.5) outDist = null;
    else { off.multiplyScalar((olen + (outDist - olen) * Math.min(1, dt * 3)) / olen); camera.position.copy(controls.target).add(off); }
  }
  if (orbiting && twistAngle === null) turnBy(-ORBIT_SPEED * dt);
  stepTwist(dt);
}

// ---------- Sterne: Bäume mit ausgearbeiteten biologischen Fakten ----------
var STARS = [], starsEl = document.createElement('div');
starsEl.style.cssText = 'position:absolute;inset:0;pointer-events:none;overflow:hidden'; $('app').appendChild(starsEl);
var STAR_ICON = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2.5l2.9 6.1 6.6.8-4.9 4.6 1.3 6.6L12 17.3 6.1 20.6l1.3-6.6L2.5 9.4l6.6-.8z"/></svg>';
ParkApp.setStars = function (ids) {
  STARS.forEach(function (s) { s.el.remove(); }); STARS = [];
  TREES.filter(function (t) { return ids.indexOf(t.id) >= 0; }).forEach(function (t) {
    var el = document.createElement('button'); el.type = 'button'; el.className = 'star-pin'; el.setAttribute('aria-label', t.de + ' mit Wissenswertem'); el.innerHTML = STAR_ICON;
    el.addEventListener('click', function (ev) { ev.stopPropagation(); select(t); post({ t: 'tree', id: t.id }); });
    starsEl.appendChild(el); STARS.push({ t: t, el: el, pos: new THREE.Vector3(t.x, t.gy + t.top + 3.2, -t.y) });
  });
};
function layoutStars() {
  STARS.forEach(function (s) {
    var p = project(s.pos);
    if (p && s.t !== selected) { s.el.style.visibility = 'visible'; s.el.style.transform = 'translate(' + p[0].toFixed(1) + 'px,' + p[1].toFixed(1) + 'px)'; }
    else s.el.style.visibility = 'hidden';
  });
}

// ---------- Orte (historische Stätten) ----------
var PLACES = [], placesEl = $('places');
var PLACE_ICON = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 2 2 8v2h20V8L12 2zM4 11v8H2v2h20v-2h-2v-8h-2v8h-3v-8h-2v8h-2v-8H9v8H6v-8H4z"/></svg>';
function selectPlace(title, quiet) {
  var p = PLACES.filter(function (q) { return q.title === title; })[0]; if (!p) return;
  select(null); targetGoal = new THREE.Vector3(p.x, H(p.x, p.y), -p.y);
  setPlaceSel(p); startFocus(180);
  if (!quiet) post({ t: 'place', title: title });
}
ParkApp.setPlaces = function (list) {
  PLACES.forEach(function (p) { p.el.remove(); }); PLACES = [];
  list.forEach(function (p) {
    var xy = geoToXY(p.lat, p.lon), el = document.createElement('button');
    el.type = 'button'; el.className = 'place-pin'; el.setAttribute('aria-label', p.title); el.innerHTML = PLACE_ICON;
    el.addEventListener('click', function (ev) { ev.stopPropagation(); selectPlace(p.title); });
    placesEl.appendChild(el);
    PLACES.push({ title: p.title, x: xy[0], y: xy[1], el: el, pos: W(xy[0], xy[1], 9) });
  });
};
function layoutPlaces() {
  PLACES.forEach(function (p) {
    var s = project(p.pos);
    if (s) { p.el.style.visibility = 'visible'; p.el.style.transform = 'translate(' + s[0].toFixed(1) + 'px,' + s[1].toFixed(1) + 'px)'; }
    else p.el.style.visibility = 'hidden';
  });
}

// ---------- Antippen ----------
var ray = new THREE.Raycaster(), ndc = new THREE.Vector2(), down = null, touches = {};
function treeAt(ev) {
  var r = canvas.getBoundingClientRect(); ndc.set((ev.clientX - r.left) / r.width * 2 - 1, -((ev.clientY - r.top) / r.height) * 2 + 1); ray.setFromCamera(ndc, camera);
  var h = ray.intersectObjects(pickables, false);
  if (h.length) return h[0].object.userData.list[h[0].instanceId];
  // Fingerkuppe statt Mauszeiger: sonst den Baum nehmen, dessen Krone dem Tipp am nächsten liegt
  var best = null, bd = 26, px = ev.clientX - r.left, py = ev.clientY - r.top;
  TREES.forEach(function (t) {
    var s = project(v3.set(t.x, t.gy + t.trunk + t.ch * 0.5, -t.y)); if (!s) return;
    var d = Math.hypot(s[0] - px, s[1] - py); if (d < bd) { bd = d; best = t; }
  });
  return best;
}
// Kameragefühl: kräftigere Drehung und Zoom, Verdrehen mit zwei Fingern dreht die Karte mit Nachlauf
controls.rotateSpeed = 0.9; controls.zoomSpeed = 1.3; controls.minDistance = 55; controls.panSpeed = 1.1; controls.dampingFactor = 0.1;
var twistAngle = null, twistVel = 0;
function fingers() { var k = Object.keys(touches); return k.length === 2 ? [touches[k[0]], touches[k[1]]] : null; }
function twistOf(f) { return Math.atan2(f[1].y - f[0].y, f[1].x - f[0].x); }
function turnBy(a) { off.copy(camera.position).sub(controls.target).applyAxisAngle(UP, a); camera.position.copy(controls.target).add(off); }
function stepTwist(dt) { if (twistAngle === null && Math.abs(twistVel) > 0.0004) { turnBy(twistVel); twistVel *= Math.pow(0.04, dt); } else if (twistAngle === null) twistVel = 0; }
canvas.addEventListener('pointerdown', function (e) {
  touches[e.pointerId] = { x: e.clientX, y: e.clientY }; canvas.classList.add('grabbing');
  var f = fingers(); twistAngle = f ? twistOf(f) : null; twistVel = 0; azGoal = null; stopFocus();
  down = Object.keys(touches).length === 1 ? { x: e.clientX, y: e.clientY, t: performance.now() } : null;
});
window.addEventListener('pointermove', function (e) {
  if (!touches[e.pointerId]) return; touches[e.pointerId].x = e.clientX; touches[e.pointerId].y = e.clientY;
  var f = fingers(); if (!f || twistAngle === null) return;
  var a = twistOf(f), d = Math.atan2(Math.sin(a - twistAngle), Math.cos(a - twistAngle)); twistAngle = a; turnBy(d); twistVel = d * 0.6 + twistVel * 0.4;
});
function endTouch(e) { delete touches[e.pointerId]; twistAngle = null; }
window.addEventListener('pointercancel', function (e) { endTouch(e); down = null; });
window.addEventListener('pointerup', function (e) {
  endTouch(e); canvas.classList.remove('grabbing');
  var d = down; down = null;
  if (!d || e.target !== canvas || Math.hypot(e.clientX - d.x, e.clientY - d.y) > 8 || performance.now() - d.t > 450) return;
  var t = treeAt(e);
  if (t) { select(t); post({ t: 'tree', id: t.id }); }
  else if (selected || selPlace) { select(null); releaseFocus(); post({ t: 'deselect' }); }
});

// ---------- Aufrufe aus Flutter ----------
ParkApp.selectTree = function (id) { var t = TREES.filter(function (x) { return x.id === id; })[0]; if (t) select(t); };
ParkApp.selectPlace = function (title) { selectPlace(title, true); };
ParkApp.clearSelection = function () { select(null); releaseFocus(); };
ParkApp.setLocation = function (lat, lon) {
  var xy = geoToXY(lat, lon); loc.x = xy[0]; loc.y = xy[1];
  loc.known = xy[0] > -340 && xy[0] < 130 && xy[1] > -200 && xy[1] < 140;       // außerhalb des Parks: kein Punkt
  me.visible = loc.known; if (loc.known) sit(me, loc.x, loc.y, 0);
};
ParkApp.locate = function () { if (!loc.known) { post({ t: 'outside' }); return; } targetGoal = new THREE.Vector3(loc.x, H(loc.x, loc.y), -loc.y); };
ParkApp.toggleTilt = function () { is3D = !is3D; tiltGoal = is3D ? TILT3D : 0.03; return is3D; };
ParkApp.resetNorth = function () { azGoal = 0; };
ParkApp.setNight = function (on) { setNight(!!on); };
ParkApp.pause = function (p) { if (p) paused = true; else resume(); };
