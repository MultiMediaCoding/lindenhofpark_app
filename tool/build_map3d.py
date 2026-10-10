#!/usr/bin/env python3
"""Baut assets/map3d/{index.html,data.js} aus dem Prototyp 'Lindenhofpark 3D.html'.

Entfernt POV-Modus, Golf-Easter-Egg, Spaziergang-Simulation, Spritzwasser und die
HTML-Oberflaeche (Kopfzeile, Sheet, Werkzeugleiste); die Oberflaeche liegt in Flutter.
"""
import re, sys

SRC = '/Users/Hans/Desktop/Lindenhofpark 3D.html'
OUT = '/Users/Hans/Documents/Development/Apps/Flutter/lindenhofpark/assets/map3d/'

L = open(SRC, encoding='utf-8').read().split('\n')
def line(n): return L[n - 1]          # 1-basiert wie im Editor

# --- Stuetzpunkte pruefen, damit ein geaendertes Original nicht stillschweigend falsch geschnitten wird
assert line(190) == '<script>'
assert line(194).startswith('var DATA = ')
assert line(1436).startswith('// ---------- Auswahl')
assert line(1513).startswith('// ---------- Werkzeuge')
assert line(1520).startswith('// ---------- Schleife')
assert line(1522).startswith('// ---------- Ich-Perspektive')
assert line(1591).startswith('function frame()')
assert line(1620).startswith('// ================= Easter Egg')
assert line(1848).startswith('// ================= Lebendiges Wasser')
assert line(2209).startswith('// ---------- Spritzwasser')
assert line(2243) == 'frame();'
assert line(2246) == '</script>'

# --- data.js
data = line(194)
open(OUT + 'data.js', 'w', encoding='utf-8').write(data + '\n')

# --- CSS
css = '\n'.join(L[3:117])               # Zeilen 4..117 (zwischen <style> und </style>)
assert '</style>' not in css
drop = re.compile(r'^(#pov|#golf|#app\.pov|#app\.golf|#uw|#head|#tools|#sheet|#facts|#where|#close|#near|#credit|#fail|@media|\.panel|button:focus)')
css_kept = [l for l in css.split('\n') if not drop.match(l)]
css = '\n'.join(css_kept)

# --- Script: Bereiche streichen (1-basiert, inklusive)
cut = [
    (194, 194),     # Datenzeile (kommt aus data.js)
    (1436, 1483),   # Auswahl -> neu geschrieben (api.js)
    (1513, 1519),   # Werkzeugleiste
    (1522, 1590),   # Ich-Perspektive
    (1616, 1619),   # updateNear(); window.__park -> neu
    (1620, 1847),   # Golf
    (2209, 2242),   # Spritzwasser + Schwimm-Effekte + Prüfhilfe
]
keep = [True] * (len(L) + 1)
for a, b in cut:
    for n in range(a, b + 1): keep[n] = False
script_lines = [L[n - 1] for n in range(191, 2246) if keep[n]]
script = '\n'.join(script_lines)

def sub(old, new, count=1):
    global script
    assert script.count(old) >= 1, 'nicht gefunden: ' + old[:70]
    if count == 1: assert script.count(old) == 1, 'mehrfach: ' + old[:70]
    script = script.replace(old, new)

# Kopfzeile / Zähler
sub("$('count').textContent = TREES.length; $('kinds').textContent = SP.length;", "")
# Spaziergang & Route
sub("var loc = { x: 0, y: 0 }, walk = null;", "var loc = { x: 0, y: 0, known: false };")
sub("(function () { var p = routeAt(ROUTE_LEN * 0.78); setLoc(p[0], p[1]); })();", "") if "(function () { var p = routeAt" in script else None
# Golf-Reste in den Schatten
sub("noCast(cartG); noCast(golfG);", "")
# Nachtschalter war am Prototyp-Objekt registriert
sub("window.__park.night = setNight; daySky.visible = !night;", "daySky.visible = !night;")
sub("setNight = function (on) { prevNight(on); applyLight(); }; window.__park.night = setNight; applyLight();",
    "setNight = function (on) { prevNight(on); applyLight(); }; applyLight();")
