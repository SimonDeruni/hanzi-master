import math
import struct
import wave
import random
import os

SAMPLE_RATE = 44100

def write_wav(filename, samples):
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with wave.open(filename, 'w') as wav_file:
        wav_file.setnchannels(1)  # Mono
        wav_file.setsampwidth(2)  # 16-bit
        wav_file.setframerate(SAMPLE_RATE)
        packed_data = bytearray()
        for s in samples:
            # Clamp to -1.0 to 1.0
            clamped = max(-1.0, min(1.0, s))
            int_val = int(clamped * 32767.0)
            packed_data.extend(struct.pack('<h', int_val))
        wav_file.writeframes(packed_data)
    print(f"Generated: {filename} ({len(samples)} samples, {len(samples)/SAMPLE_RATE:.2f}s)")

def generate_paper_flip(filename):
    # Gentle, soft paper turn (140ms, low-pass filtered warm rustle, 0.18 peak)
    duration = 0.14
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    
    # Simple 2-pole lowpass filter state
    lp_out = 0.0
    lp_out2 = 0.0
    
    # Cutoff around 800Hz to avoid high hiss
    alpha = 2.0 * math.pi * 750.0 / SAMPLE_RATE
    
    for i in range(n_samples):
        t = i / n_samples
        # Smooth bell envelope: rises in first 25%, falls smoothly
        if t < 0.25:
            env = math.sin(t / 0.25 * (math.pi / 2.0))
        else:
            env = math.cos((t - 0.25) / 0.75 * (math.pi / 2.0)) ** 1.8
        
        # White noise input
        noise = (random.random() * 2.0 - 1.0)
        
        # Dual lowpass filter for warm parchment sound
        lp_out += alpha * (noise - lp_out)
        lp_out2 += alpha * (lp_out - lp_out2)
        
        # Soft paper flutter flutter modulation
        flutter = 1.0 + 0.3 * math.sin(2.0 * math.pi * 35.0 * (i / SAMPLE_RATE))
        val = lp_out2 * env * flutter * 0.18
        samples.append(val)
        
    write_wav(filename, samples)

def generate_seal_stamp(filename):
    # Deep wooden stamp impact (180ms, 120Hz fundamental with fast decay, 0.22 peak)
    duration = 0.18
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Envelope: 4ms linear attack, fast exponential decay
        if t < 0.004:
            env = t / 0.004
        else:
            env = math.exp(-(t - 0.004) * 26.0)
        
        # Low frequency wooden resonance (pitch drops slightly from 140Hz to 105Hz)
        freq = 105.0 + 35.0 * math.exp(-t * 40.0)
        body = math.sin(2.0 * math.pi * freq * t)
        harmonic = 0.3 * math.sin(2.0 * math.pi * (freq * 2.1) * t)
        sub = 0.25 * math.sin(2.0 * math.pi * (freq * 0.5) * t)
        
        # Soft friction click at the very start (heavily low-passed)
        if t < 0.015:
            click = (random.random() * 2.0 - 1.0) * (1.0 - t / 0.015) * 0.15
        else:
            click = 0.0
            
        val = (body + harmonic + sub + click) * env * 0.22
        samples.append(val)
        
    write_wav(filename, samples)

def generate_brush_stroke(filename):
    # Subtle wet ink brush glide (220ms, 450Hz low-passed friction, 0.14 peak)
    duration = 0.22
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    
    lp_out = 0.0
    alpha = 2.0 * math.pi * 550.0 / SAMPLE_RATE
    
    for i in range(n_samples):
        t = i / n_samples
        # Gentle parabolic swell and release
        env = math.sin(t * math.pi) ** 1.5
        
        noise = (random.random() * 2.0 - 1.0)
        lp_out += alpha * (noise - lp_out)
        
        # Subtle silky brush tonal whisper
        whisper = 0.15 * math.sin(2.0 * math.pi * 320.0 * (i / SAMPLE_RATE))
        val = (lp_out + whisper) * env * 0.14
        samples.append(val)
        
    write_wav(filename, samples)

def generate_bell_chime(filename):
    # Deep warm bronze bell / singing bowl (2.0s, warm 432Hz fundamental, gentle overtone, 0.20 peak)
    duration = 2.0
    n_samples = int(SAMPLE_RATE * duration)
    samples = []
    
    f0 = 432.0  # Warm meditative frequency
    f1 = f0 * 2.76 # Non-harmonic bronze overtone
    f2 = f0 * 5.40 # Soft shimmer overtone
    
    for i in range(n_samples):
        t = i / SAMPLE_RATE
        # Soft felt mallet attack (15ms ramp to avoid metallic click)
        if t < 0.015:
            attack = math.sin((t / 0.015) * (math.pi / 2.0))
        else:
            attack = 1.0
            
        # Peaceful long decay
        decay0 = math.exp(-t * 1.6)
        decay1 = math.exp(-t * 2.8)
        decay2 = math.exp(-t * 4.5)
        
        s0 = math.sin(2.0 * math.pi * f0 * t) * decay0
        s1 = 0.18 * math.sin(2.0 * math.pi * f1 * t) * decay1
        s2 = 0.05 * math.sin(2.0 * math.pi * f2 * t) * decay2
        
        val = (s0 + s1 + s2) * attack * 0.20
        samples.append(val)
        
    write_wav(filename, samples)

if __name__ == '__main__':
    base_dir = r"c:\Users\simon\Documents\hanzi_master\assets\audio"
    generate_paper_flip(os.path.join(base_dir, "zen_paper_flip.wav"))
    generate_seal_stamp(os.path.join(base_dir, "zen_seal_stamp.wav"))
    generate_brush_stroke(os.path.join(base_dir, "zen_brush_stroke.wav"))
    generate_bell_chime(os.path.join(base_dir, "zen_bell_chime.wav"))
    print("All 4 Zen SFX generated successfully.")
