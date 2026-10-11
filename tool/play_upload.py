#!/usr/bin/env python3
"""Lädt ein App Bundle in einen Google-Play-Track hoch.

Aufruf: play_upload.py [aab] [track]
Standard: build/app/outputs/bundle/release/app-release.aab, Track "internal".
Der Service-Account-Schlüssel liegt außerhalb des Repos (PLAY_KEY oder
~/.config/play/lindenhofpark.json). Benötigt google-api-python-client.
"""
import os
import sys

from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaFileUpload

PACKAGE = "com.drinke.lindenhofpark"
KEY = os.environ.get("PLAY_KEY", os.path.expanduser("~/.config/play/lindenhofpark.json"))
aab = sys.argv[1] if len(sys.argv) > 1 else "build/app/outputs/bundle/release/app-release.aab"
track = sys.argv[2] if len(sys.argv) > 2 else "internal"

creds = service_account.Credentials.from_service_account_file(
    KEY, scopes=["https://www.googleapis.com/auth/androidpublisher"])
api = build("androidpublisher", "v3", credentials=creds, cache_discovery=False)

edit = api.edits().insert(packageName=PACKAGE, body={}).execute()
edit_id = edit["id"]
bundle = api.edits().bundles().upload(
    packageName=PACKAGE, editId=edit_id,
    media_body=MediaFileUpload(aab, mimetype="application/octet-stream", resumable=True),
).execute()
code = bundle["versionCode"]
print(f"Bundle hochgeladen, versionCode {code}")

# Apps ohne bisherige Veröffentlichung akzeptieren nur Entwürfe.
for status in ("completed", "draft"):
    try:
        api.edits().tracks().update(
            packageName=PACKAGE, editId=edit_id, track=track,
            body={"track": track, "releases": [{
                "versionCodes": [str(code)], "status": status}]},
        ).execute()
        api.edits().commit(packageName=PACKAGE, editId=edit_id).execute()
        print(f"Track '{track}': Release mit Status '{status}' angelegt")
        break
    except HttpError as e:
        print(f"Status '{status}' abgelehnt: {e.reason}")
        if status == "draft":
            raise
        edit_id = api.edits().insert(packageName=PACKAGE, body={}).execute()["id"]
        api.edits().bundles().upload(
            packageName=PACKAGE, editId=edit_id,
            media_body=MediaFileUpload(aab, mimetype="application/octet-stream"),
        ).execute()
