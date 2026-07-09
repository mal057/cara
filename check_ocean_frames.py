#!/usr/bin/env python3
"""Check ComfyUI ocean frame generation progress and copy completed images."""
import json, os, shutil, urllib.request

COMFYUI_OUTPUT = "/Users/mal/Documents/ComfyUI/output"
ASSETS_DIR = os.path.join(os.path.dirname(__file__), "assets/images/ocean")
QUEUE_FILE = "/tmp/comfyui_ocean_queue.json"

with open(QUEUE_FILE) as f:
    queue = json.load(f)

resp = urllib.request.urlopen("http://127.0.0.1:8000/history")
history = json.loads(resp.read())

resp2 = urllib.request.urlopen("http://127.0.0.1:8000/queue")
qi = json.loads(resp2.read())
running = len(qi.get("queue_running", []))
pending = len(qi.get("queue_pending", []))

completed = 0
copied = 0
for period_name, frame_idx, seed, prompt_id in queue:
    target = f"{period_name}_{frame_idx}.png"
    target_path = os.path.join(ASSETS_DIR, target)
    if prompt_id in history:
        entry = history[prompt_id]
        outputs = entry.get("outputs", {})
        for node_id, node_out in outputs.items():
            images = node_out.get("images", [])
            if images:
                src_filename = images[0].get("filename", "")
                src_subfolder = images[0].get("subfolder", "")
                src_path = os.path.join(COMFYUI_OUTPUT, src_subfolder, src_filename) if src_subfolder else os.path.join(COMFYUI_OUTPUT, src_filename)
                if os.path.exists(src_path):
                    shutil.copy2(src_path, target_path)
                    copied += 1
                    print(f"  Copied: {src_filename} -> {target}")
                break
        completed += 1

print(f"\n{'='*50}")
print(f"  Completed: {completed}/30")
print(f"  Copied to assets: {copied}/30")
print(f"  Queue: {running} running, {pending} pending")
print(f"{'='*50}")

if completed == 30:
    print("\nAll done! Run 'flutter run' to test with the new frames.")