# Weiher-Umriss (stand im Golf-Abschnitt, wird vom Wasser gebraucht)
sub("var BAD = DATA.bad;", "var BAD = DATA.bad;\nvar POND = (FEAT.filter(function (f) { return f.k === 'pond'; })[0] || { p: [] }).p;")
# Tag/Nacht: Schalter lebt in Flutter
sub("$('btn-night').setAttribute('aria-pressed', on ? 'true' : 'false');", "")
sub("$('btn-night').addEventListener('click', function () { setNight(!night); });", "")
# Nadel im Kopf der Schleife
sub(", needle = $('needle');", ";")
# Hauptschleife
_a = script.index('function frame() {'); _b = script.index('  requestAnimationFrame(frame);\n}', _a) + len('  requestAnimationFrame(frame);\n}')
old_frame = script[_a:_b]
new_frame = r'''function frame() {
  if (paused) { running = false; return; }
  var dt = Math.min(clock.getDelta(), 0.05), time = clock.elapsedTime;
  waterTick(time, dt);
  if (targetGoal) { off.copy(targetGoal).sub(controls.target); if (off.length() < 0.05) targetGoal = null; else { off.multiplyScalar(reduce ? 1 : Math.min(1, dt * 5)); controls.target.add(off); camera.position.add(off); } }
  if (tiltGoal !== null || azGoal !== null) {
    off.copy(camera.position).sub(controls.target); sph.setFromVector3(off); var k = reduce ? 1 : Math.min(1, dt * 6);
    if (tiltGoal !== null) { var dphi = tiltGoal - sph.phi; if (Math.abs(dphi) < 0.004) tiltGoal = null; else sph.phi += dphi * k; }
    if (azGoal !== null) { var dth = Math.atan2(Math.sin(azGoal - sph.theta), Math.cos(azGoal - sph.theta)); if (Math.abs(dth) < 0.004) azGoal = null; else sph.theta += dth * k; }
    off.setFromSpherical(sph); camera.position.copy(controls.target).add(off);
  }
  controls.target.x = clamp(controls.target.x, -325, 118); controls.target.z = clamp(controls.target.z, -128, 196);
  var gyT = H(controls.target.x, -controls.target.z), dy = gyT - controls.target.y; controls.target.y += dy; camera.position.y += dy;
  controls.update();
  var floor = H(camera.position.x, -camera.position.z) + 4; if (camera.position.y < floor) camera.position.y = floor;
  var pulse = reduce ? 0 : (time * 0.55) % 1; halo.scale.setScalar(6 + pulse * 5); halo.material.opacity = 0.2 * (1 - pulse) + 0.05;
  var dist = camera.position.distanceTo(controls.target), ks = clamp(dist / 150, 0.55, 2.6); ringW.scale.setScalar(ks); dot.scale.setScalar(ks);
  renderer.render(scene, camera);
  layoutLabels(dist); layoutPlaces(); layoutStars(); stepFx(dt, time);
  if (selected) { v3.set(selected.x, selected.gy + selected.top + 1.2, -selected.y); var s = project(v3); pin.style.visibility = s ? 'visible' : 'hidden'; if (s) pin.style.transform = 'translate(' + s[0].toFixed(1) + 'px,' + s[1].toFixed(1) + 'px)'; }
  off.copy(camera.position).sub(controls.target); reportHeading(Math.atan2(off.x, off.z) * 180 / Math.PI);
  requestAnimationFrame(frame);
}'''
script = script.replace(old_frame, new_frame)
sub("\nframe();", "\n" + open('' + __import__('os').path.join(__import__('os').path.dirname(__file__), 'map3d_api.js') + '', encoding='utf-8').read() + "\nresume(); post({ t: 'ready' });")

# The 'Auswahl' block is gone; api.js redefines select/hit/pointer handling. Resize/labels stay.
html = '''<!doctype html>
<html lang="de"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<title>Lindenhofpark 3D</title>
<style>
''' + css + '''
[hidden] { display: none !important; }
html, body { margin: 0; overscroll-behavior: none; -webkit-user-select: none; user-select: none; -webkit-touch-callout: none; -webkit-tap-highlight-color: transparent; }
.place-pin { position: absolute; left: 0; top: 0; width: 34px; height: 34px; margin: -17px 0 0 -17px; padding: 0; border-radius: 50%; border: 2.5px solid #fff; background: #a2573f; box-shadow: 0 3px 8px rgba(40,50,40,0.3); display: grid; place-items: center; cursor: pointer; will-change: transform; }
.place-pin svg { width: 16px; height: 16px; fill: #fff; }
.star-pin { position: absolute; left: 0; top: 0; width: 26px; height: 26px; margin: -13px 0 0 -13px; padding: 0; border-radius: 50%; border: 2px solid #fff; background: #f2b134; box-shadow: 0 2px 6px rgba(40,50,40,0.35); display: grid; place-items: center; pointer-events: auto; will-change: transform; }
.star-pin svg { width: 14px; height: 14px; fill: #fff; }
#places { position: absolute; inset: 0; pointer-events: none; overflow: hidden; }
.place-pin { pointer-events: auto; }
#fail { position: absolute; inset: 0; display: grid; place-items: center; padding: 24px; text-align: center; color: var(--ink-soft); }
</style></head>
<body>
<div id="app">
  <canvas id="scene" tabindex="-1" aria-label="3D-Karte des Lindenhofparks mit allen Bäumen aus dem Kataster"></canvas>
  <div id="labels" aria-hidden="true"></div>
  <div id="places"></div>
  <div id="pin" hidden aria-hidden="true"><svg viewBox="0 0 34 42" width="34" height="42">
    <path d="M17 41c-1.2 0-2-0.9-2.9-2.6C11.5 33.6 2 29.3 2 17 2 8.7 8.7 2 17 2s15 6.7 15 15c0 12.3-9.5 16.6-12.1 21.4C19 40.1 18.2 41 17 41z" fill="#4fae52" stroke="#fff" stroke-width="2.5"/>
  </svg></div>
  <div id="fail" hidden>Die 3D-Ansicht braucht WebGL, das auf diesem Gerät nicht verfügbar ist.</div>
</div>
<script src="three.min.js"></script>
<script src="OrbitControls.js"></script>
<script src="data.js"></script>
<script>
''' + script + '''
</script>
</body></html>
'''
open(OUT + 'index.html', 'w', encoding='utf-8').write(html)
print('ok', len(html), 'Bytes')
