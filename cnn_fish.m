function [net, info,all_nets,nets] = cnn_fish(varargin)

% CNN_CIFAR   Demonstrates MatConvNet on CIFAR-10
%    The demo includes two standard model: LeNet and Network in
%    Network (NIN). Use the 'modelType' option to choose one.

% run(fullfile(fileparts(mfilename('fullpath')), ...
%   '..', 'matlab', 'vl_setupnn.m')) ;
load('config.mat','filenamebase','database','total_frame','total_fish');
opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

switch opts.modelType
  case 'lenet'
    opts.train.learningRate = 0.005;
    %opts.train.weightDecay = 0.0001 ;
  case 'nin'
    opts.train.learningRate = [0.5*ones(1,30) 0.1*ones(1,10) 0.02*ones(1,10)] ;
    opts.train.weightDecay = 0.0005 ;
  otherwise
    error('Unknown model type %s', opts.modelType) ;
end
opts.expDir = fullfile([database '\'], sprintf('2fish_%s', opts.modelType)) ;


opts.train.numEpochs = 20 ;


opts.dataDir = fullfile([database '\'],'fish') ;
opts.imdbPath = fullfile(opts.expDir, 'imdb.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.train.batchSize = 500 ;
opts.train.continue = false ;
opts.train.gpus = 1 ;
opts.train.expDir = opts.expDir ;
opts.plotDiagnostics =0;
opts = vl_argparse(opts, varargin) ;
if exist(opts.imdbPath, 'file')
    imdb = load(opts.imdbPath) ;
else
    opts.fishnum=total_fish;
    imdb = getFishImdb(opts) ;
    mkdir(opts.expDir) ;
    save(opts.imdbPath, '-struct', 'imdb') ;
end
% --------------------------------------------------------------------
%                                               Prepare data and model
% --------------------------------------------------------------------
net_count=1;
opts.fishnum=total_fish;
for lay1num=25:5:35
    for lay2num=40:10:60
        for lay3num=400:200:800
            opts.lay1num=lay1num;
            opts.lay2num=lay2num;
            opts.lay3num=lay3num;
            fprintf('Configure %d %d %d \n',[lay1num,lay2num,lay3num])
            switch opts.modelType
                case 'lenet', net = cnn_fish_init_optsfish(opts) ;
                    %case 'nin',   net = cnn_cifar_init_nin(opts) ;
            end
            
            
            
            % --------------------------------------------------------------------
            %                                                                Train
            % --------------------------------------------------------------------
            
            [net, info] = cnn_train(net, imdb, @getBatch, ...
                opts.train, ...
                'val', find(imdb.images.set == 3)) ;
            net.imageMean = imdb.images.dataMean ;
            net.layers(end) = [] ;
            
            %  -------------------------------------------------------------------
            %                                                               test
            % ---------------------------------------------------------------------
            imdb_test_idx=find(imdb.images.set == 2);
            M=length(imdb_test_idx);
            predict_id=zeros(1,M);
            ground_truth_id=imdb.images.labels(imdb_test_idx);
            for m=1:M
                im=imdb.images.data(:,:,1,imdb_test_idx(m));
                im=im-net.imageMean;
                res = vl_simplenn(net, im) ;
                res2=res(end).x(:);
                [~,midx]=max(res2);
                predict_id(m)=midx;
            end
            nets{net_count}=net;
            all_nets(net_count,1)=lay1num;
            all_nets(net_count,2)=lay2num;
            all_nets(net_count,3)=lay3num;
            all_nets(net_count,4)=sum(predict_id~=ground_truth_id)/M;
            net_count=net_count+1;
        end
    end
end

[~,idx]=min(all_nets(:,4));
net=nets{idx};
save('fishcnn2.mat', '-struct', 'net') ;