# JWST Star Clustering

Image-processing pipeline that decomposes the James Webb Space Telescope
image of **Stephan's Quintet** into separate structural layers — stars,
dust, and galaxies — as a preprocessing step toward clustering the stars.

## How it works

The pipeline works on the **value (brightness) channel** of the image in
HSV space and uses Gaussian filtering to isolate features by spatial scale:

| Stage | Technique | Output |
|-------|-----------|--------|
| Denoise | 3×3 Gaussian (σ = 0.5) | cleaned RGB |
| HSV split | `rgb2hsv` | hue / saturation / value channels |
| **Stars** | high-pass: `value − blur(value, σ=8)` | small, sharp point sources |
| **Dust** | narrow band-pass: `blur(σ=18) − blur(σ=1)` | mid-scale diffuse structure |
| **Galaxies** | wide band-pass: `blur(σ=18) − blur(σ=100)` | large-scale diffuse structure |

Each band-pass subtracts a more-blurred version of the value channel from a
less-blurred one, keeping only structure that lives at the scales between
the two blur radii. All stages are displayed together in a 3×6 subplot grid.

## Project layout

```
JWST-StarClustering/
├── images/
│   └── stephans_quintet.jpg   # source JWST image
├── src/
│   └── star_clustering.m      # main pipeline script
├── results/                   # generated outputs (git-ignored)
└── README.md
```

## Requirements

- MATLAB
- Image Processing Toolbox (`fspecial`, `imfilter`, `rgb2hsv`,
  `imgaussfilt`, `imsubtract`, `mat2gray`)

## Running

From the MATLAB command window (the script resolves paths relative to
itself, so it works from any current directory):

```matlab
run('src/star_clustering.m')
```

Or open `src/star_clustering.m` in the MATLAB editor and press **Run**.

With `SAVE_RESULTS = true` (the default), the script writes to `results/`:

- `overview.png` — the full 3×6 stage grid
- `value_channel.png` — the brightness channel
- `stars.png` — isolated stars layer
- `dust.png` — isolated dust layer
- `galaxies.png` — isolated galaxies layer

Set `SAVE_RESULTS = false` at the top of the script to only display the
figure without writing files.
