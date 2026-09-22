import math
import wave
import struct
import random
import os

SAMPLE_RATE = 22050
DURATION_SEC = 45
TOTAL_SAMPLES = int(SAMPLE_RATE * DURATION_SEC)

os.makedirs('assets/audio', exist_ok=True)

def write_wav(filename, samples):
    with wave.open(filename, 'w') as wav_file:
        wav_file.setnchannels(1)        # mono
        wav_file.setsampwidth(2)        # 16-bit
        wav_file.setframerate(SAMPLE_RATE)
        # Apply seamless cross-fade at ends (first 1.5s and last 1.5s)
        fade_len = int(SAMPLE_RATE * 1.5)
        n = len(samples)
        for i in range(fade_len):
            alpha = i / fade_len
            # blend end into beginning for perfect loop
            blended = samples[i] * alpha + samples[n - fade_len + i] * (1.0 - alpha)
            samples[i] = blended
            samples[n - fade_len + i] = blended

        raw_data = bytearray()
        for s in samples:
            clamped = max(-1.0, min(1.0, s))
            int_val = int(clamped * 32767)
            raw_data.extend(struct.pack('<h', int_val))
        wav_file.writeframes(raw_data)
    print(f"Generated {filename} ({len(samples)} samples, {len(raw_data)} bytes)")

# 1. Courtyard Rain: pink noise with soft low-pass filter and occasional gentle droplets
def generate_courtyard_rain():
    random.seed(42)
    samples = [0.0] * TOTAL_SAMPLES
    b0, b1, b2, b3, b4, b5, b6 = 0, 0, 0, 0, 0, 0, 0
    # Pink noise filter approximation
    for i in range(TOTAL_SAMPLES):
        white = random.uniform(-1.0, 1.0)
        b0 = 0.99886 * b0 + white * 0.0555179
        b1 = 0.99332 * b1 + white * 0.0750759
        b2 = 0.96900 * b2 + white * 0.1538520
        b3 = 0.86650 * b3 + white * 0.3104856
        b4 = 0.55000 * b4 + white * 0.5329522
        b5 = -0.7616 * b5 - white * 0.0168980
        pink = (b0 + b1 + b2 + b3 + b4 + b5 + b6 + white * 0.5362) * 0.05
        b6 = white * 0.115926
        samples[i] = pink

    # Simple low pass to remove harshness above 900 Hz
    alpha = 0.22
    for i in range(1, TOTAL_SAMPLES):
        samples[i] = alpha * samples[i] + (1.0 - alpha) * samples[i - 1]

    # Add soft periodic water drop ripples
    num_droplets = int(DURATION_SEC * 3.5)
    for _ in range(num_droplets):
        drop_pos = random.randint(0, TOTAL_SAMPLES - int(SAMPLE_RATE * 0.4))
        drop_freq = random.uniform(320, 580)
        drop_len = int(SAMPLE_RATE * random.uniform(0.12, 0.25))
        for j in range(drop_len):
            t = j / SAMPLE_RATE
            # Sine droplet with fast exponential decay
            env = math.exp(-t * 28.0) * 0.08
            samples[drop_pos + j] += math.sin(2.0 * math.pi * drop_freq * t) * env

    # Overall amplitude adjustment (gentle, warm background)
    max_val = max(abs(s) for s in samples) or 1.0
    samples = [s / max_val * 0.45 for s in samples]
    write_wav('assets/audio/ambient_courtyard_rain.wav', samples)

