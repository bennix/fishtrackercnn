%%STEP 1

clear;
%% Configuration
load('config.mat','filenamebase','database','total_frame','total_fish');
%%

N=total_frame;
show_execution_time = 1;
run_javaaddpath = 1;
percentage_update = 0.2;
parfor i = 1 : N
    rand(100, 1);
    
    
end
% show debugging information.
do_debug = 1;
try % Initialization
    ppm = ParforProgressStarter2('detect and generate fish head', N, percentage_update, do_debug, run_javaaddpath, show_execution_time);
catch me % make sure "ParforProgressStarter2" didn't get moved to a different directory
    if strcmp(me.message, 'Undefined function or method ''ParforProgressStarter2'' for input arguments of type ''char''.')
        error('ParforProgressStarter2 not in path.');
    else
        % this should NEVER EVER happen.
        msg{1} = 'Unknown error while initializing "ParforProgressStarter2":';
        msg{2} = me.message;
        print_error_red(msg);
        % backup solution so that we can still continue.
        ppm.increment = nan(1, N);
    end
end

t0 = tic();
parfor frame=1:N
    fprintf('%05d\n',frame)
    [headpoints,headimages]=detect_fish_head2(filenamebase,frame);
    fish_info{frame}.headpoints=headpoints;
    fish_info{frame}.headimages=headimages;
    ppm.increment(frame);
end


h = waitbar(0,'Please wait while writing ...');
mkdir(database);
for frame=1:N
    fishinfo=fish_info{frame};
    % %
    save(sprintf([database '\\fish_info_%d.mat'],frame),'fishinfo');
    waitbar(frame / (N-1), h, sprintf('write frame %5d',frame));
end
close(h);
total_time = toc(t0);

%% clean up
try % use try / catch here, since delete(struct) will raise an error.
    delete(ppm);
catch me %#ok<NASGU>
end


