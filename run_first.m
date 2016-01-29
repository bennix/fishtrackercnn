clear;
filenamebase='/home/bennix/fish/Master Camera/CoreView_256_Master_Camera_%05d.bmp';
database='/home/bennix/fish/data';
total_frame=2000;
total_fish=14;
save('config.mat','filenamebase','database','total_frame','total_fish');
gen_fish_head_series
make_pairs_script
gen_trajectories_segments
