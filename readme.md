# Particle Tracking for Passive Microrheology in Weitz Lab

This particle tracking software was designed to enhance the efficiency of 2-D particle tracking specifically for passive microrheology in Weitz lab. However, it also could be used for other purposes that require accurate particle tracking. It's based on the MATLAB code originally developed by Prof. Maria Kilfoil and has been further optimized to work more swiftly and effectively, especially with large TIFF files. Notably, this tool outperforms the FIJI tracking package in both speed and accuracy and is fine-tuned to run parallelly on a Linux cluster.

Our tool has been developed and played instrumental role in the following research works:
- Wu, Huayin, et al. ["Effect of divalent cations on the structure and mechanics of vimentin intermediate filaments."](https://www.cell.com/biophysj/pdf/S0006-3495(20)30417-3.pdf) _Biophysical Journal_, 119.1 (2020): 55-64.
  
- Shen, Yinan, et al. ["Effects of vimentin intermediate filaments on the structure and dynamics of in vitro multicomponent interpenetrating cytoskeletal networks."](https://journals.aps.org/prl/abstract/10.1103/PhysRevLett.127.108101) _Physical Review Letters_, 127.10 (2021): 108101.

Please cite these articles if you find our tools useful.

## Breakdown of `microrheology_analyze_1.m`:

### 1. Initialization
This segment reads the pre-set parameters from `Parameters_Define.m` into memory. These parameters encompass:
- Video path
- Code path
- Number of frames
- FPS
- Key parameters for particle recognition, selection, and tracking

Concurrently, a directory is established within the video's path to store both parameters and the resultant data.

### 2. Importing Video
Leveraging the TIFF importing algorithm by Tristan Ursell, this module imports extensive TIFF files. By default, the frame number for every TIFF is set as a constant in `Parameters_Define.m` for streamlined access.

There are two versions based on how the imported video is stored:
- **Hard Drive Version:** This method saves each TIFF frame to a `frame#.mat` file in the result directory. Later, the software reads and subsequently deletes `frame#.mat`. This mode requires less than 3GB of memory for a 40GB TIFF and has a typical runtime of approximately 2.5 hours for a 40GB TIFF.
  
- **Memory Version:** The entire TIFF is saved directly in memory, necessitating between 100-120GB of memory for a 40GB TIFF. Its runtime is approximately 40 minutes for a 40GB TIFF.

### 3. Evaluating Points
This section recognizes particles on a frame-by-frame basis and then selects these based on previously defined parameters. The principal parameters for particle selection include particle radius, minimum intensity, maximum radius, maximum eccentricity, and distance between particles. The `IdivRg` stands for the minimum acceptable ratio of integrated intensity to the square of the radius of gyration.

Key parameters to adjust include `Particle_Radius`, `Imin`, `eccentricity_uplimit`, and `scale_limit_distance`.

### 4. Tracking
Particle tracking employs `trackmen.m`. Significant parameters to fine-tune here are `TRACK_maxdis`, `TRACK_goodenough`, and `TRACK_memory`.

### 5. Display
The tracked particles in the initial frame are circled and saved as a JPEG in the result directory. For those employing the 'Hard Drive' version, all `frame#.mat` files are deleted before concluding.

## Additional Tools:

- **Determining Parameters:** 
  - `save_first_frame.m` saves the inaugural frame of a TIFF for parameter determination related to particle recognition.
  - `Analyze_first_fig.m` highlights the particles within a single frame.
  
- **Automation:** 
  - `run_tracking.sh` submits a batch job for individual videos.

We hope this software accelerates your particle tracking endeavors. Feel free to contribute or raise issues on GitHub.
