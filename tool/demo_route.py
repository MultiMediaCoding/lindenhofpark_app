#!/usr/bin/env python3
"""Erzeugt eine Demo-Route entlang der Wege des Lindenhofparks.

Liest die Wege (`feat`, Art `hw`) aus assets/map3d/data.js, baut daraus ein
Wegenetz und findet den kürzesten Weg zwischen den Wegpunkten in WAYPOINTS.
Ausgabe: tool/demo_route.gpx (Xcode: Scheme > Run > Options > Default Location,
oder im Simulator Features > Location > Custom Location/GPX) und optional
direkt im gebooteten Simulator abspielen:

    python3 tool/demo_route.py            # nur GPX schreiben
    python3 tool/demo_route.py --play     # zusätzlich im Simulator abspielen
    python3 tool/demo_route.py --play --speed 4   # schneller (m/s)
"""
import argparse, heapq, json, math, pathlib, subprocess, datetime

ROOT = pathlib.Path(__file__).resolve().parent.parent
# Gleicher Ursprung/Maßstab wie geoToXY in tool/map3d_api.js
LAT0, LON0, KX, KY = 47.55735, 9.6614, 75130, 111320

# Eingang West -> Allee -> Ost -> Nordschleife -> zurück zum Eingang (x/y in m)
WAYPOINTS = [(-288.2, 34.3), (5.7, -51.4), (61.5, 32.3), (16.2, 84.0),
             (-4.7, 75.2), (-60.7, 73.4), (-62.6, 54.4), (-199.1, 0.6),
             (-288.2, 34.3)]
# Treppen und Fahrstraßen meiden, Fußwege bevorzugen
SKIP_HIGHWAYS = {'residential', 'service', 'steps'}


def load():
    s = (ROOT / 'assets/map3d/data.js').read_text()
    return json.loads(s[s.index('{'):s.rindex('}') + 1])


def key(p):
    return (round(p[0], 1), round(p[1], 1))


def build_graph(feat):
    g = {}
    for f in feat:
        if f['k'] != 'hw' or f.get('h') in SKIP_HIGHWAYS:
            continue
        pts = [key(p) for p in f['p']]
        for a, b in zip(pts, pts[1:]):
            d = math.dist(a, b)
            g.setdefault(a, {})[b] = d
            g.setdefault(b, {})[a] = d
    return g


def nearest(g, p):
    return min(g, key=lambda n: math.dist(n, p))


def shortest(g, src, dst):
    dist, prev, q = {src: 0}, {}, [(0, src)]
    while q:
        d, u = heapq.heappop(q)
        if u == dst:
            break
        if d > dist[u]:
            continue
        for v, w in g[u].items():
            if d + w < dist.get(v, 1e18):
                dist[v], prev[v] = d + w, u
                heapq.heappush(q, (d + w, v))
    if dst not in dist:
        raise SystemExit(f'Kein Weg von {src} nach {dst}')
    path = [dst]
    while path[-1] != src:
        path.append(prev[path[-1]])
    return path[::-1]


def resample(path, step):
    out = [path[0]]
    for a, b in zip(path, path[1:]):
        n = max(1, int(math.dist(a, b) // step))
        out += [(a[0] + (b[0] - a[0]) * i / n, a[1] + (b[1] - a[1]) * i / n)
                for i in range(1, n + 1)]
    return out


def to_geo(p):
    return LAT0 + p[1] / KY, LON0 + p[0] / KX


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--play', action='store_true')
    ap.add_argument('--speed', type=float, default=1.6, help='m/s')
    ap.add_argument('--device', default='booted')
    a = ap.parse_args()

    g = build_graph(load()['feat'])
    wps = [nearest(g, w) for w in WAYPOINTS]
    path = [wps[0]]
    for s, d in zip(wps, wps[1:]):
        path += shortest(g, s, d)[1:]
    pts = resample(path, 4.0)
    length = sum(math.dist(p, q) for p, q in zip(pts, pts[1:]))
    print(f'{len(pts)} Punkte, {length:.0f} m, ca. {length / a.speed / 60:.1f} min bei {a.speed} m/s')

    t = datetime.datetime(2026, 1, 1, 12, 0, 0, tzinfo=datetime.timezone.utc)
    rows = []
    for i, p in enumerate(pts):
        if i:
            t += datetime.timedelta(seconds=math.dist(pts[i - 1], p) / a.speed)
        lat, lon = to_geo(p)
        rows.append(f'  <wpt lat="{lat:.7f}" lon="{lon:.7f}"><time>{t:%Y-%m-%dT%H:%M:%SZ}</time></wpt>')
    out = ROOT / 'tool/demo_route.gpx'
    out.write_text('<?xml version="1.0" encoding="UTF-8"?>\n'
                   '<gpx version="1.1" creator="lindenhofpark demo_route.py" '
                   'xmlns="http://www.topografix.com/GPX/1/1">\n'
                   + '\n'.join(rows) + '\n</gpx>\n')
    print('geschrieben:', out.relative_to(ROOT))

    if a.play:
        args = [f'{la:.7f},{lo:.7f}' for la, lo in map(to_geo, pts)]
        subprocess.run(['xcrun', 'simctl', 'location', a.device, 'start',
                        f'--speed={a.speed}', *args], check=True)
        print('Route läuft im Simulator; stoppen mit: xcrun simctl location booted clear')


if __name__ == '__main__':
    main()