# 2. Guqin & Bamboo Wind: soft bamboo wind murmur with sparse traditional Guqin notes
def generate_guqin_bamboo():
    random.seed(108)
    samples = [0.0] * TOTAL_SAMPLES

    # Wind layer: modulated low frequency noise
    w0, w1 = 0.0, 0.0
    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        white = random.uniform(-1.0, 1.0)
        w0 = 0.992 * w0 + white * 0.015
        # Gentle swell (breeze periodicity ~7 seconds)
        breeze = 0.5 + 0.5 * math.sin(2.0 * math.pi * 0.14 * t)
        samples[i] = w0 * breeze * 0.18

    # Guqin pentatonic pitches in traditional Gong/Shang tuning (Hz)
    # D3 (146.8), G3 (196.0), A3 (220.0), C4 (261.6), D4 (293.7), E4 (329.6), G4 (392.0)
    pentatonic = [146.83, 196.00, 220.00, 261.63, 293.66, 329.63, 392.00]
    
    # Place a gentle pluck every 5 to 9 seconds
    cur_pos = int(SAMPLE_RATE * 2.0)
    while cur_pos < TOTAL_SAMPLES - int(SAMPLE_RATE * 4.5):
        freq = random.choice(pentatonic)
        pluck_len = int(SAMPLE_RATE * 4.0)
        pluck_len = min(pluck_len, TOTAL_SAMPLES - cur_pos)
        
        # Guqin string harmonics: fundamental + soft 2nd & 3rd harmonics + wood resonance
        for j in range(pluck_len):
            t = j / SAMPLE_RATE
            env = math.exp(-t * 1.6) * 0.28
            # string harmonics
            tone = (math.sin(2.0 * math.pi * freq * t) * 0.7 +
                    math.sin(2.0 * math.pi * (freq * 2.0) * t) * 0.22 +
                    math.sin(2.0 * math.pi * (freq * 3.0) * t) * 0.08)
            samples[cur_pos + j] += tone * env
        cur_pos += int(SAMPLE_RATE * random.uniform(6.0, 9.5))

    # Low-pass filter to keep it calm and round
    alpha = 0.28
    for i in range(1, TOTAL_SAMPLES):
        samples[i] = alpha * samples[i] + (1.0 - alpha) * samples[i - 1]

    max_val = max(abs(s) for s in samples) or 1.0
    samples = [s / max_val * 0.40 for s in samples]
    write_wav('assets/audio/ambient_guqin_wind.wav', samples)

# 3. Midnight Zen Drone: 432 Hz warm continuous pad with subtle singing bowl harmonics
def generate_midnight_zen():
    samples = [0.0] * TOTAL_SAMPLES
    f0 = 216.0  # Octave below 432 Hz for deep warm base
    f1 = 432.0  # 432 Hz serene resonant center
    f2 = 648.0  # 5th harmonic (warm interval)

    for i in range(TOTAL_SAMPLES):
        t = i / SAMPLE_RATE
        # Slow breathing amplitude modulation (0.08 Hz = ~12 sec breath cycle)
        breath1 = 0.65 + 0.35 * math.sin(2.0 * math.pi * 0.08 * t)
        breath2 = 0.60 + 0.40 * math.sin(2.0 * math.pi * 0.05 * t + 1.2)
        
        # Warm analog drone layers
        s0 = math.sin(2.0 * math.pi * f0 * t) * 0.40 * breath1
        s1 = math.sin(2.0 * math.pi * f1 * t) * 0.35 * breath2
        s2 = math.sin(2.0 * math.pi * f2 * t) * 0.12 * (0.5 + 0.5 * math.sin(2.0 * math.pi * 0.11 * t))

        # Gentle Tibetan singing bowl harmonic chime every 15s
        bowl = 0.0
        phase = (t % 15.0)
        if phase < 6.0:
            bowl_env = math.exp(-phase * 0.8) * 0.15
            bowl = (math.sin(2.0 * math.pi * 864.0 * phase) * 0.6 +
                    math.sin(2.0 * math.pi * 1296.0 * phase) * 0.4) * bowl_env

        samples[i] = (s0 + s1 + s2 + bowl) * 0.45

    max_val = max(abs(s) for s in samples) or 1.0
    samples = [s / max_val * 0.38 for s in samples]
    write_wav('assets/audio/ambient_midnight_zen.wav', samples)

if __name__ == '__main__':
    generate_courtyard_rain()
    generate_guqin_bamboo()
    generate_midnight_zen()
